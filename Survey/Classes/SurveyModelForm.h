//
//  SurveyModelForm.h
//  Survey
//
//  Created by Wess Cope on 1/22/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SurveyObjectModelForm.h"

@interface SurveyModelForm : SurveyObjectModelForm
+ (Class)managedObjectClass;
+ (NSManagedObjectContext *)managedObjectContext;
@end
