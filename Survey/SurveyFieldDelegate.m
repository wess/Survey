//
//  SurveyFieldDelegate.m
//  Survey
//
//  Created by Wess Cope on 2/22/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import "SurveyFieldDelegate.h"
#import "SurveyFields.h"
#import "SurveyForm.h"

@implementation SurveyFieldDelegate

#pragma mark - TextField Delegates -

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if(((SurveyTextField *)textField).shouldBeginEditing != nil)
        return ((SurveyTextField *)textField).shouldBeginEditing(((SurveyTextField *)textField));
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    SurveyTextField *field = (SurveyTextField *)textField;
    
    if(field.didBeginEditing != nil)
        field.didBeginEditing(field);
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if(((SurveyTextField *)textField).shouldEndEditing != nil)
        return ((SurveyTextField *)textField).shouldEndEditing(((SurveyTextField *)textField));
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if(((SurveyTextField *)textField).didEndEditing != nil)
        ((SurveyTextField *)textField).didEndEditing(((SurveyTextField *)textField));
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    SurveyTextField *field = (SurveyTextField *)textField;
    
    if(field.maxLength > 0 && field.text.length >= field.maxLength)
        return NO;
    
    if(field.shouldChangeCharactersInRange != nil)
        return ((SurveyTextField *)textField).shouldChangeCharactersInRange(((SurveyTextField *)textField), range, string);
    
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    if(((SurveyTextField *)textField).shouldClear != nil)
        return ((SurveyTextField *)textField).shouldClear(((SurveyTextField *)textField));
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(((SurveyTextField *)textField).shouldReturn != nil)
        return ((SurveyTextField *)textField).shouldReturn(((SurveyTextField *)textField));
    
    return NO;
}


#pragma mark - TextView Delegates -
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    SurveyTextView *field = (SurveyTextView *)textView;
    
    if(field.maxLength > 0 && field.text.length >= field.maxLength)
        return NO;

    if(field.shouldChangeCharactersInRange)
        return field.shouldChangeCharactersInRange(field, range, text);
    
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    SurveyTextView *field = (SurveyTextView *)textView;

    if(field.didBeginEditing)
        field.didBeginEditing(field);
}

- (void)textViewDidChange:(UITextView *)textView
{
    if(((SurveyTextView *)textView).didChange)
        ((SurveyTextView *)textView).didChange(((SurveyTextView *)textView));
}

- (void)textViewDidChangeSelection:(UITextView *)textView
{
    if(((SurveyTextView *)textView).didChangeSelection)
        ((SurveyTextView *)textView).didChangeSelection(((SurveyTextView *)textView));
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if(((SurveyTextView *)textView).didEndEditing)
        ((SurveyTextView *)textView).didEndEditing(((SurveyTextView *)textView));
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if(((SurveyTextView *)textView).shouldBeginEditing)
        ((SurveyTextView *)textView).shouldBeginEditing(((SurveyTextView *)textView));
    
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    if(((SurveyTextView *)textView).shouldEndEditing)
        return ((SurveyTextView *)textView).shouldEndEditing(((SurveyTextView *)textView));
    
    return YES;
}

@end
