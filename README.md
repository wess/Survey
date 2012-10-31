# Survey

> Survey is a library to simplify the process of creating and validating forms.  This library is loosely based on CoreData and Django forms.

## To-do: (Just starting development, much more to come)
* More Validators
* Generate forms from ManagedObject models
* Block based form actions.

## Setting up
> To set up, place the Survey project file into your project, link to the libSurvey.a framework and add it as a target dependency, then just #import <Survey/Survey.h> and go to town!

## Example Form Model:
> Setting up a form is pretty simple, you just subclass SurveyFormModel and set up properties for the fields you want. Then, in the implementation, set up each field with the properties you want.

> Be sure to checkout SurveyEmailField to see how easy it is to create custom fields to use.  the email field example below has been updated to use that custom field.

```objectivec

// RegisterForm.h
@interface RegisterForm : SurveyFormModel
@property (strong, nonatomic) SurveyField *firstname;
@property (strong, nonatomic) SurveyField *lastname;
@property (strong, nonatomic) SurveyField *email;
@property (strong, nonatomic) SurveyField *password;
@end

// RegisterForm.m
@implementation RegisterForm
-(SurveyField *)firstname
{
    SurveyField *field    = [SurveyField fieldWithPlaceholder:@"First Name"];
    field.isRequired      = NO;
    field.label           = @"First Name";
    field.validationBlock = ^(id form, id field, id value) {
        NSString *fieldValue = [(NSString *)value lowercaseString];
        return [fieldValue isEqualToString:@"wess"];
    };
    
    field.shouldReturn = ^BOOL(SurveyField *this, id field) {
        SurveyField  *nextField = [this getNextField];
      
        [this resignFirstResponder];
        [nextField becomeFirstResponder];
        
        return NO;
    };
    
    
    return field;
}

-(SurveyField *)lastname
{
    SurveyField *field  = [SurveyField fieldWithPlaceholder:@"Last Name"];
    field.isRequired    = YES;
    field.label         = @"Last Name";
    
    field.shouldBeginEditing = ^(id field) {
        NSLog(@"OH YEAH, WE BE EDITING");

        return YES;
    };
    
    field.didEndEditing = ^(id field) {
        NSString *value = ((UITextField *)field).text;
        
        NSLog(@"Field Value: %@", value);
    };
    
    
    return field;
}

- (SurveyField *)email
{
//    SurveyField *field  = [SurveyField fieldWithPlaceholder:@"Email"];
//    field.isRequired    = YES;
//    field.expression    = [[NSRegularExpression alloc] initWithPattern:@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}" options:0 error:nil];

//  Let's use your custom email field subclass
    SurveyField *field  = [SurveyEmailField fieldWithPlaceholder:@"Email Address"];
    field.isRequired    = YES;
    
    return field;
}

-(SurveyField *)password
{
    SurveyField *field  = [SurveyField fieldWithPlaceholder:@"Password"];
    field.isRequired    = YES;
    field.isSecure      = YES;
    
    return field;
}

// Due to weird issues with objc runtime not caring about your properties order
// If you wish to control the order of your fields and/or exclude any fields 
// add the following method to your form's class.  Don't add it, if the order
// of your fields doesn't matter, you can leave it out and it will work just fine.

+ (NSArray *)fields
{
    return @[@"firstname", @"lastname", @"email", @"password"];
}


```

## Using the form
> Using the form is also pretty simple, you just init the form and then when you want to use it, you just check that it's valid then grab the values you need.

```objectivec

RegisterForm *registerForm = [[RegisterForm alloc] init];
if(registerForm.isValid)
{
    NSString *firstname = [registerForm.form valueForField:@"firstname"];
    NSString *lastname  = [registerForm.form valueForField:@"lastname"];
    NSString *email     = [registerForm.form valueForField:@"email"];
    NSString *password  = [registerForm.form valueForField:@"password"];
    
    // Now do something with your new values.
}

```

## If you need me
* [Github](http://www.github.com/wess)
* [@WessCope](http://www.twitter.com/wesscope)

## License
Read LICENSE file for more info.