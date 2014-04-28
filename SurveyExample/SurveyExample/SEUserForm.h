//
//  SEUserForm.h
//  SurveyExample
//
//  Created by Wess Cope on 4/24/14.
//  Copyright (c) 2014 Wess Cope. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Survey/Survey.h>

@interface SEUserForm : SurveyForm
@property (strong, nonatomic) SurveyTextField *username;
@property (strong, nonatomic) SurveyTextField *password;
@end
