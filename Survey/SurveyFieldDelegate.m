//
//  SurveyFieldDelegate.m
//  Survey
//
//  Created by Wess Cope on 4/24/14.
//  Copyright (c) 2014 Wess Cope. All rights reserved.
//

#import "SurveyFieldDelegate.h"
#import "SurveyFieldProtocol.h"
#import "SurveyFields.h"
#import "SurveyForm.h"

@implementation SurveyFieldDelegate
#pragma mark - TextField Delegates -

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    SurveyTextField *field = (SurveyTextField *)textField;
    if(field.shouldBeginEditing != nil)
        return field.shouldBeginEditing(field.form, field);
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    SurveyTextField *field = (SurveyTextField *)textField;
    
    if(field.didBeginEditing != nil)
        field.didBeginEditing(field.form, field);
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    SurveyTextField *field = (SurveyTextField *)textField;

    if(field.shouldEndEditing != nil)
        return field.shouldEndEditing(field.form, field);
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    SurveyTextField *field = (SurveyTextField *)textField;

    if(field.didEndEditing != nil)
        field.didEndEditing(field.form, field);
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    SurveyTextField *field = (SurveyTextField *)textField;
    
    if([string isEqualToString:@""])
        return YES;
    
    if(field.maxLength > 0 && field.text.length >= field.maxLength)
        return NO;
    
    if(field.shouldChangeCharactersInRange != nil)
        return field.shouldChangeCharactersInRange(field.form, field, range, string);
    
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    SurveyTextField *field = (SurveyTextField *)textField;

    if(field.shouldClear != nil)
        return field.shouldClear(field.form, field);
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    SurveyTextField *field = (SurveyTextField *)textField;

    if(field.shouldReturn != nil)
        return field.shouldReturn(field.form, field);
    
    return NO;
}


#pragma mark - TextView Delegates -
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    SurveyTextView *field = (SurveyTextView *)textView;
    
    if([text isEqualToString:@""])
        return YES;

    if(field.maxLength > 0 && field.text.length >= field.maxLength)
        return NO;
    
    if(field.shouldChangeCharactersInRange)
        return field.shouldChangeCharactersInRange(field.form, field, range, text);
    
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    SurveyTextView *field = (SurveyTextView *)textView;
    
    if(field.didBeginEditing)
        field.didBeginEditing(field.form, field);
}

- (void)textViewDidChange:(UITextView *)textView
{
    SurveyTextView *field = (SurveyTextView *)textView;

    if(field.didChange)
        field.didChange(field.form, field);
}

- (void)textViewDidChangeSelection:(UITextView *)textView
{
    SurveyTextView *field = (SurveyTextView *)textView;

    if(field.didChangeSelection)
        field.didChangeSelection(field.form, field);
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    SurveyTextView *field = (SurveyTextView *)textView;

    if(field.didEndEditing)
        field.didEndEditing(field.form, field);
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    SurveyTextView *field = (SurveyTextView *)textView;
    
    if(field.shouldBeginEditing)
        field.shouldBeginEditing(field.form, field);
    
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    SurveyTextView *field = (SurveyTextView *)textView;

    if(field.shouldEndEditing)
        return field.shouldEndEditing(field.form, field);
    
    return YES;
}
@end
