//
//  SurveyForm.h
//  Survey
//
//  Created by Wess Cope on 10/15/12.
//  Copyright (c) 2012 Wess Cope. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

static const char *getPropertyType(objc_property_t property);
NSDictionary *propertiesForClass(Class klass);

@class SurveyField;
@class SurveyFormModel;
@interface SurveyForm : NSObject
@property (readonly, nonatomic) NSArray         *fields;
@property (assign, nonatomic) SurveyFormModel   *model;
@property (readonly, nonatomic) NSDictionary    *values;
@property (readonly, nonatomic) NSDictionary    *fieldErrors;
@property (readonly, nonatomic) BOOL isValid;

+ (SurveyForm *)formWithSurveyModelName:(NSString *)modelName;
+ (SurveyForm *)formWithSurveyModelClass:(Class)modelClass;
+ (SurveyForm *)formWithSurveyModel:(id)modelInstance;

- (NSUInteger)getIndexOfField:(SurveyField *)field;
- (SurveyField *)getFieldAtTabIndex:(NSUInteger)index;

- (id)valueForField:(NSString *)fieldName;
@end
