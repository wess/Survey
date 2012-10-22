//
//  WCRegisterForm.m
//  SurveyExample
//
//  Created by Wess Cope on 10/15/12.
//  Copyright (c) 2012 Wess Cope. All rights reserved.
//

#import "WCRegisterForm.h"

@implementation WCRegisterForm
- (SurveyField *)firstname
{
    SurveyField *field  = [SurveyField fieldWithPlaceholder:@"First Name"];
    field.isRequired    = YES;
    field.label         = @"First Name";
    field.shouldBeginEditing = ^(id field) {
        NSLog(@"OH YEAH, WE BE EDITING");

        return YES;
    };
    
    field.didEndEditing = ^(id field) {
        NSString *value = ((UITextField *)field).text;
        
        NSLog(@"Field Value: %@", value);
    };
    
    return field;
}

- (SurveyField *)lastname
{
    SurveyField *field  = [SurveyField fieldWithPlaceholder:@"Last Name"];
    field.isRequired    = YES;
    field.label         = @"Last Name";
    field.validationBlock   = ^(id form, id field, id value) {
        NSString *fieldValue = [(NSString *)value lowercaseString];
        NSLog(@"FIELD VALUE: %@", fieldValue);

        return [fieldValue isEqualToString:@"cope"];
    };
    
    return field;
}

- (SurveyField *)email
{
    SurveyField *field  = [SurveyField fieldWithPlaceholder:@"Email"];
    field.isRequired    = YES;
    field.expression    = [[NSRegularExpression alloc] initWithPattern:@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}" options:0 error:nil];

    return field;
}

- (SurveyField *)city
{
    SurveyField *field  = [SurveyField fieldWithPlaceholder:@"City"];
    
    return field;
}

- (SurveyField *)state
{
    SurveyField *field  = [SurveyField fieldWithPlaceholder:@"State"];
    
    return field;
}

- (SurveyField *)zipcode
{
    SurveyField *field  = [SurveyField fieldWithPlaceholder:@"zipcode"];
    field.isRequired    = YES;
    field.label         = @"Zip Code";
    
    return field;    
}

@end
