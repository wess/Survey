//
//  SurveyField.m
//  Survey
//
//  Created by Wess Cope on 10/15/12.
//  Copyright (c) 2012 Wess Cope. All rights reserved.
//

#import "SurveyField.h"

@interface SurveyTextView : UITextView
@property (strong, nonatomic) NSString *placeholder;
@property (strong, nonatomic) UIColor *placeholderColor;

- (void)textChanged:(NSNotification *)notification;
@end


@implementation SurveyTextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.placeholder = @"";
        self.placeholderColor = [UIColor lightGrayColor];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)textChanged:(NSNotification *)notification
{
    if(self.placeholder.length == 0)
        return;
    
    [[self viewWithTag:999] setAlpha:((self.text.length == 0)? 1 : 0)];
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    [self textChanged:nil];
}

- (void)drawRect:(CGRect)rect
{
    UILabel *label = (UILabel *)[self viewWithTag:999];

    if(self.placeholder.length > 0)
    {
        if(!label || !label.superview)
        {
            UILabel *label          = [[UILabel alloc] initWithFrame:CGRectMake(8.0f, 8.0f, self.bounds.size.width - 16.0f, 0)];
            label.lineBreakMode     = NSLineBreakByWordWrapping;
            label.numberOfLines     = 0;
            label.font              = self.font;
            label.backgroundColor   = [UIColor clearColor];
            label.textColor         = self.placeholderColor;
            label.alpha             = 0;
            label.tag               = 999;
            
            [self addSubview:label];
        }
        
        label.text = self.placeholder;
        [label sizeToFit];
        [self sendSubviewToBack:label];
    }
    
    if(self.text.length == 0 && self.placeholder.length > 0)
        label.alpha = 1;
    
    [super drawRect:rect];
}

@end


@implementation SurveyField

- (id)init
{
    self = [super init];
    if(self)
    {
        self.isRequired                 = NO;
        self.validationBlock            = NULL;
        self.autocapitalizationType     = UITextAutocapitalizationTypeSentences;
        self.autocorrectionType         = UITextAutocorrectionTypeDefault;
        self.keyboardType               = UIKeyboardTypeDefault;
        self.returnKeyType              = UIReturnKeyDefault;
        self.contentVerticalAlignment   = UIControlContentVerticalAlignmentCenter;
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.backgroundColor            = [UIColor whiteColor];
        self.font                       = [UIFont systemFontOfSize:[UIFont systemFontSize]];
        self.clearButtonMode            = UITextFieldViewModeNever;
        self.fieldClass                 = [UITextField class];
    }
    return self;
}

+ (SurveyField *)fieldWithPlaceholder:(NSString *)placeholder
{
    SurveyField *field  = [[self alloc] init];
    field.placeholder   = placeholder;

    return field;
}

- (void)setFieldClass:(Class)fieldClass
{
    NSString *classString = NSStringFromClass(fieldClass);
    
    if([classString isEqualToString:@"UITextView"])
        fieldClass = [SurveyTextView class];
    
    _fieldClass = fieldClass;
    id newField = [[fieldClass alloc] initWithFrame:CGRectZero];

    [newField setReturnKeyType:self.returnKeyType];
    [newField setKeyboardType:self.keyboardType];
    [newField setDelegate:self];
    [self setField:newField];
    
}

- (void)setField:(id)field
{
    _field          = field;
    [_field setFont:self.font];
}

- (NSUInteger)tabIndex
{
    return [self.form getIndexOfField:self];
}

#pragma mark - Getters -
- (NSString *)placeholder
{
    if([self.field respondsToSelector:@selector(placeholder)])
        return [self.field placeholder];
    
    return @"";
}

- (UITextAutocapitalizationType)autocapitalizationType
{
    if([self.field respondsToSelector:@selector(autocapitalizationType)])
        return [self.field autocapitalizationType];

    return NULL;
}

- (UITextAutocorrectionType)autocorrectionType
{
    if([self.field respondsToSelector:@selector(autocorrectionType)])
        return [self.field autocorrectionType];
    
    return NULL;
}

- (UIKeyboardType)keyboardType
{
    if([self.field respondsToSelector:@selector(keyboardType)])
        return [self.field keyboardType];
    
    return NULL;
}

- (UIReturnKeyType)returnKeyType
{
    if([self.field respondsToSelector:@selector(returnKeyType)])
        return [self.field returnKeyType];
    
    return NULL;
}

- (UITextFieldViewMode)clearButtonMode
{
    if([self.field respondsToSelector:@selector(clearButtonMode)])
        return [self.field clearButtonMode];
    
    return NULL;
}

- (UIControlContentVerticalAlignment)contentVerticalAlignment
{
    if([self.field respondsToSelector:@selector(contentVerticalAlignment)])
        return [self.field contentVerticalAlignment];
    
    return NULL;
}

- (UIControlContentHorizontalAlignment)contentHorizontalAlignment
{
    if([self.field respondsToSelector:@selector(contentHorizontalAlignment)])
        return [self.field contentHorizontalAlignment];
    
    return NULL;    
}

#pragma mark - Setters -

- (void)setPlaceholder:(NSString *)placeholder
{
    if([self.field respondsToSelector:@selector(setPlaceholder:)])
        [self.field setPlaceholder:placeholder];
}

- (void)setAutocapitalizationType:(UITextAutocapitalizationType)autocapitalizationType
{
    if([self.field respondsToSelector:@selector(setAutocapitalizationType)])
        [self.field setAutocapitalizationType:autocapitalizationType];
}

- (void)setAutocorrectionType:(UITextAutocorrectionType)autocorrectionType
{
    if([self.field respondsToSelector:@selector(setAutocorrectionType)])
        [self.field setAutocorrectionType:autocorrectionType];
}

- (void)setKeyboardType:(UIKeyboardType)keyboardType
{
    if([self.field respondsToSelector:@selector(setKeyboardType)])
        [self.field setKeyboardType:keyboardType];
}

- (void)setReturnKeyType:(UIReturnKeyType)returnKeyType
{
    if([self.field respondsToSelector:@selector(setReturnKeyType)])
        [self.field setReturnKeyType:returnKeyType];
}

- (void)setClearButtonMode:(UITextFieldViewMode)clearButtonMode
{
    if([self.field respondsToSelector:@selector(setClearButtonMode)])
        [self.field setClearButtonMode:clearButtonMode];
}

- (void)setContentVerticalAlignment:(UIControlContentVerticalAlignment)contentVerticalAlignment
{
    if([self.field respondsToSelector:@selector(setContentVerticalAlignment)])
        [self.field setContentVerticalAlignment:contentVerticalAlignment];
}

- (void)setContentHorizontalAlignment:(UIControlContentHorizontalAlignment)contentHorizontalAlignment
{
    if([self.field respondsToSelector:@selector(setContentHorizontalAlignment)])
        [self.field setContentHorizontalAlignment:contentHorizontalAlignment];
}

#pragma mark - Helper Methods -
- (SurveyField *)getNextField
{
    return [self.form getFieldAtTabIndex:([self tabIndex] + 1)];
}

- (SurveyField *)getPreviousField
{
    return [self.form getFieldAtTabIndex:([self tabIndex] - 1)];
}

#pragma mark - UITextField Proxy Methods -
- (void)becomeFirstResponder
{
    [((UIView *)self.field) becomeFirstResponder];
}

- (void)resignFirstResponder
{
    [((UIView *)self.field) resignFirstResponder];
}

#pragma mark - UITextField Delegate Methods -
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if(![self shouldBeginEditing] && [self.delegate respondsToSelector:@selector(textFieldShouldBeginEditing:)])
        return [self.delegate textFieldShouldBeginEditing:textField];
    else if(self.shouldBeginEditing != nil)
        return self.shouldBeginEditing(self, textField);
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(![self didBeginEditing] && [self.delegate respondsToSelector:@selector(textFieldDidBeginEditing:)])
        [self.delegate textFieldDidBeginEditing:textField];
    else if(self.didBeginEditing != nil)
        self.didBeginEditing(self, textField);
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if(![self shouldEndEditing] && [self.delegate respondsToSelector:@selector(textFieldShouldEndEditing:)])
        return [self.delegate textFieldShouldEndEditing:textField];
    else if(self.shouldEndEditing != nil)
        return self.shouldEndEditing(self, textField);
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if(![self didEndEditing] && [self.delegate respondsToSelector:@selector(textFieldShouldEndEditing:)])
        [self.delegate textFieldShouldEndEditing:textField];
    else if(self.didEndEditing != nil)
        self.didEndEditing(self, textField);
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(![self shouldEndEditing] && [self.delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)])
        return [self.delegate textField:textField shouldChangeCharactersInRange:range replacementString:string];
    else if(self.shouldChangeCharactersInRange != nil)
        return self.shouldChangeCharactersInRange(self, textField, range, string);
    
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    if(![self shouldClear] && [self.delegate respondsToSelector:@selector(textFieldShouldClear:)])
        return [self.delegate textFieldShouldClear:textField];
    else if(self.shouldClear != nil)
        return self.shouldClear(self, textField);
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(![self shouldReturn] && [self.delegate respondsToSelector:@selector(textFieldShouldReturn:)])
        return [self.delegate textFieldShouldReturn:textField];
    else if(self.shouldReturn != nil)
        return self.shouldReturn(self, textField);
    
    return NO;
}

#pragma mark - UITextView Delegates -
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if(![self didBeginEditing] && [self.delegate respondsToSelector:@selector(textViewDidBeginEditing:)])
        [self.delegate textViewDidBeginEditing:textView];
    else if(self.didBeginEditing != nil)
        self.didBeginEditing(self, textView);
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if(![self didEndEditing] && [self.delegate respondsToSelector:@selector(textViewDidEndEditing:)])
        [self.delegate textViewDidEndEditing:textView];
    else if(self.didEndEditing != nil)
        self.didEndEditing(self, textView);    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if(![self shouldEndEditing] && [self.delegate respondsToSelector:@selector(textView:shouldChangeTextInRange:replacementText:)])
        return [self.delegate textView:textView shouldChangeTextInRange:range replacementText:text];
    else if(self.shouldChangeTextInRange != nil)
        return self.shouldChangeTextInRange(self, textView, range, text);
    
    return YES;    
}
@end
