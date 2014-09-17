//
//  SurveyForm.h
//  Survey
//
//  Created by Wess Cope on 4/24/14.
//  Copyright (c) 2014 Wess Cope. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SurveyValidator.h"
#import "SurveyConstants.h"
#pragma once

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
/**
 Default keyboard type for all fields in the form.
 */
@property (assign, nonatomic) UIKeyboardType            keyboardType;

/**
 Default return key used for field keyboards.
 */
@property (assign, nonatomic) UIReturnKeyType           returnKeyType;

/**
 Default font to use for form fields
 */
@property (assign, nonatomic) UIFont                    *defaultFieldFont;

/**
 Default text color to use for field s in the form.
 */
@property (assign, nonatomic) UIColor                   *defaultFieldTextColor;

/**
 Default placeholder font to use with all fields.
 */
@property (assign, nonatomic) UIFont                    *defaultPlaceholderFont;

/**
 Default placeholder color to use with all fields.
 */
@property (assign, nonatomic) UIColor                   *defaultPlaceholderColor;

/** 
 Default validation options for all fields.
 */
@property (assign, nonatomic) NSArray                   *defaultValidationOptions;

/**
 Default error messages to use with all fields.
 */
@property (assign, nonatomic) NSDictionary              *defaultErrorMessages;

/**
 Default error handler block for all fields.
 */
@property (assign, nonatomic) SurveyOnFieldErrorBlock   defaultOnError;

/**
 Default validation block to use for all fields.
 */
@property (copy, nonatomic) SurveyValidateFieldBlock    defaultValidationBlock;

/**
 Default `Did Begin Editing` block for all fields.
 */

@property (copy, nonatomic) SurveyTextFieldDidBlock     defaultDidBeginEditing;

/**
 Default `Did End Editing` block for all fields.
 */
@property (copy, nonatomic) SurveyTextFieldDidBlock     defaultDidEndEditing;

/**
 Default `Should Begin Editing` for all fields.
 */
@property (copy, nonatomic) SurveyTextFieldShouldBlock  defaultShouldBeginEditing;

/**
 Default `Should End Editing` block for all fields.
 */
@property (copy, nonatomic) SurveyTextFieldShouldBlock  defaultShouldEndEditing;

/**
 Default `Should Change Characters In range` block for all fields.
 */
@property (copy, nonatomic) SurveyShouldChangeBlock     defaultShouldChangeCharactersInRange;

/**
 Default `Should Clear` block for all fields.
 */
@property (copy, nonatomic) SurveyTextFieldShouldBlock  defaultShouldClear;

/**
 Default `Should Return` block for all fields.
 */
@property (copy, nonatomic) SurveyTextFieldShouldBlock  defaultShouldReturn;


/**
 Initialize a new Survey form populating fields with default values.
 */
- (instancetype)initWithDefaultValues:(NSDictionary *)defaults;

/**
 Specify the order of the fields.
 */
+ (NSArray *)fields;
@end

@interface SurveyForm(Private)
- (SurveyTextField *)textFieldForName:(NSString *)name;
- (SurveyTextView *)textViewForName:(NSString *)name;
@end


