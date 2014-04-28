//
//  SurveyConstants.h
//  Survey
//
//  Created by Wess Cope on 4/24/14.
//  Copyright (c) 2014 Wess Cope. All rights reserved.
//

#ifndef Survey_SurveyConstants_h
#define Survey_SurveyConstants_h

typedef BOOL(^SurveyValidationBlock)(NSString  *string);
typedef BOOL(^SurveyValidateFieldBlock)(id this, id value);
typedef BOOL(^SurveyTextFieldShouldBlock)(id this);
typedef void(^SurveyTextFieldDidBlock)(id this);
typedef BOOL(^SurveyShouldChangeBlock)(id this, NSRange range, NSString *string);
typedef void(^SurveyFieldDrawRectBlock)(CGRect frame);
typedef void(^SurveyOnFieldErrorBlock)(id this, NSDictionary *errors);


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
__weak typeof(context) nf_weak_ ## context = context
#endif

#ifndef strongify
#define strongify(o) try {} @finally {} \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
typeof(nf_weak_ ## o) o = nf_weak_ ## o \
_Pragma("clang diagnostic pop")
#endif


#endif
