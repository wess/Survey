//
//  SurveyFieldCell.m
//  Survey
//
//  Created by Wess Cope on 10/15/12.
//  Copyright (c) 2012 Wess Cope. All rights reserved.
//

#import "SurveyFieldCell.h"
#import "SurveyField.h"

@interface SurveyFieldCell()
@property (strong, nonatomic) UILabel       *label;
@property (strong, nonatomic) UITextField   *field;
@end

@implementation SurveyFieldCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
    
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    if(!_fieldObject)
        @throw [NSException exceptionWithName:@"SurveyFieldCell Exception" reason:@"No SurveyField object provided" userInfo:nil];
    
    [super layoutSubviews];

    CGRect frame        = (UIEdgeInsetsEqualToEdgeInsets(UIEdgeInsetsZero, _edgeInset))? UIEdgeInsetsInsetRect(self.contentView.frame, _edgeInset) : self.contentView.frame;
    CGRect labelFrame   = CGRectMake(frame.origin.x, frame.origin.y, 90.0f, frame.size.height - 1);
    CGRect fieldFrame   = CGRectMake(frame.origin.x + labelFrame.size.width, frame.origin.y, frame.size.width - 120.0f, frame.size.height - 1);

    if(!_label)
    {
        _label                  = [[UILabel alloc] initWithFrame:labelFrame];
        _label.backgroundColor  = [UIColor clearColor];

        if(_font)
            _label.font = _font;
        
        [self addSubview:_label];
    }
    else
    {
        _label.frame = labelFrame;
    }
    
    _label.text = _fieldObject.label;
    
    if(_field.superview)
        [_field removeFromSuperview];
    
    _field                          = _fieldObject.field;
    _field.frame                    = fieldFrame;
    _field.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    if(_delegate)
        _field.delegate = _delegate;
    
    [self addSubview:_field];
}


@end
