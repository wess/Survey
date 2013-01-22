//
//  SurveyForm.m
//  Survey
//
//  Created by Wess Cope on 10/15/12.
//  Copyright (c) 2012 Wess Cope. All rights reserved.
//

#import "SurveyForm.h"
#import "SurveyFormModel.h"
#import "SurveyObjectModelForm.h"
#import "SurveyField.h"

static const char *getPropertyType(objc_property_t property)
{
    const char *attributes = property_getAttributes(property);
    
    char buffer[1 + strlen(attributes)];
    strcpy(buffer, attributes);
    char *state = buffer, *attribute;
    
    while ((attribute = strsep(&state, ",")) != NULL)
    {
        if (attribute[0] == 'T' && attribute[1] != '@')
            return (const char *)[[NSData dataWithBytes:(attribute + 1) length:strlen(attribute) - 1] bytes];
        else if (attribute[0] == 'T' && attribute[1] == '@' && strlen(attribute) == 2)
            return "id";
        else if (attribute[0] == 'T' && attribute[1] == '@')
            return (const char *)[[NSData dataWithBytes:(attribute + 3) length:strlen(attribute) - 4] bytes];
    }
    
    return "";
}

NSDictionary *propertiesForClass(Class klass)
{
    NSMutableDictionary *results = [[NSMutableDictionary alloc] init];
    
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList(klass, &outCount);
    
    for (i = 0; i < outCount; i++)
    {
        objc_property_t property    = properties[i];
        const char *propName        = property_getName(property);
        
        if(propName)
        {
            const char *propType = getPropertyType(property);
            NSString *propertyName = [NSString stringWithUTF8String:propName];
            NSString *propertyType = [NSString stringWithUTF8String:propType];
            [results setObject:propertyType forKey:propertyName];
        }
    }
    
    free(properties);
    return [NSDictionary dictionaryWithDictionary:results];
}

static NSDictionary *errorListDictionary()
{
    static NSDictionary *errorDictionary;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        errorDictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ErrorMessages" ofType:@"plist"]];
    });
    
    return errorDictionary;
}

@interface SurveyForm()
@property (strong, nonatomic) NSArray               *instanceFields;
@property (strong, nonatomic) NSMutableDictionary   *fieldValues;
@property (readwrite, nonatomic) BOOL               fieldsAreValid;

- (SurveyField *)setupFieldObject:(SurveyField *)fieldObject withKey:(NSString *)key;
- (void)validateForm;
@end

@implementation SurveyForm

- (id)init
{
    self = [super init];
    if(self)
    {
        _fieldsAreValid = YES;
        _fieldValues    = [[NSMutableDictionary alloc] init];
    }
    return self;
}

+ (SurveyForm *)formWithSurveyModelName:(NSString *)modelName
{
    SurveyForm *form        = [[self alloc] init];
    SurveyFormModel *model  = (SurveyFormModel *)[[NSClassFromString(modelName) alloc] init];
    form.model              = model;
    
    return form;
}

+ (SurveyForm *)formWithSurveyModelClass:(Class)modelClass
{
    SurveyForm *form        = [[self alloc] init];
    SurveyFormModel *model  = (SurveyFormModel *)[[modelClass alloc] init];
    form.model              = model;
    
    return form;
}

+ (SurveyForm *)formWithSurveyModel:(SurveyFormModel *)modelInstance
{
    SurveyForm *form    = [[self alloc] init];
    form.model          = modelInstance;
    
    return form;    
}

- (SurveyField *)setupFieldObject:(SurveyField *)fieldObject withKey:(NSString *)key
{
    UITextField *field = (UITextField *)fieldObject.field;
    
    if(!field)
        field = (fieldObject.fieldClass)? [[fieldObject.fieldClass alloc] initWithFrame:CGRectZero] : [[UITextField alloc] initWithFrame:CGRectZero];
    
    field.text                          = fieldObject.value;
    field.placeholder                   = fieldObject.placeholder;
    field.secureTextEntry               = fieldObject.isSecure;
    field.autocapitalizationType        = fieldObject.autocapitalizationType;
    field.autocorrectionType            = fieldObject.autocorrectionType;
    field.keyboardType                  = fieldObject.keyboardType;
    field.returnKeyType                 = fieldObject.returnKeyType;
    field.contentHorizontalAlignment    = fieldObject.contentHorizontalAlignment;
    field.contentVerticalAlignment      = fieldObject.contentVerticalAlignment;
    field.clearButtonMode               = fieldObject.clearButtonMode;

    field.delegate                      = fieldObject;

    [fieldObject setField:field];
    
    fieldObject.form        = self;
    fieldObject.label       = (fieldObject.label)? fieldObject.label : key;
    fieldObject.entityName  = key;
        
    
    return fieldObject;
}

- (NSArray *)fields
{
    if(_instanceFields)
        return _instanceFields;
    
    NSArray *fieldList            = [[_model class] fields];
    NSMutableArray *fieldsArray   = [[NSMutableArray alloc] init];

    if(!fieldList || fieldList.count < 1)
    {
        __block NSDictionary *properties = (propertiesForClass([_model class]));
        __block NSUInteger idx = 0;

        [properties enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *propType, BOOL *stop) {
            SurveyField *fieldObject = [self setupFieldObject:(SurveyField *)[_model valueForKey:key] withKey:key];
            [fieldsArray addObject:fieldObject];
            idx++;
        }];
    }
    else
    {
        [fieldList enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop) {
            SurveyField *prop = (SurveyField *)[_model valueForKey:key];
            [fieldsArray addObject:[self setupFieldObject:prop withKey:key]];
        }];
    }
    
    _instanceFields = [fieldsArray copy];
    
    return _instanceFields;
}

- (NSDictionary *)values
{
    if(_fieldValues && _fieldValues.count > 0)
        return _fieldValues;
    
    NSMutableDictionary *fieldValues = [NSMutableDictionary dictionary];
    [[self fields] enumerateObjectsUsingBlock:^(SurveyField *fieldObject, NSUInteger idx, BOOL *stop) {
        [fieldValues setObject:(fieldObject.field.text? fieldObject.field.text : @"") forKey:fieldObject.entityName];
    }];
    
    return [fieldValues copy];
}

- (BOOL)isValid
{
    _fieldsAreValid = YES;
    _fieldErrors    = nil;

    [self validateForm];
    return _fieldsAreValid;
}

- (void)validateForm
{
    NSMutableDictionary *fieldErrorsDict    = [[NSMutableDictionary alloc] init];

    NSArray *fieldArray = [self fields];
    [fieldArray enumerateObjectsUsingBlock:^(SurveyField *fieldObject, NSUInteger idx, BOOL *stop) {
        NSMutableArray *mutableFieldErrors  = [[NSMutableArray alloc] init];
        NSString *value                     = fieldObject.field.text;
        
        if(fieldObject.isRequired && ([value isEqualToString:@""] || !value))
        {
            NSString *requiredError = @"field is required"; //[errorListDictionary() objectForKey:@"required"];
            //            requiredError           = [requiredError stringByReplacingOccurrencesOfString:@"{{field}}" withString:key];
            
            [mutableFieldErrors addObject:requiredError];
            
            _fieldsAreValid = NO;
        }

        if(fieldObject.expression && value && ![value isEqualToString:@""])
        {
            NSTextCheckingResult *matches = [fieldObject.expression firstMatchInString:value options:0 range:NSMakeRange(0, value.length)];

            if(!matches)
                _fieldsAreValid = NO;
            
            NSString *matchError = (fieldObject.errorMessage)? fieldObject.errorMessage : @"Field value did not match pattern";
            [mutableFieldErrors addObject:matchError];
        }

        if(fieldObject.validationBlock != NULL)
        {
            BOOL isValid = fieldObject.validationBlock(fieldObject, self, fieldObject.field, value);
            if(!isValid)
            {
                _fieldsAreValid = NO;
            
                NSString *matchError = (fieldObject.errorMessage)? fieldObject.errorMessage : @"Validation failed";
                [mutableFieldErrors addObject:matchError];
            }
        }
        
        [_fieldValues setObject:((value)? value : @"") forKey:fieldObject.entityName];
        
        if(mutableFieldErrors.count > 0)
        {
            [fieldErrorsDict setObject:[mutableFieldErrors copy] forKey:fieldObject.entityName];
            [mutableFieldErrors removeAllObjects];
        }
    
    }];

    if(fieldErrorsDict.count > 0)
        _fieldErrors = [fieldErrorsDict copy];
}

- (id)valueForField:(NSString *)fieldName
{
    // Using a method like this, because I want to add some cleaning, perhaps?
    return [_fieldValues objectForKey:fieldName];
}

- (SurveyField *)getFieldAtTabIndex:(NSUInteger)index
{
    NSArray *fields = [self fields];
    if(index == 0 || index > fields.count)
        return nil;
    
    return ([fields objectAtIndex:index]? [fields objectAtIndex:index] : nil);
}

- (NSUInteger)getIndexOfField:(SurveyField *)field
{
    return [[self fields] indexOfObject:field];
}

@end
