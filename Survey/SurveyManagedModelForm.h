//
//  SurveyManagedModelForm.h
//  Survey
//
//  Created by Wess Cope on 2/22/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SurveyModelForm.h"

@interface SurveyManagedModelForm : SurveyModelForm
+ (Class)managedObjectClass;
@end
