//
//  SurveyField.h
//  Survey
//
//  Created by Wess Cope on 10/15/12.
//  Copyright (c) 2012 Wess Cope. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef BOOL(^SurveyValidationBlock)(id form, id field, id value);
typedef BOOL(^SurveyTextFieldShouldBlock)(id field);
typedef void(^SurveyTextFieldDidBlock)(id field);
typedef BOOL(^SurveyShouldChangeBlock)(id field, NSRange range, NSString *string);

@protocol SurveyFieldDelegate;
@interface SurveyField : NSObject<UITextFieldDelegate>
@property (strong, nonatomic)    id<SurveyFieldDelegate>        delegate;
@property (copy, nonatomic)      NSString                       *entityName;
@property (copy, nonatomic)      NSString                       *label;
@property (copy, nonatomic)      NSString                       *placeholder;
@property (copy, nonatomic)      NSString                       *value;
@property (strong, nonatomic)    UITextField                    *field;
@property (strong, nonatomic)    NSRegularExpression            *expression;
@property (strong, nonatomic)    NSString                       *errorMessage;
@property (strong, nonatomic)    Class                          fieldClass;
@property (copy, nonatomic)      SurveyValidationBlock          validationBlock;
@property (copy, nonatomic)      SurveyTextFieldShouldBlock     shouldBeginEditing;
@property (copy, nonatomic)      SurveyTextFieldDidBlock        didBeginEditing;
@property (copy, nonatomic)      SurveyTextFieldShouldBlock     shouldEndEditing;
@property (copy, nonatomic)      SurveyTextFieldDidBlock        didEndEditing;
@property (copy, nonatomic)      SurveyShouldChangeBlock        shouldChangeCharactersInRange;
@property (copy, nonatomic)      SurveyTextFieldShouldBlock     shouldClear;
@property (copy, nonatomic)      SurveyTextFieldShouldBlock     shouldReturn;
@property (readwrite, nonatomic) BOOL                           isRequired;
@property (readwrite, nonatomic) BOOL                           isSecure;

+ (SurveyField *)fieldWithPlaceholder:(NSString *)placeholder;

@end


@protocol SurveyFieldDelegate <NSObject>
@optional
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;
- (void)textFieldDidBeginEditing:(UITextField *)textField;
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField;
- (void)textFieldDidEndEditing:(UITextField *)textField;
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
- (BOOL)textFieldShouldClear:(UITextField *)textField;
- (BOOL)textFieldShouldReturn:(UITextField *)textField;
@end