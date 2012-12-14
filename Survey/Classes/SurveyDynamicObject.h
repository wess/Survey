//
//  SurveyDynamicObject.h
//  Survey
//
//  Created by Wess Cope on 12/14/12.
//  Copyright (c) 2012 Wess Cope. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SurveyDynamicObject : NSObject
- (void)saveObject:(id)value forKey:(NSString *)key;
- (id)getObjectForKey:(NSString *)key;
@end
