//
//  SurveyField.m
//  Survey
//
//  Created by Wess Cope on 10/15/12.
//  Copyright (c) 2012 Wess Cope. All rights reserved.
//

#import "SurveyField.h"

@implementation SurveyField

- (id)init
{
    self = [super init];
    if(self)
    {
        _isRequired      = NO;
        _validationBlock = NULL;
    }
    return self;
}

+ (SurveyField *)fieldWithPlaceholder:(NSString *)placeholder
{
    SurveyField *field  = [[self alloc] init];
    field.placeholder   = placeholder;
    
    return field;
}

- (void)setField:(UITextField *)field
{
    field.delegate = self;
    _field = field;
}

#pragma mark - UITextField Delegate Methods -
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if(![self shouldBeginEditing] && [self.delegate respondsToSelector:@selector(textFieldShouldBeginEditing:)])
        return [self.delegate textFieldShouldBeginEditing:textField];
    else if(self.shouldBeginEditing != nil)
        return self.shouldBeginEditing(textField);
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(![self didBeginEditing] && [self.delegate respondsToSelector:@selector(textFieldDidBeginEditing:)])
        [self.delegate textFieldDidBeginEditing:textField];
    else if(self.didBeginEditing != nil)
        self.didBeginEditing(textField);
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if(![self shouldEndEditing] && [self.delegate respondsToSelector:@selector(textFieldShouldEndEditing:)])
        return [self.delegate textFieldShouldEndEditing:textField];
    else if(self.shouldEndEditing != nil)
        return self.shouldEndEditing(textField);
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if(![self didEndEditing] && [self.delegate respondsToSelector:@selector(textFieldShouldEndEditing:)])
        [self.delegate textFieldShouldEndEditing:textField];
    else if(self.didEndEditing != nil)
        self.didEndEditing(textField);
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(![self shouldEndEditing] && [self.delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)])
        return [self.delegate textField:textField shouldChangeCharactersInRange:range replacementString:string];
    else if(self.shouldChangeCharactersInRange != nil)
        return self.shouldChangeCharactersInRange(textField, range, string);
    
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    if(![self shouldClear] && [self.delegate respondsToSelector:@selector(textFieldShouldClear:)])
        return [self.delegate textFieldShouldClear:textField];
    else if(self.shouldClear != nil)
        return self.shouldClear(textField);
    
    return NO;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(![self shouldReturn] && [self.delegate respondsToSelector:@selector(textFieldShouldReturn:)])
        return [self.delegate textFieldShouldReturn:textField];
    else if(self.shouldReturn != nil)
        return self.shouldReturn(textField);
    
    return NO;
}

@end
