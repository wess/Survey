//
//  SurveyDefines.h
//  Survey
//
//  Created by Wess Cope on 2/22/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#ifndef __SURVEY_DEFINE_H__
#define __SURVEY_DEFINE_H__

#import <objc/runtime.h>

#define SYNTHESIZE_PROPERTY(setter, type, propertyName) \
- (void)setter:(type)propertyName \
{ \
objc_setAssociatedObject(self, "survey_"#propertyName, propertyName, OBJC_ASSOCIATION_COPY_NONATOMIC); \
} \
\
- (type)propertyName \
{ \
return (type)objc_getAssociatedObject(self, "survey_"#propertyName); \
}


typedef BOOL(^SurveyValidateFieldBlock)(id this, id value);
typedef BOOL(^SurveyTextFieldShouldBlock)(id this);
typedef void(^SurveyTextFieldDidBlock)(id this);
typedef BOOL(^SurveyShouldChangeBlock)(id this, NSRange range, NSString *string);
typedef void(^SurveyFieldDrawRectBlock)(CGRect frame);
typedef void(^SurveyOnFieldErrorBlock)(id this, NSDictionary *errors);

static NSString *const SurveyValidationRequired            = @"SurveyValidationRequired";
static NSString *const SurveyValidationAlphaNumericOnly    = @"SurveyValidationAlphaNumericOnly";
static NSString *const SurveyValidationAlphaOnly           = @"SurveyValidationAlphaOnly";
static NSString *const SurveyValidationNumericOnly         = @"SurveyValidationNumericOnly";
static NSString *const SurveyValidationEmailAddress        = @"SurveyValidationEmailAddress";

static NSString *const SurveyValidationErrorMessageRequired         = @"Field is required";
static NSString *const SurveyValidationErrorMessageAlphaNumericOnly = @"Field can only be letters and numbers";
static NSString *const SurveyValidationErrorMessageAlphaOnly        = @"Field can only be letters";
static NSString *const SurveyValidationErrorMessageNumericOnly      = @"Field can only be numbers";
static NSString *const SurveyValidationErrorMessageEmailAddress     = @"Invalid email address";


#define SurveyDefaultErrorMessages @{                                               \
SurveyValidationRequired            : SurveyValidationErrorMessageRequired,         \
SurveyValidationAlphaNumericOnly    : SurveyValidationErrorMessageAlphaNumericOnly, \
SurveyValidationAlphaOnly           : SurveyValidationErrorMessageAlphaOnly,        \
SurveyValidationNumericOnly         : SurveyValidationErrorMessageNumericOnly,      \
SurveyValidationEmailAddress        : SurveyValidationErrorMessageEmailAddress      \
}

#endif
