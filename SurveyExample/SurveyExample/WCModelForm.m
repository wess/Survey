//
//  WCModelForm.m
//  SurveyExample
//
//  Created by Wess Cope on 12/14/12.
//  Copyright (c) 2012 Wess Cope. All rights reserved.
//

#import "WCModelForm.h"

@implementation WCModelForm

- (SurveyField *)lastname
{
    SurveyField *field  = [SurveyField fieldWithPlaceholder:@"Wooooyaaa"];
    field.isRequired    = YES;
    
    return field;
}

+ (NSArray *)fields
{
    return @[@"lastname", @"firstname"];
}

@end
