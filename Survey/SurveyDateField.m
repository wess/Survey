//
//  SurveyDateField.m
//  Survey
//
//  Created by Wess Cope on 11/7/14.
//  Copyright (c) 2014 Wess Cope. All rights reserved.
//

@import UIKit;
#import "NSLayoutConstraint+Survey.h"
#import "SurveyDateField.h"
#import "SurveyForm.h"
#import "SurveyValidator.h"
#import "SurveyDatePicker.h"

@interface SurveyDateField()<UIPickerViewDataSource, UIPickerViewDelegate>
@property (strong, nonatomic)   UILabel             *placeholderLabel;
@property (strong, nonatomic)   SurveyDatePicker    *pickerView;
@property (nonatomic)           NSUInteger          pickerCount;
@property (nonatomic)           BOOL                wantsSurveyDateComponentDay;
@property (nonatomic)           BOOL                wantsSurveyDateComponentHour;
@property (nonatomic)           BOOL                wantsSurveyDateComponentMinute;
@property (nonatomic)           BOOL                wantsSurveyDateComponentMonth;
@property (nonatomic)           BOOL                wantsSurveyDateComponentSecond;
@property (nonatomic)           BOOL                wantsSurveyDateComponentYear;
@property (strong, nonatomic)   NSArray             *days;
@property (strong, nonatomic)   NSArray             *hours;
@property (strong, nonatomic)   NSArray             *minutes;
@property (strong, nonatomic)   NSArray             *months;
@property (strong, nonatomic)   NSArray             *seconds;
@property (strong, nonatomic)   NSArray             *years;

@end

@implementation SurveyDateField
- (void)setup
{
    self.components     = SurveyDateComponentDay | SurveyDateComponentMonth;
    self.date           = [NSDate date];
    self.contentInsets  = (UIEdgeInsets){.top = 2, .right = 2, .bottom = 2, .left = 2};
}

- (instancetype)init
{
    self = [super init];
    if (self)
        [self setup];

    return self;
}

- (instancetype)initWithDateComponents:(SurveyDateComponents)components
{
    self = [super init];
    if (self)
    {
        [self setup];

        self.components = components;
    }
    return self;
}

- (BOOL)canBecomeFirstResponder
{
    NSLog(@"BECAME RESPONDER");
    return YES;
}

- (BOOL)canResignFirstResponder
{
    NSLog(@"RESIGNED RESPONDER");
    return YES;
}

#pragma mark - Touch

#pragma mark - Layout
- (void)updateConstraints
{
    [self.placeholderLabel removeConstraints:self.placeholderLabel.constraints];
    [self.placeholderLabel  addConstraints:[NSLayoutConstraint constraintsToFillView:self withView:self.placeholderLabel edgeInsets:self.contentInsets]];
    
    [super updateConstraints];
}

#pragma mark - Setters
- (void)setComponents:(SurveyDateComponents)components
{
    [self willChangeValueForKey:@"components"];
    
    _components         = components;
    self.pickerCount    = 0;
    
    self.wantsSurveyDateComponentDay    = NO;
    self.wantsSurveyDateComponentHour   = NO;
    self.wantsSurveyDateComponentMinute = NO;
    self.wantsSurveyDateComponentMonth  = NO;
    self.wantsSurveyDateComponentSecond = NO;
    self.wantsSurveyDateComponentYear   = NO;

    if(_components & SurveyDateComponentDay)
    {
        self.pickerCount++;
        self.wantsSurveyDateComponentDay = YES;
    }
    
    if(_components & SurveyDateComponentHour)
    {
        self.pickerCount++;
        self.wantsSurveyDateComponentHour = YES;
    }
    
    if(_components & SurveyDateComponentMinute)
    {
        self.pickerCount++;
        self.wantsSurveyDateComponentMinute = YES;
    }

    if(_components & SurveyDateComponentMonth)
    {
        self.pickerCount++;
        self.wantsSurveyDateComponentMonth = YES;
    }

    if(_components & SurveyDateComponentSecond)
    {
        self.pickerCount++;
        self.wantsSurveyDateComponentSecond = YES;
    }

    if(_components & SurveyDateComponentYear)
    {
        self.pickerCount++;
        self.wantsSurveyDateComponentYear = YES;
    }
    
    [self didChangeValueForKey:@"componets"];
}

#pragma mark - Getters
- (UILabel *)placeholderLabel
{
    if(_placeholderLabel)
        return _placeholderLabel;
    
    _placeholderLabel               = [[UILabel alloc] initWithFrame:CGRectZero];
    _placeholderLabel.font          = self.font?: [UIFont systemFontOfSize:12];
    _placeholderLabel.textColor     = self.textColor?: [UIColor blackColor];
    _placeholderLabel.textAlignment = self.textAlignment?: NSTextAlignmentNatural;
    
    [self addSubview:_placeholderLabel];
    
    return _placeholderLabel;
}


- (SurveyDatePicker *)pickerView
{
    if(_pickerView)
        return _pickerView;
    
    _pickerView             = [[SurveyDatePicker alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, ([UIScreen mainScreen].bounds.size.height / 2))];
    _pickerView.dataSource  = self;
    _pickerView.delegate    = self;
    
    return _pickerView;
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return self.pickerCount;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 3;
}

#pragma mark - UIPickerViewDelegate
- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [[NSAttributedString alloc] initWithString:@"Testing" attributes:@{NSFontAttributeName: self.font, NSForegroundColorAttributeName: self.textColor}];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

@end
