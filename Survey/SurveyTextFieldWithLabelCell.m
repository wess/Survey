//
//  SurveyTextFieldWithLabelCell.m
//  Survey
//
//  Created by Juan Alvarez on 1/8/14.
//  Copyright (c) 2014 Wess Cope. All rights reserved.
//

#import "SurveyTextFieldWithLabelCell.h"

@interface SurveyTextFieldWithLabelCell ()

@property (nonatomic, strong) UILabel *label;

@end

@implementation SurveyTextFieldWithLabelCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
		// Set Defaults
		self.selectionStyle = UITableViewCellSelectionStyleNone;
		
		self.labelInset = UIEdgeInsetsMake(0, 5, 0, 5);
		self.labelTextAlignment = NSTextAlignmentLeft;
		
		self.fieldInsets = UIEdgeInsetsMake(0, 5, 0, 5);
		self.fieldOffsetX = 0.0;
    }
    return self;
}

- (void)prepareForReuse
{
	[super prepareForReuse];
	
	[self.field removeFromSuperview];
	
	self.label.text = nil;
	self.field = nil;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
	[super setSelected:selected animated:animated];
	
    if (selected)
		[self.field becomeFirstResponder];
	else
		[self.field resignFirstResponder];
}

- (void)layoutSubviews
{
	[super layoutSubviews];
	
	self.field.frame = [self fieldFrame];
	self.label.frame = [self labelFrame];
}

#pragma mark -
#pragma mark Frame Methods

- (CGRect)labelFrame
{
	[self.label sizeToFit];
	
	CGRect frame = self.label.bounds;
	frame.origin.x = roundf(CGRectGetMinX(self.contentView.bounds) + self.labelInset.left);
	frame.origin.y = roundf(CGRectGetMidY(self.contentView.bounds) - CGRectGetMidY(self.label.bounds) + self.labelInset.top);
	
	return frame;
}

- (CGRect)fieldFrame
{
	CGRect labelFrame = [self labelFrame];
	
	CGFloat x = 0.0;
	
	if (self.fieldOffsetX != 0.0) {
		x = self.fieldOffsetX;
	} else {
		x = roundf(CGRectGetMaxX(labelFrame) + self.fieldInsets.left);
	}
	
	CGRect frame = self.field.bounds;
	frame.size.width = roundf(CGRectGetWidth(self.contentView.bounds) - x - self.fieldInsets.right);
	frame.size.height = CGRectGetHeight(labelFrame);
	frame.origin.x = x;
	frame.origin.y = roundf(CGRectGetMidY(self.contentView.bounds) - (CGRectGetHeight(frame)/2) + self.fieldInsets.top);
	
	return frame;
}

#pragma mark -
#pragma mark Accessor Methods

- (UILabel *)label
{
	if (_label == nil) {
		_label = [[UILabel alloc] init];
		
		[self.contentView addSubview:_label];
	}
	
	return _label;
}

- (void)setField:(SurveyTextField *)field
{
	_field = field;
	
	[_field resignFirstResponder];
	
	[self.contentView addSubview:self.field];
	
	[self _updateLabel];
}

- (void)setLabelAttributes:(NSDictionary *)labelAttributes
{
	_labelAttributes = labelAttributes;

	[self _updateLabel];
}

#pragma mark -
#pragma mark Private Methods

- (void)_updateLabel
{
	NSString *labelString = [self.field.title capitalizedString];
	
	if (labelString) {
		NSAttributedString *string = [[NSAttributedString alloc] initWithString:labelString attributes:self.labelAttributes];
		
		self.label.attributedText = string;
		
		[self setNeedsLayout];
	}
}

@end
