//
//  NSLayoutConstraint+Survey.m
//  Survey
//
//  Created by Wess Cope on 11/11/14.
//  Copyright (c) 2014 Wess Cope. All rights reserved.
//

#import "NSLayoutConstraint+Survey.h"

@implementation NSLayoutConstraint (Survey)
#pragma mark - Centering


+ (NSArray *)constraintsToCenterView:(UIView *)viewToCenter
                   withReferenceView:(UIView *)referenceView
{
    return @[[self constraintsToCenterHorizontallyView:viewToCenter
                                     withReferenceView:referenceView],
             [self constraintsToCenterVerticallyView:viewToCenter
                                   withReferenceView:referenceView]];
}


+ (NSLayoutConstraint *)constraintsToCenterVerticallyView:(UIView *)viewToCenter
                                        withReferenceView:(UIView *)referenceView
{
    return [NSLayoutConstraint constraintWithItem:viewToCenter
                                        attribute:NSLayoutAttributeCenterY
                                        relatedBy:NSLayoutRelationEqual
                                           toItem:referenceView
                                        attribute:NSLayoutAttributeCenterY
                                       multiplier:1.0f
                                         constant:0.0f];
}


+ (NSLayoutConstraint *)constraintsToCenterHorizontallyView:(UIView *)viewToCenter
                                          withReferenceView:(UIView *)referenceView
{
    return [NSLayoutConstraint constraintWithItem:viewToCenter
                                        attribute:NSLayoutAttributeCenterX
                                        relatedBy:NSLayoutRelationEqual
                                           toItem:referenceView
                                        attribute:NSLayoutAttributeCenterX
                                       multiplier:1.0f
                                         constant:0.0f];
}


#pragma mark - Filling


+ (NSArray *)constraintsToFillHorizontallyView:(UIView *)viewToFill
                                      withView:(UIView *)view
{
    return [self constraintsToFillHorizontallyView:viewToFill
                                          withView:view
                                        edgeInsets:UIEdgeInsetsZero];
}


+ (NSArray *)constraintsToFillHorizontallyView:(UIView *)viewToFill
                                      withView:(UIView *)view
                                    edgeInsets:(UIEdgeInsets)edgeInsets
{
    return @[[NSLayoutConstraint constraintWithItem:view
                                          attribute:NSLayoutAttributeLeading
                                          relatedBy:NSLayoutRelationEqual
                                             toItem:viewToFill
                                          attribute:NSLayoutAttributeLeading
                                         multiplier:1.0f
                                           constant:edgeInsets.left],
             [NSLayoutConstraint constraintWithItem:view
                                          attribute:NSLayoutAttributeTrailing
                                          relatedBy:NSLayoutRelationEqual
                                             toItem:viewToFill
                                          attribute:NSLayoutAttributeTrailing
                                         multiplier:1.0f
                                           constant:-edgeInsets.right]];
}


+ (NSArray *)constraintsToFillVerticallyView:(UIView *)viewToFill
                                    withView:(UIView *)view
{
    return [self constraintsToFillVerticallyView:viewToFill
                                        withView:view
                                      edgeInsets:UIEdgeInsetsZero];
}


+ (NSArray *)constraintsToFillVerticallyView:(UIView *)viewToFill
                                    withView:(UIView *)view
                                  edgeInsets:(UIEdgeInsets)edgeInsets
{
    return @[[NSLayoutConstraint constraintWithItem:view
                                          attribute:NSLayoutAttributeTop
                                          relatedBy:NSLayoutRelationEqual
                                             toItem:viewToFill
                                          attribute:NSLayoutAttributeTop
                                         multiplier:1.0f
                                           constant:edgeInsets.top],
             [NSLayoutConstraint constraintWithItem:view
                                          attribute:NSLayoutAttributeBottom
                                          relatedBy:NSLayoutRelationEqual
                                             toItem:viewToFill
                                          attribute:NSLayoutAttributeBottom
                                         multiplier:1.0f
                                           constant:-edgeInsets.bottom]];
}


+ (NSArray *)constraintsToFillView:(UIView *)viewToFill
                          withView:(UIView *)view
{
    return [self constraintsToFillView:viewToFill
                              withView:view
                            edgeInsets:UIEdgeInsetsZero];
}


+ (NSArray *)constraintsToFillView:(UIView *)viewToFill
                          withView:(UIView *)view
                        edgeInsets:(UIEdgeInsets)edgeInsets
{
    NSArray *verticalConstraints = [self constraintsToFillVerticallyView:viewToFill
                                                                withView:view
                                                              edgeInsets:edgeInsets];
    
    NSArray *horizontalConstraints = [self constraintsToFillHorizontallyView:viewToFill
                                                                    withView:view
                                                                  edgeInsets:edgeInsets];
    
    NSMutableArray *constraints = [[NSMutableArray alloc] init];
    
    [constraints addObjectsFromArray:verticalConstraints];
    [constraints addObjectsFromArray:horizontalConstraints];
    
    return [constraints copy];
}


#pragma mark - Setting width & height


+ (NSLayoutConstraint *)constraintToSetWidth:(CGFloat)width
                                     forView:(UIView *)view
{
    return [NSLayoutConstraint constraintWithItem:view
                                        attribute:NSLayoutAttributeWidth
                                        relatedBy:NSLayoutRelationEqual
                                           toItem:nil
                                        attribute:NSLayoutAttributeNotAnAttribute
                                       multiplier:1.0f
                                         constant:width];
}


+ (NSLayoutConstraint *)constraintToSetHeight:(CGFloat)height
                                      forView:(UIView *)view
{
    return [NSLayoutConstraint constraintWithItem:view
                                        attribute:NSLayoutAttributeHeight
                                        relatedBy:NSLayoutRelationEqual
                                           toItem:nil
                                        attribute:NSLayoutAttributeNotAnAttribute
                                       multiplier:1.0f
                                         constant:height];
}


+ (NSArray *)constraintsToSetWidth:(CGFloat)width
                         andHeight:(CGFloat)height
                           forView:(UIView *)view
{
    return @[[NSLayoutConstraint constraintWithItem:view
                                          attribute:NSLayoutAttributeWidth
                                          relatedBy:NSLayoutRelationEqual
                                             toItem:nil
                                          attribute:NSLayoutAttributeNotAnAttribute
                                         multiplier:1.0f
                                           constant:width],
             [NSLayoutConstraint constraintWithItem:view
                                          attribute:NSLayoutAttributeHeight
                                          relatedBy:NSLayoutRelationEqual
                                             toItem:nil
                                          attribute:NSLayoutAttributeNotAnAttribute
                                         multiplier:1.0f
                                           constant:height]];
}


#pragma mark - Debugging


#ifdef DEBUG

/**
 Extended description method. Prints out accessibility labels of views.
 */
- (NSString *)description
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    // Get the ASCII art description. Method asciiArtDescription is private.
    // Thus, we use it only when developing, when the DEBUG flag is defined.
    NSMutableString *description = [self performSelector:@selector(asciiArtDescription)];
#pragma clang diagnostic pop
    
    // Create a string with ASCII description (if any).
    NSMutableString *extendedDescripton = description.length ?
    [NSMutableString stringWithFormat:@"%@, ", description] :
    [[NSMutableString alloc] init];
    
    // Get the views that make the constraint.
    UIView *firstView = (UIView *)[self firstItem];
    UIView *secondView = (UIView *)[self secondItem];
    
    // Create developer friendly descriptions using accessibility labels.
    if (firstView)
    {
        [extendedDescripton appendFormat:@"First view is %@ (0x%0x)", firstView.accessibilityLabel, (int)firstView];
    }
    
    if (secondView)
    {
        if (firstView)
        {
            [extendedDescripton appendString:@", "];
        }
        
        [extendedDescripton appendFormat:@"Second View is %@ (0x%0x)", secondView.accessibilityLabel, (int)secondView];
    }
    
    return extendedDescripton;
}


#endif
@end
