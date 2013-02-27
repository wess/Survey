//
//  WCRegisterFormViewController.m
//  SurveyExample
//
//  Created by Wess Cope on 10/15/12.
//  Copyright (c) 2012 Wess Cope. All rights reserved.
//

#import "WCRegisterFormViewController.h"
#import "WCRegisterForm.h"

@interface WCRegisterFormViewController ()
@property (strong, nonatomic) WCRegisterForm *registerForm;
- (void)buttonAction:(id)sender;
@end

@implementation WCRegisterFormViewController

- (id)init
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self)
    {
//        _registerForm = [[WCRegisterForm alloc] init];
        
//        NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:[WCCoreData instance].managedObjectContext];
//        _registerForm = [[WCModelForm alloc] initWithEntityDescription:entityDescription];
        
        _registerForm = [[WCRegisterForm alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)buttonAction:(id)sender
{
    if([_registerForm isValid])
        NSLog(@"FORM IS VALID");
    else
        NSLog(@"FIELD ERRORS: %@", _registerForm.errors);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return _registerForm.fields.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }

    if([[_registerForm.fields objectAtIndex:indexPath.row] isKindOfClass:[SurveyTextView class]])
    {
        SurveyTextView *field   = [_registerForm.fields objectAtIndex:indexPath.row];
        field.frame             = CGRectInset(cell.bounds, 30.0f, 5.0f);
        field.backgroundColor   = [UIColor clearColor];

        [cell addSubview:field];

    }
    else
    {
        SurveyTextField *field  = [_registerForm.fields objectAtIndex:indexPath.row];
        field.frame             = CGRectInset(cell.bounds, 30.0f, 5.0f);
        field.backgroundColor   = [UIColor clearColor];
        
        [cell addSubview:field];        
    }
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 60.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectZero];
    footerView.backgroundColor = [UIColor clearColor];
    
    UIButton *submit            = [UIButton buttonWithType:UIButtonTypeCustom];
    submit.frame                = CGRectMake(10.0f, 10.0f, self.tableView.bounds.size.width - 20.0f, 40.0f);
    submit.clipsToBounds        = YES;
    submit.titleLabel.font      = [UIFont systemFontOfSize:22.0f];
    submit.backgroundColor      = [UIColor colorWithRed:255.0f green:255.0f blue:255.0f alpha:0.5];
    submit.layer.cornerRadius   = 5.0f;
    submit.layer.borderColor    = [UIColor darkGrayColor].CGColor;
    submit.layer.borderWidth    = 1.0f;
    
    [submit setTitle:@"Submit" forState:UIControlStateNormal];
    [submit setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [submit addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [footerView addSubview:submit];
    
    return footerView;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
