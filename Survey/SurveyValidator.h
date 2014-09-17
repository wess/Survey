//
//  SurveyValidator.h
//  Survey
//
//  Created by Wess Cope on 4/24/14.
//  Copyright (c) 2014 Wess Cope. All rights reserved.
//

#import <Foundation/Foundation.h>
#pragma once

/**
 `SurveyValdiator handles validation for field values for a given form.
 */

// Default Validator names.
extern NSString *const SurveyValidationRequired;
extern NSString *const SurveyValidationAlphaNumericOnly;
extern NSString *const SurveyValidationAlphaOnly;
extern NSString *const SurveyValidationNumericOnly;
extern NSString *const SurveyValidationEmailAddress;

// Shortcut for registering new validations.
#define SurveyRegisterGlobalValidator(name, block) [SurveyValidator registerValidation:name handler:block]


@interface SurveyValidator : NSObject
/**
 @name Handles validation of values for use with Survey fields.
 */

/**
 Class method to register a new global validation to use with field values.
 
 @param validationName Name of validation that will be used when assigning to a form field.
 @param block          Block for testing the fields value and returns BOOL based on result.
 */
+ (void)registerValidation:(NSString *)validationName handler:(SurveyValidationBlock)block;

/**
 Instance method to register a validation to use with a form instance's field values.
 
 @param validationName Name of validation that will be used when assigning to a form field.
 @param block          Block for testing the fields value and returns BOOL based on result.
 */
- (void)registerValidation:(NSString *)validationName handler:(SurveyValidationBlock)block;

/**
 Executes validation block assigned to the validator.
 @param string    Value to test
 @param validator Name of validation block to use against string.
 @return Boolean response from validator block.
 */
- (BOOL)validateString:(NSString *)string usingValidator:(NSString *)validator;

/**
 Resets default validation blocks.
 */
- (void)resetValidationsToDefault;
@end
