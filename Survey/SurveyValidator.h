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

@interface SurveyValidator : NSObject

- (void)registerValidation:(NSString *)validationName withBlock:(SurveyValidationBlock)block;
- (void)resetValidatorsToDefault;
- (BOOL)validateString:(NSString *)value withValidator:(NSString *)validatorName;

+ (instancetype)instance;
+ (void)registerValidation:(NSString *)validationName withBlock:(SurveyValidationBlock)block;
+ (BOOL)validateString:(NSString *)value withValidator:(NSString *)validatorName;

@end
