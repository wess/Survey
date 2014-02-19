//
//  SurveyTextFieldWithLabelCell.h
//  Survey
//
//  Created by Juan Alvarez on 1/8/14.
//  Copyright (c) 2014 Wess Cope. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SurveyTextField.h"

/*
 !!COMING SOON!!
typedef NS_ENUM(NSInteger, SurveyTextFieldWithLabelCellStyle) {
	SurveyTextFieldWithLabelCellStyleDefault,	// Left aligned label on left and left aligned field on right
	SurveyTextFieldWithLabelCellStyleValue1,	// Right aligned label on left and left aligned field on right
	SurveyTextFieldWithLabelCellStyleValue2,	// Left Aligned label on left and right aligned field on right
	SurveyTextFieldWithLabelCellStyleValue3,	// Left aligned label on left and left aligned field below
	SurveyTextFieldWithLabelCellStyleCustom		// Will respect labelInsets, fieldInsets and fieldOffsetX
};
 */

@interface SurveyTextFieldWithLabelCell : UITableViewCell

// Required Properties
@property (nonatomic, assign) SurveyTextField *field;

// Optional Properties
@property (nonatomic, assign) UIEdgeInsets fieldInsets; // Default UIEdgeInsetsMake(0, 10, 0, 10)
@property (nonatomic, assign) CGFloat fieldOffsetX; // Optional. Offset from left side of cell. If set, overrides fieldInsets.left

@property (nonatomic, strong) NSDictionary *labelAttributes;
@property (nonatomic, assign) NSTextAlignment labelTextAlignment; // Default NSTextAlignmentLeft
@property (nonatomic, assign) UIEdgeInsets labelInset; // Default UIEdgeInsetsMake(0, 10, 0, 10)

@end
