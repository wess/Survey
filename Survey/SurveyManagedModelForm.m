//
//  SurveyManagedModelForm.m
//  Survey
//
//  Created by Wess Cope on 2/22/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import "SurveyManagedModelForm.h"

@implementation SurveyManagedModelForm

- (id)init
{
    self = [super initWithEntityName:NSStringFromClass([[self class] managedObjectClass])];
    if (self)
    {
        
    }
    return self;
}

+ (Class)managedObjectClass
{
    @throw [NSException exceptionWithName:@"com.Survey.ManagedModelForm.Error" reason:@"SurveyManagedModelForm subclass requires managedObjectContext and managedObjectClass methods to be overidden" userInfo:nil];
    return nil;    
}

@end
