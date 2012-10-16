//
//  WCRegisterForm.m
//  SurveyExample
//
//  Created by Wess Cope on 10/15/12.
//  Copyright (c) 2012 Wess Cope. All rights reserved.
//

#import "WCRegisterForm.h"

@implementation WCRegisterForm
-(SurveyField *)firstname
{
    SurveyField *field  = [SurveyField fieldWithPlaceholder:@"First Name"];
    field.isRequired    = YES;
    field.label         = @"First Name";
    
    return field;
}

-(SurveyField *)lastname
{
    SurveyField *field  = [SurveyField fieldWithPlaceholder:@"Last Name"];
    field.isRequired    = YES;
    field.label         = @"Last Name";
    
    return field;
}

-(SurveyField *)city
{
    SurveyField *field  = [SurveyField fieldWithPlaceholder:@"City"];
    
    return field;
}

-(SurveyField *)state
{
    SurveyField *field  = [SurveyField fieldWithPlaceholder:@"State"];
    
    return field;
}

-(SurveyField *)zipcode
{
    SurveyField *field  = [SurveyField fieldWithPlaceholder:@"zipcode"];
    field.isRequired    = YES;
    field.label         = @"Zip Code";
    
    return field;    
}

@end
