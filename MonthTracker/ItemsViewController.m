//
//  ItemsViewController.m
//  Expenses
//
//  Created by Group8 on 11/17/15.
//  Copyright (c) 2015 Group7. All rights reserved.
//

#import "ItemsViewController.h"
#import "IncomeStore.h"
#import "IncomeViewController.h"
#import "ExpensiveViewController.h"

@interface ItemsViewController () 
@property (weak, nonatomic) IBOutlet UITableView *incomeTableView;

@property (weak, nonatomic) IBOutlet UITableView *expenseTableView;

@end

@implementation ItemsViewController

- (instancetype)init
{
    // Call the superclass's designated initializer
    self = [super init];
    if (self) {
        for (int i = 0; i < 10; i++) {
            [[IncomeStore sharedStore] createItem];
        }
        for (Income *item in [[IncomeStore sharedStore]allSources]) {
            NSLog(@"%@",item);
        }
        //Create a new bar button item that will send addNewItem: to BNRItemsViewController
        UIBarButtonItem *bbi = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                             target:self
                                                                             action:@selector(addIncomeExpensive:)];
        //Seting right bar button
        self.navigationItem.rightBarButtonItem = bbi;
    }
        return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
// returns the number of rows in each section
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSArray *items = [[IncomeStore sharedStore] allSources];
    
    
    if (tableView == self.incomeTableView){
        return [items count];
    }
    else {
        return [items count];
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *items = [[IncomeStore sharedStore] allSources];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];

    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }

    
    if (tableView == self.incomeTableView) {
        
        cell.textLabel.text = [items[indexPath.row] description];
        return cell;
        
    } else{
        cell.textLabel.text = [items[indexPath.row] description];
    }
    return cell;
   
}
// sets the title for the section headers
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(tableView == self.incomeTableView){
        return @"Income";
    }else{
        return @"Expense";
    }
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // Displayint title
    self.navigationItem.title = self.monthSelected;
}

// Action button right bar button item
- (IBAction)addIncomeExpensive:(id)sender
{
    // Creating popup menu for user selection
    UIActionSheet *popup = [[UIActionSheet alloc]initWithTitle:@"Add"
                                                      delegate:self
                                             cancelButtonTitle:@"Cancel"
                                        destructiveButtonTitle:nil
                                             otherButtonTitles:@"Income", @"Expenses", nil];
    [popup showInView:self.view];
}

// Receives index number from pop menu and goes through switch case
- (void) actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // Calculates tip percentage and total service charge including tip
    switch (buttonIndex)
    {
            // Go to income view
        case 0:
        {
            // Creating an instance of IncomeViewController
            IncomeViewController *ivc = [[IncomeViewController alloc] init];
            // Push it onto the top of the navigation controller's stack
            [self.navigationController pushViewController:ivc
                                                 animated:YES];
        }
            break;
            // Go to expensive view
        case 1:
        {
            // Creating an instance of IncomeViewController
            ExpensiveViewController *evc = [[ExpensiveViewController alloc] init];
            // Push it onto the top of the navigation controller's stack
            [self.navigationController pushViewController:evc
                                                 animated:YES];
        }
            break;
        default:
            break;
    }
}


@end
