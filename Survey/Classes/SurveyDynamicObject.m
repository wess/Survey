//
//  SurveyDynamicObject.m
//  Survey
//
//  Created by Wess Cope on 12/14/12.
//  Copyright (c) 2012 Wess Cope. All rights reserved.
//

#import "SurveyDynamicObject.h"

#define SURVEY_SELECTOR_SUFFIX   @":"

@implementation SurveyDynamicObject

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    NSMethodSignature *signature = [super methodSignatureForSelector:aSelector];
    
    if(aSelector == nil)
    {
        NSString *selectorName = [NSStringFromSelector(aSelector) lowercaseString];
        signature = [NSMethodSignature signatureWithObjCTypes:(([selectorName hasSuffix:SURVEY_SELECTOR_SUFFIX])? "v@:@" : "@@:")];
    }
    
    return signature;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    NSString *selectorName = [NSStringFromSelector([anInvocation selector]) lowercaseString];
    if([selectorName hasSuffix:SURVEY_SELECTOR_SUFFIX])
    {
        NSString *property = [selectorName substringWithRange:NSMakeRange(3, selectorName.length - 4)];
        id invocationValue;
        [anInvocation getArgument:&invocationValue atIndex:2];
        [self saveObject:invocationValue forKey:property];
    }
    else
    {
        id returnValue = [self getObjectForKey:selectorName];
        [anInvocation setReturnValue:&returnValue];
    }
}

- (void)saveObject:(id)value forKey:(NSString *)key
{
    [NSException raise:@"SurveyDynamicObject" format:@"Must override saveObject: in child class"];
}

- (id)getObjectForKey:(NSString *)key
{
    [NSException raise:@"SurveyDynamicObject" format:@"Must override getObjectForKey: in child class"];
    return nil;
}


@end
