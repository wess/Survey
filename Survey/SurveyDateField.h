//
//  SurveyDateField.h
//  Survey
//
//  Created by Wess Cope on 11/7/14.
//  Copyright (c) 2014 Wess Cope. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SurveyFieldProtocol.h"
#import "SurveyConstants.h"
#pragma once

@class SurveyForm;

@interface SurveyDateField : UIControl<SurveyFieldProtocol>
@property (weak, nonatomic) id                          delegate;
@property (readonly, nonatomic) NSDate                  *date;
@property (copy, nonatomic) UIFont                      *font;
@property (copy, nonatomic) SurveyValidateFieldBlock    validationBlock;
@property (copy, nonatomic) SurveyTextFieldDidBlock     didBeginEditing;
@property (copy, nonatomic) SurveyTextFieldDidBlock     didEndEditing;
@property (copy, nonatomic) SurveyTextFieldShouldBlock  shouldBeginEditing;
@property (copy, nonatomic) SurveyTextFieldShouldBlock  shouldEndEditing;
@property (copy, nonatomic) SurveyTextFieldShouldBlock  shouldReturn;
@property  (copy, nonatomic) SurveyOnFieldErrorBlock    onError;
@property (strong, nonatomic) SurveyForm                *form;
@property (copy, nonatomic) NSString                    *title;
@property (strong, nonatomic) NSArray                   *validationOptions;
@property (strong, nonatomic) NSMutableDictionary       *errorMessages;
@property (readonly, nonatomic) NSDictionary            *errors;
@property (copy, nonatomic) NSString                    *placeholder;
@property (copy, nonatomic) UIColor                     *placeholderColor;
@property (copy, nonatomic) UIFont                      *placeholderFont;
@property (readonly, nonatomic) id                      nextField;
@property (readonly, nonatomic) id                      previousField;

- (BOOL)isValid;
- (void)moveToPreviousField;
- (void)moveToNextField;

@end
