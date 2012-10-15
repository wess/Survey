//
//  SurveyForm.m
//  Survey
//
//  Created by Wess Cope on 10/15/12.
//  Copyright (c) 2012 Wess Cope. All rights reserved.
//

#import "SurveyForm.h"
#import "SurveyFormModel.h"
#import "SurveyField.h"
#import <objc/runtime.h>

static const char * getPropertyType(objc_property_t property)
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
@property (strong, nonatomic) NSArray *instanceFields;
@property (readwrite, nonatomic) BOOL fieldsAreValid;
- (void)validateForm;
@end

@implementation SurveyForm

- (id)init
{
    self = [super init];
    if(self)
    {
        _fieldsAreValid = YES;
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

- (NSDictionary *)fields
{
    if(_instanceFields)
        return _instanceFields;
    
    NSDictionary *modelProperties = propertiesForClass([_model class]);
    NSMutableArray *fieldsArray   = [[NSMutableArray alloc] init];
    
    [modelProperties enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *propType, BOOL *stop) {
        SurveyField *fieldObject = (SurveyField *)[_model valueForKey:key];

        UITextField *field = (UITextField *)fieldObject.field;
        
        if(!field)
            field = (fieldObject.fieldClass)? [[fieldObject.fieldClass alloc] initWithFrame:CGRectZero] : [[UITextField alloc] initWithFrame:CGRectZero];
        
        field.text          = fieldObject.value;
        field.placeholder   = fieldObject.placeholder;
        
        fieldObject.field = field;
        fieldObject.label = (fieldObject.label)? fieldObject.label : key;

        [fieldsArray addObject:fieldObject];
    }];
    
    _instanceFields = [fieldsArray copy];
    
    return _instanceFields;
}

- (NSDictionary *)values
{
    NSDictionary *modelProperties           = propertiesForClass([_model class]);
    NSMutableDictionary *valuesDictionary   = [[NSMutableDictionary alloc] init];
    
    [modelProperties enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *propType, BOOL *stop) {
        SurveyField *fieldObject = (SurveyField *)[_model valueForKey:key];
        
        [valuesDictionary setObject:fieldObject.value forKey:key];
    }];

    return [valuesDictionary copy];
}

- (BOOL)isValid
{
    [self validateForm];
    return _fieldsAreValid;
}

- (void)validateForm
{
    NSDictionary *modelProperties           = propertiesForClass([_model class]);
    NSMutableDictionary *fieldErrorsDict    = [[NSMutableDictionary alloc] init];
    
    [modelProperties enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *propType, BOOL *stop) {
        NSMutableArray *mutableFieldErrors  = [[NSMutableArray alloc] init];
        SurveyField *fieldObject            = (SurveyField *)[_model valueForKey:key];
        NSString *value                     = fieldObject.value;
        
        if(fieldObject.isRequired && [value isEqualToString:@""])
        {
            NSString *requiredError = [errorListDictionary() objectForKey:@"required"];
            requiredError           = [requiredError stringByReplacingOccurrencesOfString:@"{{field}}" withString:key];
            
            [mutableFieldErrors addObject:requiredError];
            
            _fieldsAreValid = NO;
        }
        
        /** ADD MORE VALIDATORS HERE **/

        if(mutableFieldErrors.count > 0)
        {
            [fieldErrorsDict setObject:[mutableFieldErrors copy] forKey:key];
            [mutableFieldErrors removeAllObjects];
        }
    }];
    
    if(fieldErrorsDict.count > 0)
        _fieldErrors = [fieldErrorsDict copy];
}

@end
