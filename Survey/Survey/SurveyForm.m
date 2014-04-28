//
//  SurveyForm.m
//  Survey
//
//  Created by Wess Cope on 4/24/14.
//  Copyright (c) 2014 Wess Cope. All rights reserved.
//

#import "SurveyForm.h"
#import "SurveyFieldDelegate.h"
#import <objc/runtime.h>
#import "SurveyTextField.h"

@interface SurveyForm()
@property (strong, nonatomic) SurveyFieldDelegate   *fieldDelegate;
@property (strong, nonatomic) NSOrderedSet          *fieldSet;
@property (readonly, nonatomic) NSDictionary        *classProperties;
@property (copy, nonatomic) NSDictionary            *fieldValueDefaults;
@property (copy, nonatomic) NSDictionary            *fieldDefaults;

- (void)loadDefaultsForFormFields;
- (id<SurveyFieldProtocol>)defaultFieldWithName:(NSString *)name;
- (void)addDefault:(NSString *)name withObject:(id)object;
@end

@implementation SurveyForm
@synthesize validator       = _validator;
@synthesize fields          = _fields;
@synthesize classProperties = _classProperties;

- (instancetype)init
{
    self = [super init];
    return self;
}

- (instancetype)initWithDefaultValues:(NSDictionary *)defaults
{
    self = [super init];
    if (self)
    {
        self.fieldValueDefaults = defaults;
        [self loadDefaultsForFormFields];
    }

    return self;
}

- (void)loadDefaultsForFormFields
{
    NSString *setupSelectorString   = [NSString stringWithFormat:@"setupFormDefaults:"];
    SEL setupSelector               = NSSelectorFromString(setupSelectorString);
    
    if([[self class] respondsToSelector:setupSelector])
    {
        NSInvocation *invocation    = [NSInvocation invocationWithMethodSignature:[[self class] methodSignatureForSelector:setupSelector]];
        invocation.target           = [self class];
        invocation.selector         = setupSelector;
        
        SurveyForm *form = self;
        
        [invocation setArgument:&form atIndex:2];
        [invocation invoke];
    }
}

- (id<SurveyFieldProtocol>)defaultFieldWithName:(NSString *)name
{
    NSString *type                  = [self.classProperties objectForKey:name];
    Class class                     = NSClassFromString(type);
    id<SurveyFieldProtocol> field   = [[class alloc] initWithFrame:CGRectZero];
    
    [((NSObject *)field) setValue:self forKeyPath:@"form"];
    [((NSObject *)field) setValue:self.fieldDelegate forKeyPath:@"delegate"];
    
    if(self.fieldDefaults && [self.fieldValueDefaults objectForKey:name])
        [((NSObject *)field) setValue:self.fieldValueDefaults[name] forKeyPath:@"text"];

    [self.fieldDefaults enumerateKeysAndObjectsUsingBlock:^(NSString *key, id obj, BOOL *stop) {
       [((NSObject *)field) setValue:obj forKeyPath:key];
    }];
    
    return (id<SurveyFieldProtocol>)field;
}

- (void)addDefault:(NSString *)name withObject:(id)object
{
    NSMutableDictionary *defaults   = self.fieldDefaults? [self.fieldDefaults mutableCopy] : [[NSMutableDictionary alloc] init];
    defaults[name]                  = [object copy];
    
    self.fieldDefaults = [defaults copy];
}

#pragma mark - Setters
static NSString *const defaultFieldFontKey         = @"font";
static NSString *const defaultFieldTextColorKey    = @"textColor";
static NSString *const defaultPlaceholderFontKey   = @"placeholderFont";
static NSString *const defaultPlaceholderColorKey  = @"placeholderColor";
static NSString *const defaultValidationOptionsKey = @"validationOptions";
static NSString *const defaultErrorMessagesKey     = @"errorMessages";
static NSString *const defaultOnErrorKey           = @"onError";

- (void)setDefaultFieldFont:(UIFont *)font
{
    [self addDefault:defaultFieldFontKey withObject:font];
}

- (void)setDefaultFieldTextColor:(UIColor *)color
{
    [self addDefault:defaultFieldTextColorKey withObject:color];
}

- (void)setDefaultPlaceholderFont:(UIFont *)font
{
    [self addDefault:defaultPlaceholderFontKey withObject:font];
}

- (void)setDefaultPlaceholderColor:(UIColor *)color
{
    [self addDefault:defaultPlaceholderColorKey withObject:color];
}

- (void)setDefaultValidationOptions:(NSArray *)options
{
    [self addDefault:defaultValidationOptionsKey withObject:options];
}

- (void)setDefaultErrorMessages:(NSDictionary *)messages
{
    [self addDefault:defaultErrorMessagesKey withObject:messages];
}

- (void)setDefaultOnError:(SurveyOnFieldErrorBlock)block
{
    [self addDefault:defaultOnErrorKey withObject:block];
}


#pragma mark - Getters
- (SurveyFieldDelegate *)fieldDelegate
{
    if(_fieldDelegate)
        return _fieldDelegate;
    
    _fieldDelegate = [[SurveyFieldDelegate alloc] init];
    
    return _fieldDelegate;
}

- (NSOrderedSet *)fieldSet
{
    if(_fieldSet)
        return _fieldSet;
    
    NSArray *fieldOrder             = [[self class] fields];
    NSMutableOrderedSet *fieldSet   = [[NSMutableOrderedSet alloc] init];
    
    [fieldOrder enumerateObjectsUsingBlock:^(NSString *name, NSUInteger idx, BOOL *stop) {
        id<SurveyFieldProtocol> field   = [self defaultFieldWithName:name];
        
        if(self.fieldDefaults && [self.fieldDefaults objectForKey:name])
            [((NSObject *)field) setValue:self.fieldDefaults[name] forKeyPath:@"text"];
        
        NSString *setupSelectorString   = [NSString stringWithFormat:@"setup%@:", name.capitalizedString];
        SEL setupSelector               = NSSelectorFromString(setupSelectorString);
        
        if([[self class] respondsToSelector:setupSelector])
        {
            NSInvocation *invocation    = [NSInvocation invocationWithMethodSignature:[[self class] methodSignatureForSelector:setupSelector]];
            invocation.target           = [self class];
            invocation.selector         = setupSelector;
            
            [invocation setArgument:&field atIndex:2];
            [invocation invoke];
        }
        
        field.title = field.title?: name;
        
        [fieldSet addObject:@{@"name": name.lowercaseString, @"field": field}];
    }];
    
    _fieldSet = [fieldSet copy];
    
    
    return _fieldSet;
}

- (NSDictionary *)classProperties
{
    if(_classProperties)
        return _classProperties;
    
    _classProperties = [[self class] survey_classProperties];
    
    return _classProperties;
}

- (SurveyValidator *)validator
{
    if(_validator)
        return _validator;
    
    _validator = [[SurveyValidator alloc] init];
    
    return _validator;
}

- (NSArray *)fields
{
    return [self.fieldSet.objectEnumerator.allObjects valueForKeyPath:@"field"];
}

- (id)currentField
{
    __block id result;
    [self.fieldSet enumerateObjectsUsingBlock:^(UIResponder *obj, NSUInteger idx, BOOL *stop) {
        if(obj.isFirstResponder)
        {
            result  = obj;
            *stop   = YES;
        }
    }];
    
    return result;
}

- (BOOL)isValid
{
    __block BOOL isValid = YES;
    __block NSMutableDictionary *errors = [[NSMutableDictionary alloc] init];
    
    [self.fieldSet enumerateObjectsUsingBlock:^(NSDictionary *item, NSUInteger idx, BOOL *stop) {
        NSString *name                  = item[@"name"];
        id<SurveyFieldProtocol> field   = item[@"field"];
        
        if(![field isValid])
        {
            [((UIResponder *)field) resignFirstResponder];
            
            errors[name]    = [field.errors copy];
            isValid         = NO;
        }
    }];
    
    _errors = [errors copy];
    
    return isValid;
}

#pragma mark - Class Methods
+ (NSArray *)fields
{
    SurveyOverrideSelectorInSubclass(_cmd);
    return @[];
}

#pragma mark - ForwardInnvocation
static NSString *const selectorSuffix = @":";

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    NSMethodSignature *signature = [super methodSignatureForSelector:aSelector];
    
    if(![self respondsToSelector:aSelector])
    {
        NSString *selectorName  = [NSStringFromSelector(aSelector) lowercaseString];
        signature               = [NSMethodSignature signatureWithObjCTypes:(([selectorName hasSuffix:selectorSuffix])? "v@:@" : "@@:")];
    }
    
    return signature;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    NSString *selectorName = [NSStringFromSelector([anInvocation selector]) lowercaseString];
    
    if(![selectorName hasSuffix:selectorSuffix])
    {
        id returnValue = [self getObjectForKey:selectorName];
        [anInvocation setReturnValue:&returnValue];
    }
}

- (NSDictionary *)fieldObjectForName:(NSString *)name
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", name.lowercaseString];
    NSOrderedSet *fieldSet = [self.fieldSet filteredOrderedSetUsingPredicate:predicate];
    if(fieldSet.count > 0)
        return fieldSet.lastObject;
    
    return nil;
}

- (id)getObjectForKey:(NSString *)key
{
    NSDictionary *fieldObject = [self fieldObjectForName:key];
    
    if(!fieldObject)
        return nil;
    
    return fieldObject[@"field"];
}

- (id)valueForKey:(NSString *)key
{
    return [self getObjectForKey:key];
}


@end







