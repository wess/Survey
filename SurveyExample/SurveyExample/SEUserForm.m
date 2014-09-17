//
//  SEUserForm.m
//  SurveyExample
//
//  Created by Wess Cope on 4/24/14.
//  Copyright (c) 2014 Wess Cope. All rights reserved.
//

#import "SEUserForm.h"

@implementation SEUserForm
@dynamic username;
@dynamic password;

+ (void)setupFormDefaults:(SEUserForm *)form
{
    form.defaultOnError = ^(SurveyTextField *field, NSDictionary *errors) {
        field.backgroundColor   = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:0.2];
        field.placeholderColor  = [UIColor redColor];
    };
 
}

+ (void)setupUsername:(SurveyTextField *)field
{
    field.returnKeyType     = UIReturnKeyNext;
    field.shouldReturn      = ^BOOL(SurveyTextField *field) {
        [field moveToNextField];

        return NO;
    };

    field.shouldBeginEditing = ^BOOL(SurveyTextField *field) {
        field.backgroundColor   = nil;
        field.placeholderColor  = nil;

        return YES;
    };
}

+ (NSArray *)fields
{
    return @[@"username", @"password"];
}

@end
