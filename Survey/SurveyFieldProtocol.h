//
//  SurveyFieldProtocol.h
//  Survey
//
//  Created by Wess Cope on 4/24/14.
//  Copyright (c) 2014 Wess Cope. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SurveyConstants.h"
#pragma once

@class SurveyForm;
@protocol SurveyFieldProtocol <NSObject>

/**
 Just a protocal property to ensure a protocol is available.
 */
@property (weak, nonatomic) id delegate;

/**
 Callback that is triggered when the field fails validation.
 */
@property  (copy, nonatomic) SurveyOnFieldErrorBlock    onError;

/**
 Access to the fields parent form.
 */
@property (strong, nonatomic) SurveyForm                *form;

/**
 Field title
 */
@property (copy, nonatomic) NSString                    *title;

/**
 A list of errors the field has.
 */
@property (readonly, nonatomic) NSDictionary            *errors;

/**
 Checks and returns if the field's value passes it's provided validation types.
 
 @return YES/NO if the field's value is valid.
 */
- (BOOL)isValid;


@end
