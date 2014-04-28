//
//  SurveyTextField.m
//  Survey
//
//  Created by Wess Cope on 4/24/14.
//  Copyright (c) 2014 Wess Cope. All rights reserved.
//

#import "SurveyTextField.h"
#import "SurveyForm.h"
#import "SurveyValidator.h"

@implementation SurveyTextField
@synthesize errors              = _errors;
@synthesize placeholderColor    = _placeholderColor;

- (void)setup
{
    self.validationOptions  = @[SurveyValidationRequired];
    self.errorMessages      = [SurveyDefaultErrorMessages mutableCopy];
}

- (instancetype)init
{
    self = [super init];
    if (self)
        [self setup];

    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
        [self setup];
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
        [self setup];
    
    return self;
}

- (id)nextField
{
    NSUInteger index        = [self.form.fields indexOfObject:self];
    if(self.form.fields.count == (index + 1))
        return nil;
    
    return self.form.fields[(index + 1)];
}

- (id)previousField
{
    NSUInteger index = [self.form.fields indexOfObject:self];
    if(index < 1)
        return nil;
    
    return self.form.fields[(index - 1)];
}

- (void)setTitle:(NSString *)title
{
    if(!self.placeholder)
        self.placeholder = [title capitalizedString];
    
    _title = title;
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor == nil? [UIColor colorWithWhite:0.7f alpha:1.0f] : [placeholderColor copy];
    
    NSString *placeholder   = [self.placeholder copy];
    self.placeholder        = @"";
    self.placeholder        = placeholder;
    
}

- (BOOL)isValid
{
    __block BOOL isValid                        = YES;
    __block NSMutableDictionary *currentErrors  = [NSMutableDictionary new];
    
    [self.validationOptions enumerateObjectsUsingBlock:^(NSString *option, NSUInteger idx, BOOL *stop) {
        if(![self.form.validator validateString:self.text usingValidator:option])
        {
            currentErrors[option]   = self.errorMessages[option]?: @"Field Error";
            isValid                 = NO;
        }
    }];
    
    _errors = [currentErrors copy];
    
    if(self.onError && !isValid)
        self.onError(self, _errors);
    
    return isValid;
}
- (void)moveToPreviousField
{
    if(self.previousField)
    {
        [self resignFirstResponder];
        [self.previousField becomeFirstResponder];
    }
}

- (void)moveToNextField
{
    if(self.nextField)
    {
        [self resignFirstResponder];
        [self.nextField becomeFirstResponder];
    }
}

#pragma mark - Root selectors -

- (void)drawPlaceholderInRect:(CGRect)rect
{
    _placeholderColor = _placeholderColor?:[UIColor colorWithWhite:0.7f alpha:1.0f];
	_placeholderFont = _placeholderFont?:self.font;
	
	CGRect placeholderRect = rect;
	placeholderRect.origin.y = roundf((rect.size.height - _placeholderFont.lineHeight)/2);
	placeholderRect.size.height = roundf(_placeholderFont.lineHeight);
    
	if ([self.placeholder respondsToSelector:@selector(drawInRect:withAttributes:)]) {
		// iOS 7 and later
		NSDictionary *attributes = @{NSForegroundColorAttributeName: _placeholderColor, NSFontAttributeName: _placeholderFont};
		
		[self.placeholder drawInRect:placeholderRect withAttributes:attributes];
	} else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
		// iOS 6
		[_placeholderColor setFill];
        
		[self.placeholder drawInRect:placeholderRect withFont:_placeholderFont lineBreakMode:NSLineBreakByTruncatingTail];
#pragma clang diagnostic pop
	}
}

@end
