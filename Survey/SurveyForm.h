//
//  SurveyForm.h
//  Survey
//
//  Created by Wess Cope on 2/22/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "SurveyFieldDelegate.h"

static const char *getPropertyType(objc_property_t property);
NSDictionary *propertiesForClass(Class klass);

@interface SurveyForm : NSObject
{
    @protected
        NSArray             *fieldReferenceTable;
        SurveyFieldDelegate *fieldDelegate;
    
//    @public
//        NSArray         *fields;
//        NSDictionary    *values;
//        NSDictionary    *errors;
//        BOOL            isValid;
}

@property (strong, nonatomic) SurveyFieldDelegate *fieldDelegate;
@property (strong, nonatomic) NSArray *fieldReferenceTable;
@property (readonly, nonatomic) NSArray         *fields;
@property (readonly, nonatomic) NSDictionary    *values;
@property (readonly, nonatomic) NSDictionary    *errors;
@property (readonly, nonatomic) BOOL            isValid;

- (NSUInteger)indexOfField:(id)field;
- (id)getFieldAtTabIndex:(NSUInteger)index;

+ (NSArray *)fields;

@end
