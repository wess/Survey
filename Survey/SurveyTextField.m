//
//  SurveyTextField.m
//  Survey
//
//  Created by Wess Cope on 2/21/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import "SurveyTextField.h"
#import "SurveyValidator.h"
#import "SurveyForm.h"

@interface SurveyTextField()//<UITextFieldDelegate>
@end

@implementation SurveyTextField
@synthesize errors = _errors;

- (void)setup
{
    self.validationOptions  = @[SurveyValidationRequired];
    self.errorMessages      = [SurveyDefaultErrorMessages mutableCopy];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self setup];
    }
    return self;
}

- (BOOL)isValid
{
    __weak typeof(self) weakSelf                = self;
    __block BOOL isValid                        = YES;
    __block NSMutableDictionary *currentErrors  = [NSMutableDictionary new];
    
    [self.validationOptions enumerateObjectsUsingBlock:^(NSString *option, NSUInteger idx, BOOL *stop) {
        
        if(![SurveyValidator validateString:weakSelf.text withValidator:option])
        {
            currentErrors[option] = self.errorMessages[option];
            isValid = NO;
        }
    }];
    
    _errors = [currentErrors copy];
    
    if(self.onError != nil)
        self.onError(self, _errors);
    
    return isValid;
}

//#pragma mark - Delegates -
//
//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
//{
//    if(self.shouldBeginEditing != nil)
//        return self.shouldBeginEditing(self);
//
//    return YES;
//}
//
//- (void)textFieldDidBeginEditing:(UITextField *)textField
//{
//    if(self.didBeginEditing != nil)
//        self.didBeginEditing(self);
//}
//
//- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
//{
//    if(self.shouldEndEditing != nil)
//        return self.shouldEndEditing(self);
//
//    return YES;
//}
//
//- (void)textFieldDidEndEditing:(UITextField *)textField
//{
//    if(self.didEndEditing != nil)
//        self.didEndEditing(self);
//}
//
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//    if(self.shouldChangeCharactersInRange != nil)
//        return self.shouldChangeCharactersInRange(self, range, string);
//
//    return YES;
//}
//
//- (BOOL)textFieldShouldClear:(UITextField *)textField
//{
//    if(self.shouldClear != nil)
//        return self.shouldClear(self);
//
//    return YES;
//}
//
//- (BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//    if(self.shouldReturn != nil)
//        return self.shouldReturn(self);
//
//    return NO;
//}

@end
