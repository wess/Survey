//
//  SurveyTextView.m
//  Survey
//
//  Created by Wess Cope on 2/22/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import "SurveyTextView.h"
#import "SurveyValidator.h"
#import "SurveyForm.h"

@interface SurveyTextView()<UITextViewDelegate>
@end

@implementation SurveyTextView

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
        NSLog(@"OPTION: %@", option);
        if(![[SurveyValidator instance] validateString:weakSelf.text withValidator:option])
        {
            currentErrors[option] = self.errorMessages[option];
            isValid = NO;
        }
    }];
    
    _errors = [currentErrors copy];

    if(self.onError)
        self.onError(self, _errors);
    
    return isValid;
}

//#pragma mark - TextView Delegates -
//- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
//{
//    if(self.shouldChangeCharactersInRange)
//        return self.shouldChangeCharactersInRange(self, range, text);
//    
//    return NO;
//}
//
//- (void)textViewDidBeginEditing:(UITextView *)textView
//{
//    if(self.didBeginEditing)
//        self.didBeginEditing(self);
//}
//
//- (void)textViewDidChange:(UITextView *)textView
//{
//    if(self.didChange)
//        self.didChange(self);
//}
//
//- (void)textViewDidChangeSelection:(UITextView *)textView
//{
//    if(self.didChangeSelection)
//        self.didChangeSelection(self);
//}
//
//- (void)textViewDidEndEditing:(UITextView *)textView
//{
//    if(self.didEndEditing)
//        self.didEndEditing(self);
//}
//
//- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
//{
//    if(self.shouldBeginEditing)
//        self.shouldBeginEditing(self);
//    
//    return YES;
//}
//
//- (BOOL)textViewShouldEndEditing:(UITextView *)textView
//{
//    if(self.shouldEndEditing)
//        return self.shouldEndEditing(self);
//    
//    return YES;
//}
//
@end
