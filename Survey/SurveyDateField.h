//
//  SurveyDateField.h
//  Survey
//
//  Created by Wess Cope on 11/7/14.
//  Copyright (c) 2014 Wess Cope. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SurveyFieldProtocol.h"
#import "SurveyConstants.h"
#pragma once

typedef NS_OPTIONS(NSUInteger, SurveyDateComponents) {
    SurveyDateComponentSecond   = 1 << 0,
    SurveyDateComponentMinute   = 1 << 1,
    SurveyDateComponentHour     = 1 << 2,
    SurveyDateComponentDay      = 1 << 3,
    SurveyDateComponentMonth    = 1 << 4,
    SurveyDateComponentYear     = 1 << 5
};

@class SurveyForm;
@interface SurveyDateField : UIControl<SurveyFieldProtocol>
@property (weak, nonatomic)     id                      delegate;
@property (copy, nonatomic)     NSString                *title;
@property (copy, nonatomic)     NSString                *placeholder;
@property (copy, nonatomic)     UIColor                 *placeholderColor;
@property (copy, nonatomic)     UIFont                  *font;
@property (copy, nonatomic)     UIColor                 *textColor;
@property (nonatomic)           UIEdgeInsets            contentInsets;
@property (nonatomic)           NSTextAlignment         textAlignment;
@property  (copy, nonatomic)    SurveyOnFieldErrorBlock onError;
@property (strong, nonatomic)   SurveyForm              *form;
@property (readonly, nonatomic) NSDictionary            *errors;
@property (copy, nonatomic)     NSDate                  *date;
@property (nonatomic)           SurveyDateComponents    components;

- (instancetype)initWithDateComponents:(SurveyDateComponents)components;
- (BOOL)isValid;

@end
