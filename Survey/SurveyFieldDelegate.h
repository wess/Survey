//
//  SurveyFieldDelegate.h
//  Survey
//
//  Created by Wess Cope on 2/22/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 `SurveyFieldDelegate` is a class that handles all delegate operations for Survey fields, to allow for block based delegate callbacks.
 */

@interface SurveyFieldDelegate : NSObject<UITextFieldDelegate, UITextViewDelegate>

///-------------------------------------------------------------------------------------------
/// @name Proxy to allow delegate methods to be handled by blocks for Survey based fields.
///-------------------------------------------------------------------------------------------

@end