//
//  NSLayoutConstraint+Survey.h
//  Survey
//
//  Created by Wess Cope on 11/11/14.
//  Copyright (c) 2014 Wess Cope. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSLayoutConstraint (Survey)
#pragma mark - Center
+ (NSArray *)constraintsToCenterView:(UIView *)viewToCenter withReferenceView:(UIView *)referenceView;
+ (NSLayoutConstraint *)constraintsToCenterVerticallyView:(UIView *)viewToCenter withReferenceView:(UIView *)referenceView;
+ (NSLayoutConstraint *)constraintToCenterHorizontallyView:(UIView *)viewToCenter withReferenceView:(UIView *)referenceView;

#pragma mark - Filling
+ (NSArray *)constraintsToFillHorizontallyView:(UIView *)viewToFill withView:(UIView *)view;
+ (NSArray *)constraintsToFillHorizontallyView:(UIView *)viewToFill withView:(UIView *)view edgeInsets:(UIEdgeInsets)edgeInsets;
+ (NSArray *)constraintsToFillVerticallyView:(UIView *)viewToFill withView:(UIView *)view;
+ (NSArray *)constraintsToFillVerticallyView:(UIView *)viewToFill withView:(UIView *)view edgeInsets:(UIEdgeInsets)edgeInsets;
+ (NSArray *)constraintsToFillView:(UIView *)viewToFill withView:(UIView *)view;
+ (NSArray *)constraintsToFillView:(UIView *)viewToFill withView:(UIView *)view edgeInsets:(UIEdgeInsets)edgeInsets;

#pragma mark - Setting width & height
- (NSLayoutConstraint *)constraintToSetWidth:(CGFloat)width forView:(UIView *)view;
+ (NSLayoutConstraint *)constraintToSetHeight:(CGFloat)height forView:(UIView *)view;
+ (NSArray *)constraintsToSetWidth:(CGFloat)width andHeight:(CGFloat)height forView:(UIView *)view;

@end
