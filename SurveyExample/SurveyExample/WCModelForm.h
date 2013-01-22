//
//  WCModelForm.h
//  SurveyExample
//
//  Created by Wess Cope on 12/14/12.
//  Copyright (c) 2012 Wess Cope. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Survey/SurveyObjectModelForm.h>
#import <Survey/SurveyField.h>

@interface WCModelForm : SurveyObjectModelForm
@property (strong, nonatomic) SurveyField *lastname;
@end
