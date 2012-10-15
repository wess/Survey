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
@end

@implementation SurveyFormModel

- (SurveyForm *)form
{
    if(!_instanceForm)
        _instanceForm = [SurveyForm formWithSurveyModel:self];
        
    return _instanceForm;
}

@end
