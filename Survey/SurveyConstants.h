//
//  SurveyConstants.h
//  Survey
//
//  Created by Wess Cope on 4/24/14.
//  Copyright (c) 2014 Wess Cope. All rights reserved.
//

#ifndef Survey_SurveyConstants_h
#define Survey_SurveyConstants_h

@class SurveyForm;

typedef BOOL(^SurveyValidationBlock)(NSString *string);
typedef BOOL(^SurveyValidateFieldBlock)(id this, id value);
typedef BOOL(^SurveyTextFieldShouldBlock)(id form, id this);
typedef void(^SurveyTextFieldDidBlock)(id form, id this);
typedef BOOL(^SurveyShouldChangeBlock)(id form, id this, NSRange range, NSString *string);
typedef void(^SurveyOnFieldErrorBlock)(id form, id this, NSDictionary *errors);


static NSString *const SurveyValidationErrorMessageRequired         = @"Field is required";
static NSString *const SurveyValidationErrorMessageAlphaNumericOnly = @"Field can only be letters and numbers";
static NSString *const SurveyValidationErrorMessageAlphaOnly        = @"Field can only be letters";
static NSString *const SurveyValidationErrorMessageNumericOnly      = @"Field can only be numbers";
static NSString *const SurveyValidationErrorMessageEmailAddress     = @"Invalid email address";


#define SurveyDefaultErrorMessages @{                                                   \
    SurveyValidationRequired            : SurveyValidationErrorMessageRequired,         \
    SurveyValidationAlphaNumericOnly    : SurveyValidationErrorMessageAlphaNumericOnly, \
    SurveyValidationAlphaOnly           : SurveyValidationErrorMessageAlphaOnly,        \
    SurveyValidationNumericOnly         : SurveyValidationErrorMessageNumericOnly,      \
    SurveyValidationEmailAddress        : SurveyValidationErrorMessageEmailAddress      \
}

#define SurveyOverrideSelectorInSubclass(cmd) @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(cmd)] userInfo:nil]

#ifndef weakify
#define weakify(context) try {} @finally {} \
__weak typeof(context) survey_weak_ ## context = context
#endif

#ifndef strongify
#define strongify(o) try {} @finally {} \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
typeof(survey_weak_ ## o) o = survey_weak_ ## o \
_Pragma("clang diagnostic pop")
#endif


#endif
