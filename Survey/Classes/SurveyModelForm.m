//
//  SurveyModelForm.m
//  Survey
//
//  Created by Wess Cope on 1/22/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import "SurveyModelForm.h"

@implementation SurveyModelForm

- (id)init
{
    NSString *entityName                    = NSStringFromClass([[self class] managedObjectClass]);
    NSManagedObjectContext *context         = [[self class] managedObjectContext];
    NSEntityDescription *entityDescription  = [NSEntityDescription entityForName:entityName inManagedObjectContext:context];
    
    self = [super initWithEntityDescription:entityDescription];
    if(self)
    {
        
    }
    return self;
}

+ (Class)managedObjectClass
{
    @throw [NSException exceptionWithName:@"com.Survey.ModelForm.Error" reason:@"SurveyModelForm subclass requires managedObjectClass method to be overidden" userInfo:nil];
}

+ (NSManagedObjectContext *)managedObjectContext
{
    @throw [NSException exceptionWithName:@"com.Survey.ModelForm.Error" reason:@"SurveyModelForm subclass requires managedObjectContext to be overidden" userInfo:nil];
}

@end
