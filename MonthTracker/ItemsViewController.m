//
//  ItemsViewController.m
//  Expenses
//
//  Created by Group7 on 11/17/15.
//  Copyright (c) 2015 Group7. All rights reserved.
//

#import "ItemsViewController.h"
#import "IncomeStore.h"
#import "ExpenseStore.h"
#import "IncomeViewController.h"
#import "ExpensiveViewController.h"
#import "Income.h"
#import "Expense.h"

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
    
    NSArray *income = [[IncomeStore sharedStore] allSources];
    NSArray *expenses = [[ExpenseStore sharedStore] allExpenses];
    
    
    if (tableView == self.incomeTableView){
        return [income count];
    }
    else {
        return [expenses count];
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *income = [[IncomeStore sharedStore] allSources];
    NSArray *expenses = [[ExpenseStore sharedStore] allExpenses];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];

    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }

    if (tableView == self.incomeTableView) {
        
        cell.textLabel.text = [income[indexPath.row] description];
        return cell;
        
    } else{
        cell.textLabel.text = [expenses[indexPath.row] description];
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

// When user clicks on a Course
- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *income = [[IncomeStore sharedStore] allSources];
    NSArray *expenses = [[ExpenseStore sharedStore] allExpenses];
    
    //Handles which table view
    if (tableView == self.incomeTableView) {
        
        // Creating an instance of IncomeViewController
        IncomeViewController *ivc = [[IncomeViewController alloc] init];
        
        //Assign selected row
        Income *selectedIncome = income[indexPath.row];
        
        //Log selected income
        NSLog(@"Income Table View :%@",selectedIncome);
        
        //Set the current income to the one selected
        ivc.currentIncome = selectedIncome;
        
        // Push it onto the top of the navigation controller's stack
        [self.navigationController pushViewController:ivc
                                             animated:YES];
    } else{
        // Creating an instance of ExpenseViewController
        ExpensiveViewController *evc = [[ExpensiveViewController alloc] init];
        
        //Assign selected row
        Expense *selectedExpense = expenses[indexPath.row];
        
        //Log selected expense
        NSLog(@"Expense Table View :%@",selectedExpense);
        
        
        //Set the current expense to the one selected
        evc.currentExpense = selectedExpense;
        
        // Push it onto the top of the navigation controller's stack
        [self.navigationController pushViewController:evc
                                             animated:YES];
     
    }
}
- (NSString *)tableView:(UITableView *)tableView
titleForFooterInSection:(NSInteger)section{
    if(tableView == self.incomeTableView){
        return @"";
    }else{
        return @"Remaining Balance";
    }
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [self.incomeTableView reloadData];
    [super viewWillAppear:animated];
    // Displayint title
    self.navigationItem.title = self.monthSelected;
}

// Create a new item
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
            IncomeViewController *ivc = [[IncomeViewController alloc] initForNewItem:YES];
            
            ivc.dismissBlock = ^{
                [self.incomeTableView reloadData];
            };
            
            UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:ivc];
            
            Income *newIncome = [[Income alloc]init];
            
            ivc.currentIncome = newIncome;
            
            navController.modalPresentationStyle = UIModalPresentationFormSheet;
            
            [self presentViewController:navController animated:YES completion:NULL];
        }
            break;
            // Go to expensive view
        case 1:
        {
            // Creating an instance of IncomeViewController
            ExpensiveViewController *evc = [[ExpensiveViewController alloc] initForNewItem:YES];
            
            evc.dismissBlock = ^{
                [self.expenseTableView reloadData];
            };
            
            UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:evc];
            
            Expense *newExpense = [[Expense alloc]init];
            
            evc.currentExpense = newExpense;
            
            navController.modalPresentationStyle = UIModalPresentationFormSheet;
            
            [self presentViewController:navController animated:YES completion:NULL];
        }
            break;
        default:
            break;
    }
}


@end
