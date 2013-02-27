//
//  WCRegisterForm.m
//  SurveyExample
//
//  Created by Wess Cope on 10/15/12.
//  Copyright (c) 2012 Wess Cope. All rights reserved.
//

#import "WCRegisterForm.h"

@implementation WCRegisterForm

//- (SurveyTextField  *)firstname
//{
//    SurveyTextField *field = [[SurveyTextField alloc] init];
//    field.placeholder = @"Firstname";
//    
//    return field;
//}
//
//- (SurveyTextField  *)lastname
//{
//    SurveyTextField *field = [[SurveyTextField alloc] init];
//    field.placeholder = @"Lastname";
//    
//    return field;
//}
//
//- (SurveyTextField  *)email
//{
//    SurveyTextField *field = [[SurveyTextField alloc] init];
//    field.placeholder = @"Email";
//    
//    return field;
//}
//
//- (SurveyTextField  *)city
//{
//    SurveyTextField *field = [[SurveyTextField alloc] init];
//    field.placeholder = @"City";
//    
//    return field;
//}
//
//- (SurveyTextField  *)state
//{
//    SurveyTextField *field = [[SurveyTextField alloc] init];
//    field.placeholder = @"State";
//    
//    return field;
//}
//
//- (SurveyTextField  *)zipcode
//{
//    SurveyTextField *field = [[SurveyTextField alloc] init];
//    field.placeholder = @"Zipcode";
//    
//    return field;
//}

+ (NSArray *)fields
{
   return @[@"firstname", @"lastname", @"email", @"city", @"state", @"zipcode"];
}

@end
