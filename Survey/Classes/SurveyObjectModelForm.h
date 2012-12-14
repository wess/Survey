//
//  SurveyObjectModelForm.h
//  Survey
//
//  Created by Wess Cope on 12/14/12.
//  Copyright (c) 2012 Wess Cope. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <objc/runtime.h>
#import "SurveyForm.h"
#import "SurveyDynamicObject.h"

@interface SurveyObjectModelForm : SurveyDynamicObject
@property (readonly, nonatomic) SurveyForm          *form;
@property (readonly, nonatomic) NSArray             *fields;
@property (readonly, nonatomic) BOOL                isValid;
@property (strong, nonatomic) NSMutableDictionary   *properties;

+ (SurveyObjectModelForm *)formFromEntityDescription:(NSEntityDescription *)entityDescription;
- (id)initWithEntityDescription:(NSEntityDescription *)entityDescription;
+ (NSArray *)fields;
@end
