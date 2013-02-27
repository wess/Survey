//
//  SurveyTextView.h
//  Survey
//
//  Created by Wess Cope on 2/22/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SurveyDefines.h"

@class SurveyForm;

@interface SurveyTextView : UITextView
@property (copy, nonatomic) SurveyValidateFieldBlock    validationBlock;
@property (copy, nonatomic) SurveyTextFieldDidBlock     didBeginEditing;
@property (copy, nonatomic) SurveyTextFieldDidBlock     didEndEditing;
@property (copy, nonatomic) SurveyTextFieldShouldBlock  shouldBeginEditing;
@property (copy, nonatomic) SurveyTextFieldShouldBlock  shouldEndEditing;
@property (copy, nonatomic) SurveyShouldChangeBlock     shouldChangeCharactersInRange;
@property (copy, nonatomic) SurveyTextFieldShouldBlock  shouldClear;
@property (copy, nonatomic) SurveyTextFieldShouldBlock  shouldReturn;
@property (copy, nonatomic) SurveyTextFieldDidBlock     didChange;
@property (copy, nonatomic) SurveyTextFieldDidBlock     didChangeSelection;
@property  (copy, nonatomic) SurveyOnFieldErrorBlock    onError;
@property (strong, nonatomic) SurveyForm                *form;
@property (copy, nonatomic) NSString                    *placeholder;
@property (copy, nonatomic) NSString                    *title;
@property (strong, nonatomic) NSArray                   *validationOptions;
@property (strong, nonatomic) NSMutableDictionary       *errorMessages;
@property (strong, nonatomic) NSDictionary              *errors;

- (BOOL)isValid;
@end
