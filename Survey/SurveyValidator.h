//
//  SurveyValidator.h
//  Survey
//
//  Created by Wess Cope on 2/22/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SurveyDefines.h"

typedef BOOL(^SurveyValidationBlock)(NSString *value);

/**
 `SurveyValidator` is a class designed to handle field validation.
 */

@interface SurveyValidator : NSObject

///----------------------------------------------------------
/// @name Uses defined validation to validate given values.
///----------------------------------------------------------

/**
 Registers validation block methods with a given name.
 
 @discussion The block passes the value of the field to the provided block which will return a true or false response, validationName can be anything, see SurveyDefines.h for predefined validators.

 @param validationName Name for the validation block

 @param block Callback used to validate given value.
 */
- (void)registerValidation:(NSString *)validationName withBlock:(SurveyValidationBlock)block;

/**
 Resets all registered validators back to Survey's default validators.
 */
- (void)resetValidatorsToDefault;

/**
 Returns a YES/NO if string value validates against validator with provided name.

 @param value String to validate

 @param validatorName Validator to use to validate value.
 
 @returns a YES/NO if string value validates against validator with provided name.
 */
- (BOOL)validateString:(NSString *)value withValidator:(NSString *)validatorName;

/**
 Returns an instance of the SurveyValidator

 @returns an instance of the SurveyValidator
 */
+ (instancetype)instance;

/**
 Shortcut method to register validators
 
 @param validationName Name for the validation block
 
 @param block Callback used to validate given value.
 */
+ (void)registerValidation:(NSString *)validationName withBlock:(SurveyValidationBlock)block;

/**
 Shortcut method to validate provided string.
 
 @param value String to validate
 
 @param validatorName Validator to use to validate value.
 
 @returns a YES/NO if string value validates against validator with provided name.

 */
+ (BOOL)validateString:(NSString *)value withValidator:(NSString *)validatorName;

@end
