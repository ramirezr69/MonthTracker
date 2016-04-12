//
//  ItemsViewController.m
//  Expenses
//
//  Created by Group7 on 11/17/15.
//  Copyright (c) 2015 Group7. All rights reserved.
//

#import "ItemsViewController.h"
#import "IncomeViewController.h"
#import "ExpensiveViewController.h"
#import "Income.h"
#import "Expense.h"
#import "Month.h"
#import "MonthStore.h"


@interface ItemsViewController () 
@property (weak, nonatomic) IBOutlet UITableView *incomeTableView;
@property (weak, nonatomic) IBOutlet UITableView *expenseTableView;
@property (weak, nonatomic) IBOutlet UILabel *balanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *savingsLabel;
@property (strong, nonatomic) NSMutableArray *allMonths;
@property (strong, nonatomic) NSMutableArray *myMonths;
@end

@implementation ItemsViewController

int monthIndex;


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
        
        [[MonthStore sharedStore] createItem:@"January"];
        [[MonthStore sharedStore] createItem:@"Febuary"];
        [[MonthStore sharedStore] createItem:@"March"];
        [[MonthStore sharedStore] createItem:@"April"];
        [[MonthStore sharedStore] createItem:@"May"];
        [[MonthStore sharedStore] createItem:@"June"];
        [[MonthStore sharedStore] createItem:@"July"];
        [[MonthStore sharedStore] createItem:@"August"];
        [[MonthStore sharedStore] createItem:@"September"];
        [[MonthStore sharedStore] createItem:@"October"];
        [[MonthStore sharedStore] createItem:@"November"];
        [[MonthStore sharedStore] createItem:@"December"];
        

    }
        return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //Initialize current month to January
    NSArray *months = [[MonthStore sharedStore] allMonths];
    //NSArray *months = [[MonthStore sharedStore] allMonths];
    
    self.currentMonth = months[0];
    self.navigationItem.title = self.currentMonth.monthName;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
// returns the number of rows in each section
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSArray *allIncome = [self.currentMonth.incomes allObjects];
    NSArray *expenses = [self.currentMonth.expenses allObjects];
    
    if (tableView == self.incomeTableView){
        return [allIncome count];
    }
    else {
        return [expenses count];
        
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *allIncome = [self.currentMonth.incomes allObjects];
    NSArray *expenses = [self.currentMonth.expenses allObjects];
    
    [self calculateTotal];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];

    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }

    if (tableView == self.incomeTableView) {
        
        cell.textLabel.text = [allIncome[indexPath.row] description];
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
    NSArray *allIncome = [self.currentMonth.incomes allObjects];
    NSArray *expenses = [self.currentMonth.expenses allObjects];
    
    //Handles which table view
    if (tableView == self.incomeTableView) {
        
        // Creating an instance of IncomeViewController
        IncomeViewController *ivc = [[IncomeViewController alloc] init];
        
        //Assign selected row
        Income *selectedIncome = allIncome[indexPath.row];
        
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

- (void)viewWillAppear:(BOOL)animated
{
    [self.incomeTableView reloadData];
    [super viewWillAppear:animated];
    // Display title

    //Show tool bar
    self.navigationController.toolbarHidden=NO;
    UIBarButtonItem *flexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    //Add a back button
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithTitle:@"Last Month"
                                                              style:UIBarButtonItemStylePlain
                                                             target:self
                                                             action:@selector(backButton:)];
    
    //Add a back button
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithTitle:@"Next Month"
                                                              style:UIBarButtonItemStylePlain
                                                             target:self
                                                             action:@selector(nextButton:)];
    
    //Add back button to toolbar
    NSArray *items = [NSArray arrayWithObjects:item1,flexible,item2, nil];
    self.toolbarItems = items;
    
}

- (IBAction) backButton:(id) sender{
    if(monthIndex == 0){
        monthIndex = 11;
    }else{
        monthIndex -= 1;
    }
    
    self.navigationItem.title = self.allMonths[monthIndex];

    NSArray *months = [[MonthStore sharedStore] allMonths];
    int lastMonthIndex;
    if(monthIndex == 0){
        lastMonthIndex = 11;
    }else{
        lastMonthIndex = monthIndex -1;
        
    }

    
    Month *lastMonth = months[lastMonthIndex];

    self.savingsLabel.text = [NSString stringWithFormat:@"Savings(Previous Month): $%.0f", lastMonth.balance];
    
    self.currentMonth = months[monthIndex];
    
    self.navigationItem.title = self.currentMonth.monthName;
    
    [self calculateTotal];
    [self.incomeTableView reloadData];
    [self.expenseTableView reloadData];
}

- (IBAction) nextButton:(id) sender{
    
    if(monthIndex == 11){
        monthIndex = 0;
    }else{
        monthIndex += 1;
    }
    
    self.navigationItem.title = self.allMonths[monthIndex];
    int lastMonthIndex;
    if(monthIndex == 0){
        lastMonthIndex = 11;
    }else{
        lastMonthIndex = monthIndex -1;
        
    }
    NSArray *months = [[MonthStore sharedStore] allMonths];
 
    Month *lastMonth = months[lastMonthIndex];
    self.savingsLabel.text = [NSString stringWithFormat:@"Savings(Previous Month): $%.0f", lastMonth.balance];
    
    self.currentMonth = months[monthIndex];
    self.navigationItem.title = self.currentMonth.monthName;
    
    [self calculateTotal];
    
    [self.incomeTableView reloadData];
    [self.expenseTableView reloadData];
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
            
            Income *newIncome = [[MonthStore sharedStore] createIncome];
            
            [self.currentMonth addIncomesObject:newIncome];
            
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
            
            Expense *newExpense = [[MonthStore sharedStore] createExpense];
            
            NSLog(@"%@",newExpense);
            
            [self.currentMonth addExpensesObject:newExpense];
            
            evc.currentExpense = newExpense;
            evc.currentMonth = self.currentMonth;

            navController.modalPresentationStyle = UIModalPresentationFormSheet;
            
            [self presentViewController:navController animated:YES completion:NULL];
        }
            break;
        default:
            break;
    }
}

- (void)calculateTotal{
    NSArray *allIncome = [self.currentMonth.incomes allObjects];
    NSArray *expenses = [self.currentMonth.expenses allObjects];
    float totalIncome = 0.0;
    float totalExpense = 0.0;
    Income *income = [[MonthStore sharedStore] createIncome];
    Expense *expense = [[MonthStore sharedStore] createExpense];
    for (income in allIncome)
            totalIncome += income.incomeValue;
    for (expense in expenses)
        totalExpense += expense.expenseValue;
    self.currentMonth.balance = totalIncome - totalExpense;
    
    self.balanceLabel.text = [NSString stringWithFormat:@"Remaining Balance: $%.0f", self.currentMonth.balance];
}


@end
