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
    field.shouldBeginEditing = ^(SurveyField *this, id field) {
        NSLog(@"We should begin editing");
        return YES;
    };
    
    field.didEndEditing = ^(SurveyField *this,id field) {
        NSString *value = ((UITextField *)field).text;
        NSLog(@"Field ended editing with Value: %@", value);
    };
    
    field.shouldReturn = ^BOOL(SurveyField *this, id field) {
        SurveyField  *nextField = [this getNextField];
      
        [this resignFirstResponder];
        [nextField becomeFirstResponder];
        
        return NO;
    };
    
    return field;
}

- (SurveyField *)lastname
{
    SurveyField *field  = [SurveyField fieldWithPlaceholder:@"Last Name"];
    field.isRequired    = YES;
    field.label         = @"Last Name";
    field.validationBlock   = ^(SurveyField *this, id form, id field, id value) {
        NSString *fieldValue = [(NSString *)value lowercaseString];
        NSLog(@"FIELD VALUE: %@", fieldValue);

        return [fieldValue isEqualToString:@"cope"];
    };
    
    return field;
}

- (SurveyField *)email
{
//    SurveyField *field  = [SurveyField fieldWithPlaceholder:@"Email"];
//    field.isRequired    = YES;
//    field.expression    = [[NSRegularExpression alloc] initWithPattern:@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}" options:0 error:nil];

//  Let's use your custom email field subclass
    SurveyField *field  = [SurveyEmailField fieldWithPlaceholder:@"Email Address"];
    field.isRequired    = YES;
    
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

+ (NSArray *)fields
{
   return @[@"firstname", @"lastname", @"email", @"city", @"state", @"zipcode"];
}

@end
