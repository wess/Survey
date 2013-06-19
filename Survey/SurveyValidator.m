//
//  SurveyValidator.m
//  Survey
//
//  Created by Wess Cope on 2/22/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import "SurveyValidator.h"

@interface SurveyValidator()
@property (readonly, nonatomic) SurveyValidationBlock requiredBlock;
@property (readonly, nonatomic) SurveyValidationBlock alphaNumericBlock;
@property (readonly, nonatomic) SurveyValidationBlock alphaOnlyBlock;
@property (readonly, nonatomic) SurveyValidationBlock numericOnlyBlock;
@property (readonly, nonatomic) SurveyValidationBlock emailAddressBlock;
@property (strong, nonatomic) NSMutableDictionary *blocks;

@end

@implementation SurveyValidator
@synthesize requiredBlock       = _requiredBlock;
@synthesize alphaNumericBlock   = _alphaNumericBlock;
@synthesize alphaOnlyBlock      = _alphaOnlyBlock;
@synthesize numericOnlyBlock    = _numericOnlyBlock;
@synthesize emailAddressBlock   = _emailAddressBlock;

+ (instancetype)instance
{
    static SurveyValidator *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[SurveyValidator alloc] init];
    });
    
    return _instance;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        self.blocks = [[NSMutableDictionary alloc] init];
        [self resetValidatorsToDefault];
    }
    return self;
}

- (void)registerValidation:(NSString *)validationName withBlock:(SurveyValidationBlock)block
{
    [self.blocks setObject:block forKey:validationName];
}

- (void)resetValidatorsToDefault
{
    [self registerValidation:SurveyValidationRequired            withBlock:self.requiredBlock];
    [self registerValidation:SurveyValidationAlphaNumericOnly    withBlock:self.alphaNumericBlock];
    [self registerValidation:SurveyValidationAlphaOnly           withBlock:self.alphaOnlyBlock];
    [self registerValidation:SurveyValidationNumericOnly         withBlock:self.numericOnlyBlock];
    [self registerValidation:SurveyValidationEmailAddress        withBlock:self.emailAddressBlock];

}

- (BOOL)validateString:(NSString *)value withValidator:(NSString *)validatorName
{
    SurveyValidationBlock block = [self.blocks objectForKey:validatorName];
    return block(value);
}

+ (void)registerValidation:(NSString *)validationName withBlock:(SurveyValidationBlock)block
{
    [[SurveyValidator instance] registerValidation:validationName withBlock:block];
}

+ (BOOL)validateString:(NSString *)value withValidator:(NSString *)validatorName
{
    return [[SurveyValidator instance] validateString:value withValidator:validatorName];
}


#pragma mark - Default Validation Blocks -

- (SurveyValidationBlock)requiredBlock
{
    if(!_requiredBlock)
    {
        _requiredBlock = ^BOOL(NSString *value) {
            return (![value isEqualToString:@""] && value.length > 0);
        };
    }
    
    return _requiredBlock;
}

- (SurveyValidationBlock)alphaNumericBlock
{
    if(!_alphaNumericBlock)
    {
        _alphaNumericBlock = ^BOOL(NSString *value) {
            NSString *pattern           = @"[^0-9a-zA-Z]";
            NSRegularExpression *regex  = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:nil];
            NSArray *matches            = [regex matchesInString:value options:0 range:NSMakeRange(0, value.length)];
            
            return (matches.count > 0)? NO : YES;
        };
    }
    
    return _alphaNumericBlock;
}

- (SurveyValidationBlock)alphaOnlyBlock
{
    if(!_alphaOnlyBlock)
    {    
        _alphaOnlyBlock = ^BOOL(NSString *value) {
            NSString *pattern           = @"[^a-zA-Z]";
            NSRegularExpression *regex  = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:nil];
            NSArray *matches            = [regex matchesInString:value options:0 range:NSMakeRange(0, value.length)];
            
            return (matches.count > 0)? NO : YES;
        };
    }
    
    return _alphaOnlyBlock;
}

- (SurveyValidationBlock)numericOnlyBlock
{
    if(!_numericOnlyBlock)
    {
        _numericOnlyBlock = ^BOOL(NSString *value) {
            NSString *pattern           = @"[^0-9]";
            NSRegularExpression *regex  = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:nil];
            NSArray *matches            = [regex matchesInString:value options:0 range:NSMakeRange(0, value.length)];
            
            return (matches.count > 0)? NO : YES;
        };
    }
    
    return _numericOnlyBlock;
}

- (SurveyValidationBlock)emailAddressBlock
{
    if(!_emailAddressBlock)
    {
        _emailAddressBlock = ^BOOL(NSString *value) {
            NSString *pattern           = @"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$";
            NSRegularExpression *regex  = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:nil];
            NSArray *matches            = [regex matchesInString:value options:0 range:NSMakeRange(0, value.length)];
            
            return (matches.count < 1)? NO : YES;
        };
    }
    
    return _emailAddressBlock;
}



@end
