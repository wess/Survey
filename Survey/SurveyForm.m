//
//  SurveyForm.m
//  Survey
//
//  Created by Wess Cope on 2/22/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import "SurveyForm.h"
#import "SurveyFields.h"
#import "SurveyValidator.h"
#import "SurveyFieldDelegate.h"

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


@interface SurveyForm()
@end

@implementation SurveyForm
@synthesize fieldReferenceTable = _fieldReferenceTable;
@synthesize fieldDelegate       = _fieldDelegate;
@synthesize errors              = _errors;
@dynamic isValid;

- (id)init
{
    self = [super init];
    if (self)
    {
        self.fieldDelegate          = [[SurveyFieldDelegate alloc] init];
    }
    return self;
}

- (id)activeField
{
	__block id activeField;
	
	[self.fields enumerateObjectsUsingBlock:^(UIResponder *obj, NSUInteger idx, BOOL *stop) {
		if (obj.isFirstResponder) {
			activeField = obj;
			
			*stop = YES;
		}
	}];
	
	return activeField;
}

- (NSUInteger)indexOfField:(id)field
{
    return [self.fields indexOfObject:field];
}

- (id)getFieldAtTabIndex:(NSUInteger)index
{
    if(index == 0 || index > self.fields.count)
        return nil;
    
    return ([self.fields objectAtIndex:index]?: nil);
}

- (id)getFieldWithName:(NSString *)name
{
    __block id result;
    
    [self.fieldReferenceTable enumerateObjectsUsingBlock:^(NSDictionary *fieldObject, NSUInteger idx, BOOL *stop) {
        id field            = fieldObject[@"field"];
        NSString *fieldName = fieldObject[@"name"];
        
        if ([name isEqualToString:fieldName]) {
            result = field;
            
            *stop = YES;
        }
    }];
    
    return result;
}

- (NSArray *)fieldReferenceTable
{
    if(!_fieldReferenceTable || _fieldReferenceTable.count < 1)
    {
        NSDictionary *selfProperties    = propertiesForClass([self class]);
        NSArray *fieldList              = [[self class] fields];
        NSMutableArray *instanceFields  = [NSMutableArray new];
        NSArray *acceptableProperties   = @[@"SurveyTextField", @"SurveyTextView"];
        
        if(fieldList.count < 1)
        {
            [selfProperties enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *propType, BOOL *stop) {
                if([acceptableProperties containsObject:propType])
                {
                    id fieldObject = [self valueForKey:key];

                    if(!fieldObject)
                        fieldObject = [[NSClassFromString(propType) alloc] init];
                    
                    if(![fieldObject valueForKey:@"title"])
                        [fieldObject setValue:key forKey:@"title"];

                    [fieldObject setDelegate:self.fieldDelegate];
                    [fieldObject setForm:self];
                    [instanceFields addObject:@{@"name": key, @"field": fieldObject}];
                }
            }];
        }
        else
        {
            
            [fieldList enumerateObjectsUsingBlock:^(NSString *name, NSUInteger idx, BOOL *stop) {
                id fieldObject = [self valueForKey:name];

                if(!fieldObject)
                {
                    NSString *propType  = [selfProperties objectForKey:name];
                    Class propClass     = NSClassFromString(propType);
                    fieldObject         = [[propClass alloc] initWithFrame:CGRectZero];
                }

                if(![fieldObject valueForKey:@"title"])
                    [fieldObject setValue:name forKey:@"title"];
                
                [fieldObject setDelegate:self.fieldDelegate];
                [fieldObject setForm:self];
                [instanceFields addObject:@{@"name": name, @"field": fieldObject}];
            }];
        }
        
        _fieldReferenceTable = [instanceFields copy];
    }

    return _fieldReferenceTable;
}

- (NSArray *)fields
{
    return [self.fieldReferenceTable valueForKeyPath:@"field"];
}

- (NSDictionary *)values
{
    __block NSMutableDictionary *fieldValues = [NSMutableDictionary new];
    
    [self.fieldReferenceTable enumerateObjectsUsingBlock:^(NSDictionary *fieldObject, NSUInteger idx, BOOL *stop) {
        
        NSString *name  = fieldObject[@"name"];
        id field        = fieldObject[@"field"];
        NSString *value = [field valueForKey:@"text"]?:@"";
        
        
        fieldValues[name] = value;
    }];
    
    return fieldValues;
}

- (BOOL)isValid
{
    __block BOOL isValid                = YES;
    __block NSMutableDictionary *errors = [NSMutableDictionary new];

    [self.fieldReferenceTable enumerateObjectsUsingBlock:^(NSDictionary *fieldObject, NSUInteger idx, BOOL *stop) {
        NSString *name  = fieldObject[@"name"];
        id field        = fieldObject[@"field"];

        if(![field isValid])
        {
            [errors setObject:[field errors] forKey:name];
            isValid = NO;
        }
    }];

    _errors = [errors copy];
    
    return isValid;
}

#pragma mark - For the kids -
+ (NSArray *)fields
{
    /* Override in child */
    return @[];
}

@end









