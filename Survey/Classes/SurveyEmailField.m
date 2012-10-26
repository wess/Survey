//
//  SurveyEmailField.m
//  Survey
//
//  Created by Wess Cope on 10/26/12.
//  Copyright (c) 2012 Wess Cope. All rights reserved.
//

#import "SurveyEmailField.h"

@implementation SurveyEmailField

+ (SurveyField *)fieldWithPlaceholder:(NSString *)placeholder
{
    NSString *emailRegex =  @"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
                            @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
                            @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
                            @"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
                            @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
                            @"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
                            @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
    
    SurveyField *field  = [super fieldWithPlaceholder:placeholder];
    field.expression    = [[NSRegularExpression alloc] initWithPattern:emailRegex options:0 error:nil];
    field.errorMessage  = @"Invalid email address";
    
    return field;
}

@end
