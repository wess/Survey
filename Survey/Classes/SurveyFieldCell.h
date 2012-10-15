//
//  SurveyFieldCell.h
//  Survey
//
//  Created by Wess Cope on 10/15/12.
//  Copyright (c) 2012 Wess Cope. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SurveyField;
@protocol SurveyFieldDelegate;
@interface SurveyFieldCell : UITableViewCell
@property (strong, nonatomic) id<UITextFieldDelegate> delegate;
@property (strong, nonatomic) SurveyField *fieldObject;
@property (strong, nonatomic) UIFont *font;
@property (assign, nonatomic) UIEdgeInsets edgeInset;
@end
