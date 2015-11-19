//
//  ExpensiveViewController.m
//  MonthTracker
//
//  Created by Group7 on 11/17/15.
//
//

#import "ExpensiveViewController.h"
#import "ExpenseStore.h"
#import "Expense.h"

@interface ExpensiveViewController ()
@property (weak, nonatomic) IBOutlet UILabel *expensiveTypeLabel;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *valueField;

@property (weak, nonatomic) IBOutlet UITextField *dateField;

@end

@implementation ExpensiveViewController

NSString *nString;
NSString *vString;
NSString *dString;


- (IBAction)expensiveType:(id)sender
{
    // Creating popup menu for user selection
    UIActionSheet *popup = [[UIActionSheet alloc]initWithTitle:@"Expensive Type"
                                                      delegate:self
                                             cancelButtonTitle:@"Cancel"
                                        destructiveButtonTitle:nil
                                             otherButtonTitles:@"Food", @"Grocery", @"Entertaiment", @"Education", @"Clothing", @"Misc.", nil];
    [popup showInView:self.view];
}

// Receives index number from pop menu and goes through switch case
- (void) actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // Calculates tip percentage and total service charge including tip
    switch (buttonIndex)
    {
        case 0:
        {
            self.expensiveTypeLabel.text = [popup buttonTitleAtIndex:buttonIndex];
            self.expensiveTypeLabel.hidden = NO;
        }
            break;
        case 1:
        {
            self.expensiveTypeLabel.text = [popup buttonTitleAtIndex:buttonIndex];
            self.expensiveTypeLabel.hidden = NO;
        }
            break;
        case 2:
        {
            self.expensiveTypeLabel.text = [popup buttonTitleAtIndex:buttonIndex];
            self.expensiveTypeLabel.hidden = NO;
        }
            break;
        case 3:
        {
            self.expensiveTypeLabel.text = [popup buttonTitleAtIndex:buttonIndex];
            self.expensiveTypeLabel.hidden = NO;
        }
            break;
        case 4:
        {
            self.expensiveTypeLabel.text = [popup buttonTitleAtIndex:buttonIndex];
            self.expensiveTypeLabel.hidden = NO;;
        }
            break;
        case 5:
        {
            self.expensiveTypeLabel.text = [popup buttonTitleAtIndex:buttonIndex];
            self.expensiveTypeLabel.hidden = NO;
        }
            break;
        default:
            break;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.expensiveTypeLabel.hidden = YES;
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    
    // You need a NSDateFormatter that will turn a date into a simple date string
    static NSDateFormatter *dateFormatter;
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateStyle = NSDateFormatterLongStyle;
        dateFormatter.timeStyle = NSDateFormatterNoStyle;
    }
    
    NSString *date = [dateFormatter stringFromDate:self.currentExpense.dateOfPurchase];
    
    //Display item value upon loading screen
    self.nameField.text = self.currentExpense.expenseName;
    self.valueField.text = [NSString stringWithFormat:@"%d$",self.currentExpense.expenseValue];
    self.dateField.text = date;
    
}
- (void)viewDidDisappear:(BOOL)animated
{
    
    NSLog(@"viewDidDisappear was called");
    [super viewWillDisappear:animated];
    
    // Clear first responder
    [self.view endEditing:YES];
    
    // "Save" changes to item
    Expense *saveExpense = self.currentExpense;
    saveExpense.expenseName =  self.nameField.text;
    saveExpense.expenseValue = [self.valueField.text intValue];
    
    
}


- (instancetype)initForNewItem:(BOOL)isNew
{
    self = [super initWithNibName:nil bundle:nil];
    
    if (self) {
        if (isNew) {
            
            UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                      target:self
                                                                                      action:@selector(save:)];
            self.navigationItem.rightBarButtonItem = doneItem;
            
            UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                        target:self
                                                                                        action:@selector(cancelItem:)];
            self.navigationItem.leftBarButtonItem = cancelItem;
        }
    }
    
    return self;
}

- (void)save:(id)sender
{
    
    //Assign values to String
    nString = self.nameField.text;
    vString = self.valueField.text;
    dString = self.dateField.text;
    
    //Create a new instance of an income
    Expense *newExpense = [[ExpenseStore sharedStore] createItem];
    
    // Create a new BNRItem and add it to the store
    newExpense.expenseName = nString;
    newExpense.expenseValue = [vString intValue];
    newExpense.dateOfPurchase = self.currentExpense.dateOfPurchase;
    
    
    NSLog(@"Expense Added");
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:self.dismissBlock];
}


- (void)cancelItem:(id)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:self.dismissBlock];
}

@end
