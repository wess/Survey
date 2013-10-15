//
//  SurveyTextField.h
//  Survey
//
//  Created by Wess Cope on 2/21/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SurveyDefines.h"

@class SurveyForm;

/**
 `SurveyTextField` is a subclass of `UITextField`, designed to work with SurveyForms and provide block based delegate methods.
 */

@interface SurveyTextField : UITextField

/// ---------------------------------------------
/// @name TextField for use with Survey forms.
/// ---------------------------------------------

/**
 Restricts amount of characters allowed to be entered into a text field.
*/
@property (nonatomic) NSInteger maxLength;

/**
 The block used to validate the value of a field, when defined in a subclass.
 
 @discussion Use for one off validations in property overrides in form subclass.
 */
@property (copy, nonatomic) SurveyValidateFieldBlock    validationBlock;

/**
 Callback when a fields `begin editing` delegate is triggered.
 
 @discussion Block based version of the delegate with the same name.
 */
@property (copy, nonatomic) SurveyTextFieldDidBlock     didBeginEditing;

/**
 Callback when a fields `end editing` delegate is triggered.
 
 @discussion Block based version of the delegate with the same name.
 */
@property (copy, nonatomic) SurveyTextFieldDidBlock     didEndEditing;

/**
 Callback when a fields `should begin editing` delegate is triggered.
 
 @discussion Block based version of the delegate with the same name.
 */
@property (copy, nonatomic) SurveyTextFieldShouldBlock  shouldBeginEditing;

/**
 Callback when a fields `should end editing` delegate is triggered.
 
 @discussion Block based version of the delegate with the same name.
 */
@property (copy, nonatomic) SurveyTextFieldShouldBlock  shouldEndEditing;

/**
 Callback when a fields `should change characters in range` delegate is triggered.
 
 @discussion Block based version of the delegate with the same name.
 */
@property (copy, nonatomic) SurveyShouldChangeBlock     shouldChangeCharactersInRange;

/**
 Callback when a fields `should clear` delegate is triggered.
 
 @discussion Block based version of the delegate with the same name.
 */
@property (copy, nonatomic) SurveyTextFieldShouldBlock  shouldClear;

/**
 Callback when a fields `should return` delegate is triggered.
 
 @discussion Block based version of the delegate with the same name.
 */
@property (copy, nonatomic) SurveyTextFieldShouldBlock  shouldReturn;

/**
 Callback that is triggered when the field fails validation.
 */
@property  (copy, nonatomic) SurveyOnFieldErrorBlock    onError;

/**
 Access to the fields parent form.
 */
@property (strong, nonatomic) SurveyForm                *form;

/**
 Field title
 */
@property (copy, nonatomic) NSString                    *title;

/**
 Array of strings that define what validation to use on the field's value.
 */
@property (strong, nonatomic) NSArray                   *validationOptions;

/**
 Dictionary of messages to use with specific validation types.
 
 @discussion Uses the format: @{SurveyValidationRequired : @"Oh, this field is required"}
 */
@property (strong, nonatomic) NSMutableDictionary       *errorMessages;

/**
 A list of errors the field has.
 */
@property (readonly, nonatomic) NSDictionary            *errors;

/**
 Allows for changing color of placeholder text.
 */
@property (copy, nonatomic) UIColor                     *placeholderColor;

/**
 The next field in the form's list of fields
 
 @discussion If used outside of a SurveyForm subclass, will be nil.
 */
@property (readonly, nonatomic) id                      nextField;

/**
 The previous field in the form's list of fields
 
 @discussion If used outside of a SurveyForm subclass, will be nil.
 */
@property (readonly, nonatomic) id                      previousField;

/**
 Checks and returns if the field's value passes it's provided validation types.
 
 @return YES/NO if the field's value is valid.
 */
- (BOOL) isValid;


/**
 Removes focus from current field and sets focus to previous field
 **/
- (void)moveToPreviousField;

/**
 Removes focus from current field and sets focus to next field
 **/
- (void)moveToNextField;

@end
