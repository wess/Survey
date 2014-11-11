//
//  SurveyDatePicker.h
//  Survey
//
//  Created by Wess Cope on 11/11/14.
//  Copyright (c) 2014 Wess Cope. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SurveyDatePicker : UIView
@property (assign, nonatomic) id<UIPickerViewDataSource>  dataSource;
@property (assign, nonatomic) id<UIPickerViewDelegate>    delegate;
@end
