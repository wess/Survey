//
//  SurveyModelForm.h
//  Survey
//
//  Created by Wess Cope on 2/22/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "SurveyForm.h"

@interface SurveyModelForm : SurveyForm
- (id)initWithEntityName:(NSString *)entityName;
- (id)initWithEntityDescription:(NSEntityDescription *)entityDescription;
+ (NSManagedObjectContext *)managedObjectContext;
@end
