//
//  SurveyObjectModelForm.m
//  Survey
//
//  Created by Wess Cope on 12/14/12.
//  Copyright (c) 2012 Wess Cope. All rights reserved.
//

#import "SurveyObjectModelForm.h"
#import "SurveyField.h"

@interface SurveyObjectModelForm()
@property (strong, nonatomic) SurveyForm            *instanceForm;
@property (strong, nonatomic) NSEntityDescription   *entityDescription;
- (void)processEntityDescription;
@end

@implementation SurveyObjectModelForm
+ (SurveyObjectModelForm *)formFromEntityDescription:(NSEntityDescription *)entityDescription
{
    SurveyObjectModelForm *this = [[SurveyObjectModelForm alloc] initWithEntityDescription:entityDescription];
    return this;
}

- (id)initWithEntityDescription:(NSEntityDescription *)entityDescription
{
    self = [super init];
    if(self)
    {
        self.properties         = [[NSMutableDictionary alloc] init];
        self.entityDescription  = entityDescription;
        
        [self processEntityDescription];
        
        NSDictionary *classProperties = propertiesForClass([self class]);

        [classProperties enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *propertyType, BOOL *stop) {
            if([[propertyType lowercaseString] isEqualToString:@"surveyfield"])
            {
                SEL selector = NSSelectorFromString(key);
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                [self setValue:[self performSelector:selector] forKey:key];
#pragma clang diagnostic pop
            }
        }];
        
    }
    return self;
}

- (void)processEntityDescription
{
    NSArray *properties = [self.entityDescription properties];
    
    [properties enumerateObjectsUsingBlock:^(NSAttributeDescription *attribute, NSUInteger idx, BOOL *stop) {
        NSInteger isOptional    = attribute.isOptional;

        if(![self getObjectForKey:attribute.name])
        {
            SurveyField *field  = [SurveyField fieldWithPlaceholder:[attribute.name capitalizedString]];
            field.isRequired    = ![@(isOptional) boolValue];

            [self setValue:field forKey:attribute.name];
        }
    }];
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

- (SurveyForm *)form
{
    if(!_instanceForm)
        _instanceForm = [SurveyForm formWithSurveyModel:self];
    
    return _instanceForm;
}

- (NSArray *)fields
{
    return [[[self form] fields] valueForKeyPath:@"field"]; //;[NSArray arrayWithArray:formFields];
}

- (BOOL)isValid
{
    SurveyForm *form = [self form];
    return form.isValid;
}

+ (NSArray *)fields
{
    /* Override in child to ensure field order */
    return @[];
}


@end
