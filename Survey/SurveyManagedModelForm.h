//
//  SurveyManagedModelForm.h
//  Survey
//
//  Created by Wess Cope on 2/22/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SurveyModelForm.h"

/**
 `SurveyManagedModelForm` is a subclass of `SurveyModelForm`, designed to allow form creation directly from a Managed Object Model subclass.
 
 ## Subclassing Notes
 
 ### Methods to Override
 When subclassing `SurveyManagedModelForm`, you _must_ override the following methods in order for the form to have access to properties.
 - +managedObjectClass
 
 */

@interface SurveyManagedModelForm : SurveyModelForm
///---------------------------------------------------
/// @name Create forms from a ManagedObject subclass.
///---------------------------------------------------

/**
 Returns the class of the ManagedObject subclass when creating the form.

 @return the class of the ManagedObject subclass when creating the form.
 */
+ (Class)managedObjectClass;
@end
