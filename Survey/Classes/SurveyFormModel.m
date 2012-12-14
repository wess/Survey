//
//  SurveyFormModel.m
//  Survey
//
//  Created by Wess Cope on 10/15/12.
//  Copyright (c) 2012 Wess Cope. All rights reserved.
//

#import "SurveyFormModel.h"

@interface SurveyFormModel()
@property (strong, nonatomic) SurveyForm *instanceForm;
@property (strong, nonatomic) NSArray *instanceFields;
@end

@implementation SurveyFormModel

- (SurveyForm *)form
{
    if(!_instanceForm)
        _instanceForm = [SurveyForm formWithSurveyModel:self];
    
    return _instanceForm;
}

- (NSArray *)fields
{
    if(_instanceFields)
        return _instanceFields;
    
    SurveyForm *form = [self form];
    
    NSMutableArray *formFields = [[NSMutableArray alloc] init];
    for(SurveyField *field in form.fields)
        [formFields addObject:field.field];
    
    _instanceFields = [NSArray arrayWithArray:formFields];
    return _instanceFields;
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
