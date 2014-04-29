//
//  SurveyValidator.m
//  Survey
//
//  Created by Wess Cope on 4/24/14.
//  Copyright (c) 2014 Wess Cope. All rights reserved.
//

#import "SurveyValidator.h"

NSString *const SurveyValidationRequired            = @"SurveyValidationRequired";
NSString *const SurveyValidationAlphaNumericOnly    = @"SurveyValidationAlphaNumericOnly";
NSString *const SurveyValidationAlphaOnly           = @"SurveyValidationAlphaOnly";
NSString *const SurveyValidationNumericOnly         = @"SurveyValidationNumericOnly";
NSString *const SurveyValidationEmailAddress        = @"SurveyValidationEmailAddress";

static NSMutableDictionary *_SurveyValidationBlocks = nil;

@interface SurveyValidator()
@property (readonly, nonatomic) SurveyValidationBlock   requiredBlock;
@property (readonly, nonatomic) SurveyValidationBlock   alphaNumericBlock;
@property (readonly, nonatomic) SurveyValidationBlock   alphaOnlyBlock;
@property (readonly, nonatomic) SurveyValidationBlock   numericOnlyBlock;
@property (readonly, nonatomic) SurveyValidationBlock   emailAddressBlock;
@property (strong, nonatomic) NSDictionary              *validators;
@end

@implementation SurveyValidator
@synthesize requiredBlock       = _requiredBlock;
@synthesize alphaNumericBlock   = _alphaNumericBlock;
@synthesize alphaOnlyBlock      = _alphaOnlyBlock;
@synthesize numericOnlyBlock    = _numericOnlyBlock;
@synthesize emailAddressBlock   = _emailAddressBlock;

+ (void)registerValidation:(NSString *)validationName handler:(SurveyValidationBlock)block
{
    if(!_SurveyValidationBlocks)
        _SurveyValidationBlocks = [[NSMutableDictionary alloc] init];
    
    _SurveyValidationBlocks[validationName] = [block copy];
}

- (instancetype)init
{
    self = [super init];

    if (self)
        [self resetValidationsToDefault];

    return self;
}

- (void)registerValidation:(NSString *)validationName handler:(SurveyValidationBlock)block
{
    NSMutableDictionary *validators = [self.validators mutableCopy];
    validators[validationName]      = [block copy];
    
    self.validators = [validators copy];
}

- (BOOL)validateString:(NSString *)string usingValidator:(NSString *)validator
{
    SurveyValidationBlock block = self.validators[validator];
    return block(string);
}

- (void)resetValidationsToDefault
{
    SurveyRegisterGlobalValidator(SurveyValidationRequired, self.requiredBlock);
    SurveyRegisterGlobalValidator(SurveyValidationRequired, self.requiredBlock);
    SurveyRegisterGlobalValidator(SurveyValidationAlphaNumericOnly, self.alphaNumericBlock);
    SurveyRegisterGlobalValidator(SurveyValidationAlphaOnly, self.alphaOnlyBlock);
    SurveyRegisterGlobalValidator(SurveyValidationNumericOnly, self.numericOnlyBlock);
    SurveyRegisterGlobalValidator(SurveyValidationEmailAddress, self.emailAddressBlock);
}

#pragma mark - Getters
- (NSDictionary *)validators
{
    if(_validators)
        return _validators;
    
    _validators = [_SurveyValidationBlocks copy];
    
    return _validators;
}

#pragma mark - Default Validation Blocks -

- (SurveyValidationBlock)requiredBlock
{
    if(_requiredBlock)
        return _requiredBlock;

    _requiredBlock = ^BOOL(NSString *value) {
        return (![value isEqualToString:@""] && value.length > 0);
    };
    
    return _requiredBlock;
}

- (SurveyValidationBlock)alphaNumericBlock
{
    if(_alphaNumericBlock)
        return _alphaNumericBlock;

    _alphaNumericBlock = ^BOOL(NSString *value) {
        NSString *pattern           = @"[^0-9a-zA-Z]";
        NSRegularExpression *regex  = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:nil];
        NSArray *matches            = [regex matchesInString:value options:0 range:NSMakeRange(0, value.length)];
        
        return (matches.count > 0)? NO : YES;
    };
    
    return _alphaNumericBlock;
}

- (SurveyValidationBlock)alphaOnlyBlock
{
    if(_alphaOnlyBlock)
        return _alphaOnlyBlock;

    _alphaOnlyBlock = ^BOOL(NSString *value) {
        NSString *pattern           = @"[^a-zA-Z]";
        NSRegularExpression *regex  = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:nil];
        NSArray *matches            = [regex matchesInString:value options:0 range:NSMakeRange(0, value.length)];
        
        return (matches.count > 0)? NO : YES;
    };
    
    return _alphaOnlyBlock;
}

- (SurveyValidationBlock)numericOnlyBlock
{
    if(_numericOnlyBlock)
        return _numericOnlyBlock;

    _numericOnlyBlock = ^BOOL(NSString *value) {
        NSString *pattern           = @"[^0-9]";
        NSRegularExpression *regex  = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:nil];
        NSArray *matches            = [regex matchesInString:value options:0 range:NSMakeRange(0, value.length)];
        
        return (matches.count > 0)? NO : YES;
    };

    return _numericOnlyBlock;
}

- (SurveyValidationBlock)emailAddressBlock
{
    if(_emailAddressBlock)
        return _emailAddressBlock;

    _emailAddressBlock = ^BOOL(NSString *value) {
        NSString *pattern           = @"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$";
        NSRegularExpression *regex  = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:nil];
        NSArray *matches            = [regex matchesInString:value options:0 range:NSMakeRange(0, value.length)];
        
        return (matches.count < 1)? NO : YES;
    };
    
    return _emailAddressBlock;
}

@end
