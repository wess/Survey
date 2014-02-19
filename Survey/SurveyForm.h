//
//  SurveyForm.h
//  Survey
//
//  Created by Wess Cope on 2/22/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "SurveyFieldDelegate.h"

NSDictionary *propertiesForClass(Class klass);

/**
 `SurveyForm` is a the class responsible for creating and managing form fields. Creating a new form
 for use, you must subclass SurveyForm using the properties to to define your fields, as you would subclass
 NSManagedObject to create a CoreData object class for use with CoreData.
 
 ## Subclassing
 
 ### Methods to Override
 In a `SurveyForm` Subclass the following methods are _optional_
 - `+fields`
 
 
 
 */

@interface SurveyForm : NSObject
///--------------------------------------------------------------------------------------------------------
/// @name Container for form fields, errors and optional methods to make working with form fields easier.
///--------------------------------------------------------------------------------------------------------
{
    @protected
        NSArray             *fieldReferenceTable;
        SurveyFieldDelegate *fieldDelegate;
}

/** 
 A field reference to allow all child classes access to form fields 
 **/
@property (strong, nonatomic) NSArray *fieldReferenceTable;

/** 
 The delegate for Survey specific field subclasses to ease use of blocks
 
 @discussion Rather than making a field responsible for it's own delegate, or a category hack, a central place for delegates to be managed.
 **/
@property (strong, nonatomic) SurveyFieldDelegate *fieldDelegate;

/**
 The collection of fields created from the subclass defined field properties.
 **/
@property (readonly, nonatomic) NSArray         *fields;

/**
 The values of all the fields in the form, using key/value pairing.
 **/
@property (readonly, nonatomic) NSDictionary    *values;

/**
 Field errors collected using field name as a key, and it's value as a collection of errors from the field.
 **/
@property (readonly, nonatomic) NSDictionary    *errors;

/**
 Determines if all fields within the form return valid data.
 
 @discussion Fields are responsible for their own validation, this triggers the validation methods on each field and stores their responses in the errors ivar.
 **/
@property (readonly, nonatomic) BOOL            isValid;

/**
 Returns the field that is currently active
 
 @return field field that is currenctly the first responder
 **/
- (id)activeField;

/**
 Returns the index of passed field.
 
 @param field field to find index of.
 
 @return the index of passed field.
 **/
- (NSUInteger)indexOfField:(id)field;

/**
 Returns the field at index.
 
 @param index tab location for desired field.
 
 @return the field.
 **/
- (id)getFieldAtTabIndex:(NSUInteger)index;

/**
 Returns the field with a given name.
 
 @param name name of the field inquiring for.
 
 @return the field.
 **/
- (id)getFieldWithName:(NSString *)name;

/**
 A class method to determine the desired order of fields defined in the form subclass
 
 @discussion Do to weird behavior or the runtime methods to get properties list, order of a classes properties are not honored.
 @return Array of strings using property names to specify form field order.
 **/
+ (NSArray *)fields;

@end
