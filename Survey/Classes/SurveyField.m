//
//  SurveyField.m
//  Survey
//
//  Created by Wess Cope on 10/15/12.
//  Copyright (c) 2012 Wess Cope. All rights reserved.
//

#import "SurveyField.h"

@implementation SurveyField

- (id)init
{
    self = [super init];
    if(self)
    {
        _isRequired = NO;
    }
    return self;
}

+ (SurveyField *)fieldWithPlaceholder:(NSString *)placeholder
{
    SurveyField *field  = [[self alloc] init];
    field.placeholder   = placeholder;
    
    return field;
}

- (NSString *)value
{
    return self.field.text;
}

- (void)setValue:(NSString *)value
{
    self.field.text = value;
}

@end
