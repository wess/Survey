//
//  SurveyForm.h
//  Survey
//
//  Created by Wess Cope on 4/24/14.
//  Copyright (c) 2014 Wess Cope. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SurveyValidator.h"

/**
 `SurveyForm` is responsible for creating and managing form fields. To create a form, you must subclass SurveyForm using 
 class properties to define your fields.
 
 ## Subclass
 ### Methods to Override
 In a `SurveyForm` subclass, you must add the class method: `+fields` to tell `SurveyForm` the order you want the fields.
 */

@class SurveyTextField, SurveyTextView;

@interface SurveyForm : NSObject
/**
 @name Container for form fields, errors and optional methods to make working with form fields easier.
 */

@property (readonly, nonatomic) SurveyValidator *validator;
@property (readonly, nonatomic) NSArray         *fields;
@property (readonly, nonatomic) NSDictionary    *errors;
@property (readonly, nonatomic) id              currentField;
@property (readonly, nonatomic) BOOL            isValid;

// Field defaults
@property (assign, nonatomic) UIFont                  *defaultFieldFont;
@property (assign, nonatomic) UIColor                 *defaultFieldTextColor;
@property (assign, nonatomic) UIFont                  *defaultPlaceholderFont;
@property (assign, nonatomic) UIColor                 *defaultPlaceholderColor;
@property (assign, nonatomic) NSArray                 *defaultValidationOptions;
@property (assign, nonatomic) NSDictionary            *defaultErrorMessages;
@property (assign, nonatomic) SurveyOnFieldErrorBlock defaultOnError;

- (instancetype)initWithDefaultValues:(NSDictionary *)defaults;
+ (NSArray *)fields;
@end

@interface SurveyForm(Private)
- (SurveyTextField *)textFieldForName:(NSString *)name;
- (SurveyTextView *)textViewForName:(NSString *)name;
@end


