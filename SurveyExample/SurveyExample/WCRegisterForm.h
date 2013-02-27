//
//  WCRegisterForm.h
//  SurveyExample
//
//  Created by Wess Cope on 10/15/12.
//  Copyright (c) 2012 Wess Cope. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Survey/Survey.h>

@interface WCRegisterForm : SurveyForm
@property (strong, nonatomic) SurveyTextField *firstname;
@property (strong, nonatomic) SurveyTextField *lastname;
@property (strong, nonatomic) SurveyTextField *email;
@property (strong, nonatomic) SurveyTextField *city;
@property (strong, nonatomic) SurveyTextField *state;
@property (strong, nonatomic) SurveyTextView *zipcode;
@end
