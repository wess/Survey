//
//  WCEasyModelForm.m
//  SurveyExample
//
//  Created by Wess Cope on 1/22/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import "WCEasyModelForm.h"
#import "WCCoreData.h"
#import "Person.h"

@implementation WCEasyModelForm

+ (Class)managedObjectClass
{
    return [Person class];
}

+ (NSManagedObjectContext *)managedObjectContext
{
    return [[WCCoreData instance] managedObjectContext];
}

- (SurveyField *)lastname
{
    SurveyField *field  = [SurveyField fieldWithPlaceholder:@"Wooooyaaa"];
    field.isRequired    = YES;
    
    return field;
}

+ (NSArray *)fields
{
    return @[@"firstname", @"lastname"];
}

@end
