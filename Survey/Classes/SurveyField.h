//
//  SurveyField.h
//  Survey
//
//  Created by Wess Cope on 10/15/12.
//  Copyright (c) 2012 Wess Cope. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef BOOL(^SurveyValidationBlock)(id form, id field, id value);

@interface SurveyField : NSObject
@property (copy, nonatomic)      NSString               *entityName;
@property (copy, nonatomic)      NSString               *label;
@property (copy, nonatomic)      NSString               *placeholder;
@property (copy, nonatomic)      NSString               *value;
@property (strong, nonatomic)    UITextField            *field;
@property (strong, nonatomic)    NSRegularExpression    *expression;
@property (strong, nonatomic)    NSString               *errorMessage;
@property (strong, nonatomic)    Class                  fieldClass;
@property (strong, nonatomic)    SurveyValidationBlock  validationBlock;
@property (readwrite, nonatomic) BOOL                   isRequired;
@property (readwrite, nonatomic) BOOL                   isSecure;

+ (SurveyField *)fieldWithPlaceholder:(NSString *)placeholder;

@end
