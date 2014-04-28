//
//  SEUserFormTableViewController.m
//  SurveyExample
//
//  Created by Wess Cope on 4/24/14.
//  Copyright (c) 2014 Wess Cope. All rights reserved.
//

#import "SEUserFormTableViewController.h"
#import "SEUserForm.h"

@interface SEUserFormTableViewController ()
@property (strong, nonatomic) SEUserForm *form;

- (void)saveForm:(id)sender;
@end

@implementation SEUserFormTableViewController
static NSString *const CellIdentifier = @"CellIdentifier";

- (id)init
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        self.form = [[SEUserForm alloc] initWithDefaultValues:@{@"username": @"Wesley"}];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    
    self.title                  = @"User Form";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(saveForm:)];
    
}

- (void)saveForm:(id)sender
{
    if(self.form.isValid)
    {
        NSLog(@"USERNAME: %@", self.form.username.text);
        NSLog(@"PASSWORD: %@", self.form.password.text);
    }
    else
    {
        NSLog(@"ERRORS: %@", self.form.errors);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.form.fields.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SurveyTextField *field  = self.form.fields[indexPath.row];
    UITableViewCell *cell   = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    field.frame = cell.bounds;
    [cell.contentView addSubview:field];
    
    return cell;
}

@end
