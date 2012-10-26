//
//  SurveyFormModel.h
//  Survey
//
//  Created by Wess Cope on 10/15/12.
//  Copyright (c) 2012 Wess Cope. All rights reserved.
//

#import "SurveyForm.h"
#import "SurveyField.h"
#import "SurveyEmailField.h"

@class SurveyForm;
@interface SurveyFormModel : NSObject
@property (readonly, nonatomic) SurveyForm *form;
@property (readonly, nonatomic) NSArray *fields;
@property (readonly, nonatomic) BOOL isValid;
+ (NSArray *)fields;
@end
