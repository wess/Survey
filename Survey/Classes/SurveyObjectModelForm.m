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
    }
    return self;
}

- (void)processEntityDescription
{
    NSArray *properties = [self.entityDescription properties];
    [properties enumerateObjectsUsingBlock:^(NSAttributeDescription *attribute, NSUInteger idx, BOOL *stop) {
        NSString *name          = [attribute.name copy];
        NSInteger isOptional    = attribute.isOptional;

        SurveyField *field  = [SurveyField fieldWithPlaceholder:[name capitalizedString]];
        field.isRequired    = ![@(isOptional) boolValue];
        
        [self setValue:field forKey:name];
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
    SurveyForm *form = [self form];
    
    NSMutableArray *formFields = [[NSMutableArray alloc] init];
    
    for(SurveyField *field in form.fields)
        [formFields addObject:field.field];
    
    return [NSArray arrayWithArray:formFields];
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
