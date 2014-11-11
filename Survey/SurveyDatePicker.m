//
//  SurveyDatePicker.m
//  Survey
//
//  Created by Wess Cope on 11/11/14.
//  Copyright (c) 2014 Wess Cope. All rights reserved.
//

#import "SurveyDatePicker.h"
#import "NSLayoutConstraint+Survey.h"

@interface SurveyDatePicker()
@property (strong, nonatomic) UIToolbar     *toolbar;
@property (strong, nonatomic) UIPickerView  *picker;
@end

@implementation SurveyDatePicker

#pragma mark - Layout
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.toolbar addConstraints:[NSLayoutConstraint constraintsToFillHorizontallyView:self withView:self.toolbar]];
    [self.toolbar addConstraint:[NSLayoutConstraint constraintToSetHeight:44 forView:self.toolbar]];
    
    [self.picker addConstraints:[NSLayoutConstraint constraintsToFillHorizontallyView:self withView:self.picker]];
    [self.picker addConstraint:[NSLayoutConstraint constraintWithItem:self.picker attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:0 constant:0]];
    [self.picker addConstraint:[NSLayoutConstraint constraintWithItem:self.picker attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.toolbar attribute:NSLayoutAttributeBottom multiplier:0 constant:0]];
}

#pragma mark - Setters
- (void)setDataSource:(id<UIPickerViewDataSource>)dataSource
{
    self.picker.dataSource = dataSource;
}

- (void)setDelegate:(id<UIPickerViewDelegate>)delegate
{
    self.delegate = delegate;
}

#pragma mark - Getters
- (UIToolbar *)toolbar
{
    if(_toolbar)
        return _toolbar;
    
    _toolbar = [[UIToolbar alloc] initWithFrame:CGRectZero];
    
    return _toolbar;
}

- (UIPickerView *)picker
{
    if(_picker)
        return _picker;
    
    _picker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    
    return _picker;
}


@end
