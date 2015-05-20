//
//  NSObject+Survey.m
//  Survey
//
//  Created by Wess Cope on 4/24/14.
//  Copyright (c) 2014 Wess Cope. All rights reserved.
//

#import "NSObject+Survey.h"
#import <objc/runtime.h>

@implementation NSObject (Survey)
static const char *getPropertyType(objc_property_t property)
{
    const char *attributes = property_getAttributes(property);
    
    char buffer[1 + strlen(attributes)];
    strcpy(buffer, attributes);
    char *state = buffer, *attribute;
    
    while ((attribute = strsep(&state, ",")) != NULL)
    {
        if (attribute[0] == 'T' && attribute[1] != '@')
            return (const char *)[[NSData dataWithBytes:(attribute + 1) length:strlen(attribute) - 1] bytes];
        else if (attribute[0] == 'T' && attribute[1] == '@' && strlen(attribute) == 2)
            return "id";
        else if (attribute[0] == 'T' && attribute[1] == '@')
            return (const char *)[[NSData dataWithBytes:(attribute + 3) length:strlen(attribute) - 4] bytes];
    }
    
    return "";
}


+ (NSDictionary *)survey_classProperties
{
    NSMutableDictionary *results = [[NSMutableDictionary alloc] init];
    unsigned int outCount;
    
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    
    for(NSUInteger index = 0; index < outCount; index++)
    {
        objc_property_t property    = properties[index];
        const char *name            = property_getName(property);
        
        if(name)
        {
            NSString *propertyName = [NSString stringWithUTF8String:name];
            NSString *propertyType = [NSString stringWithUTF8String:getPropertyType(property)];
            
            if(propertyName && propertyType)
                results[propertyName] = [propertyType copy];
        }
    }
    
    free(properties);
    
    return [results copy];
}
@end
