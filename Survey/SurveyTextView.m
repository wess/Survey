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

@interface SurveyTextView()
@property (strong, nonatomic) UILabel *placeholderLabel;
- (void)textChanged:(NSNotification *)notification;
@end

@implementation SurveyTextView

- (void)setup
{
    self.validationOptions  = @[SurveyValidationRequired];
    self.errorMessages      = [SurveyDefaultErrorMessages mutableCopy];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
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

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (BOOL)isValid
{
    __weak typeof(self) weakSelf                = self;
    __block BOOL isValid                        = YES;
    __block NSMutableDictionary *currentErrors  = [NSMutableDictionary new];
    
    [self.validationOptions enumerateObjectsUsingBlock:^(NSString *option, NSUInteger idx, BOOL *stop) {
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

- (void)textChanged:(NSNotification *)notification
{
    if(self.placeholder.length == 0)
        return;
    
    self.placeholderLabel.alpha = ((self.text.length == 0)? 1 : 0);
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    [self textChanged:nil];
}

- (void)setTitle:(NSString *)title
{
    if(!self.placeholder)
        self.placeholder = [title capitalizedString];
    
    _title = title;
}

- (void)drawRect:(CGRect)rect
{
    if(self.placeholder.length > 0)
    {
        if(self.placeholderLabel == nil)
        {
            self.placeholderColor                   = self.placeholderColor?: [UIColor colorWithWhite:0.7f alpha:1.0f];
            self.placeholderLabel                   = [[UILabel alloc] initWithFrame:CGRectMake(8,8,self.bounds.size.width - 16,0)];
            self.placeholderLabel.lineBreakMode     = NSLineBreakByWordWrapping;
            self.placeholderLabel.numberOfLines     = 0;
            self.placeholderLabel.font              = self.font;
            self.placeholderLabel.backgroundColor   = [UIColor clearColor];
            self.placeholderLabel.textColor         = self.placeholderColor;
            self.placeholderLabel.alpha             = 0;
            
            [self addSubview:self.placeholderLabel];
        }
        
        self.placeholderLabel.text = self.placeholder;
        [self.placeholderLabel sizeToFit];
        [self sendSubviewToBack:self.placeholderLabel];
    }
    
    self.placeholderLabel.alpha = (self.text.length == 0 && self.placeholder.length > 0)? 1 : 0;
    
    [super drawRect:rect];
}

@end
