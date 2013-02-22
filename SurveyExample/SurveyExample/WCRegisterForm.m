//
//  WCRegisterForm.m
//  SurveyExample
//
//  Created by Wess Cope on 10/15/12.
//  Copyright (c) 2012 Wess Cope. All rights reserved.
//

#import "WCRegisterForm.h"

@implementation WCRegisterForm

+ (NSArray *)fields
{
   return @[@"firstname", @"lastname", @"email", @"city", @"state", @"zipcode"];
}

@end
