//
//  WCRegisterForm.h
//  SurveyExample
//
//  Created by Wess Cope on 10/15/12.
//  Copyright (c) 2012 Wess Cope. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Survey/Survey.h>

@interface WCRegisterForm : SurveyFormModel
@property (strong, nonatomic) SurveyField *firstname;
@property (strong, nonatomic) SurveyField *lastname;
@property (strong, nonatomic) SurveyField *email;
@property (strong, nonatomic) SurveyField *city;
@property (strong, nonatomic) SurveyField *state;
@property (strong, nonatomic) SurveyField *zipcode;
@end
