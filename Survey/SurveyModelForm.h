//
//  SurveyModelForm.h
//  Survey
//
//  Created by Wess Cope on 2/22/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "SurveyForm.h"

/**
 `SurveyModelForm` is a subclass of `SurveyForm`, designed to allow forms to be created from CoreData entities.
 
 ## Subclassing Notes
 
 ### Methods to Override
 When subclassing `SurveyModelForm`, you _must_ override the following method in order for the form to have access to CoreData entity properties correctly.
 - +managedObjectContext;
 
 */
@interface SurveyModelForm : SurveyForm

///-----------------------------------------------
/// @name Create forms from CoreData entities.
///-----------------------------------------------

/**
 Returns an instance of `SurveyModelForm` using the name of a CoreData entity.
 
 @param entityName The name of a CoreData entity you want `SurveyModelForm` to use to create the form fields.

 @return New instance of SurveyModelForm.
 */
- (id)initWithEntityName:(NSString *)entityName;

/**
 Returns an instance of `SurveyModelForm` using an entity description.
 
 @param entityDescription An entity description created from a CoreData entity.

 @return New instance of SurveyModelForm.
*/
- (id)initWithEntityDescription:(NSEntityDescription *)entityDescription;

/**
 Returns a managed object context to use to gather properties about a CoreData entity.
 
 @returns A managed object context to use to gather properties about a CoreData entity.
 */
+ (NSManagedObjectContext *)managedObjectContext;
@end
