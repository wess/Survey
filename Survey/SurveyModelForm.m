//
//  SurveyModelForm.m
//  Survey
//
//  Created by Wess Cope on 2/22/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import "SurveyModelForm.h"
#import "SurveyFields.h"

#define SURVEY_SELECTOR_SUFFIX   @":"

@interface SurveyModelForm()
@property (strong, nonatomic) NSMutableDictionary *properties;
@property (strong, nonatomic) NSEntityDescription *entityDescription;

- (void)processEntityDescription;
- (void)saveObject:(id)value forKey:(NSString *)key;
- (id)getObjectForKey:(NSString *)key;
@end

@implementation SurveyModelForm

#pragma mark - Invocation Magic -
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    NSMethodSignature *signature = [super methodSignatureForSelector:aSelector];
    if(aSelector == nil)
    {
        NSString *selectorName  = [NSStringFromSelector(aSelector) lowercaseString];
        signature               = [NSMethodSignature signatureWithObjCTypes:(([selectorName hasSuffix:SURVEY_SELECTOR_SUFFIX])? "v@:@" : "@@:")];
    }
    
    return signature;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    NSString *selectorName = [NSStringFromSelector([anInvocation selector]) lowercaseString];
    if([selectorName hasSuffix:SURVEY_SELECTOR_SUFFIX])
    {
        NSString *property = [selectorName substringWithRange:NSMakeRange(3, selectorName.length - 4)];
        id invocationValue;
        [anInvocation getArgument:&invocationValue atIndex:2];
        [self saveObject:invocationValue forKey:property];
    }
    else
    {
        id returnValue = [self getObjectForKey:selectorName];
        [anInvocation setReturnValue:&returnValue];
    }
}

- (void)setValue:(id)value forKey:(NSString *)key
{
    [self.properties setValue:value forKey:key];
}

- (id)valueForKey:(NSString *)key
{
    return [self.properties valueForKey:key];
}

- (void)saveObject:(id)value forKey:(NSString *)key
{
    [self.properties setObject:value forKey:key];
}

- (id)getObjectForKey:(NSString *)key
{
    return [self.properties objectForKey:key];
}

#pragma mark - Actual class methods -

- (void)setup
{
    self.properties         = [[NSMutableDictionary alloc] init];
    
    NSDictionary *classProperties = propertiesForClass([self class]);
    [classProperties enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *propType, BOOL *stop) {
        if([[propType lowercaseString] rangeOfString:@"survey"].location != NSNotFound)
        {
            SEL selector = NSSelectorFromString(key);
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [self setValue:[self performSelector:selector] forKey:key];
#pragma clang diagnostic pop
        }
    }];
    
    [self processEntityDescription];
}

- (id)initWithEntityName:(NSString *)entityName
{
    self = [super init];
    if(self)
    {
        self.entityDescription  = [NSEntityDescription entityForName:entityName inManagedObjectContext:[[self class] managedObjectContext]];
        [self setup];
    }
    return self;
}

- (id)initWithEntityDescription:(NSEntityDescription *)entityDescription
{
    self = [super init];
    if(self)
    {
        self.entityDescription = entityDescription;
        [self setup];
    }
    return self;
}

- (void)processEntityDescription
{
    NSArray *properties = [self.entityDescription properties];
    [properties enumerateObjectsUsingBlock:^(NSAttributeDescription *attribute, NSUInteger idx, BOOL *stop) {
        
        //attributeValueClassName.
        
        BOOL isOptional = [@(attribute.isOptional) boolValue];
        
        if(![self getObjectForKey:attribute.name])
        {
            SurveyTextField *field = [[SurveyTextField alloc] init];
//            field.text = (attribute.defaultValue)?:@"";
            
            if(!isOptional)
                field.validationOptions = @[SurveyValidationRequired];
            
            [self setValue:field forKey:attribute.name];
        }
    }];
}

- (NSArray *)fields
{
    __block NSMutableArray *fieldsArray = [[NSMutableArray alloc] init];
    [self.properties enumerateKeysAndObjectsUsingBlock:^(NSString *name, id fieldObject, BOOL *stop) {
        if(![fieldObject valueForKey:@"title"])
            [fieldObject setValue:name forKey:@"title"];
        
        [fieldObject setDelegate:self.fieldDelegate];
        [fieldsArray addObject:@{@"name": name, @"field": fieldObject}];
    }];
    

    self.fieldReferenceTable = [fieldsArray copy];
    
    return [self.fieldReferenceTable valueForKeyPath:@"field"];
}

+ (NSManagedObjectContext *)managedObjectContext
{
    @throw [NSException exceptionWithName:@"com.Survey.ModelForm.Error" reason:@"SurveyModelForm subclass requires managedObjectContext method to be overidden" userInfo:nil];
    return nil;
}
@end














