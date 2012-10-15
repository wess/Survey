//
//  SurveyField.h
//  Survey
//
//  Created by Wess Cope on 10/15/12.
//  Copyright (c) 2012 Wess Cope. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SurveyField : NSObject
@property (copy, nonatomic)   NSString            *entityName;
@property (copy, nonatomic)   NSString            *label;
@property (copy, nonatomic)   NSString            *placeholder;
@property (copy, nonatomic)   NSString            *value;
@property (readwrite, nonatomic) BOOL             isSecure;
@property (strong, nonatomic) Class               fieldClass;
@property (strong, nonatomic) UITextField         *field;
@property (strong, nonatomic) NSRegularExpression *expression;
@property (readwrite, nonatomic) BOOL isRequired;

+ (SurveyField *)fieldWithPlaceholder:(NSString *)placeholder;

@end
