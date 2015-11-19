//
//  IncomeViewController.m
//  MonthTracker
//
//  Created by Group7 on 11/17/15.
//
//

#import "IncomeViewController.h"
#import "Income.h"
#import "IncomeStore.h"

@interface IncomeViewController ()
@property (weak, nonatomic) IBOutlet UITextField *incomeSourceField;
@property (weak, nonatomic) IBOutlet UITextField *incomeValueField;
@property (weak, nonatomic) IBOutlet UITextField *incomeDateField;

@end

@implementation IncomeViewController

NSString *sourceString;
NSString *valueString;
NSString *dateString;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Income";
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// To dismiss the keyboard
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
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
    
    NSString *date = [dateFormatter stringFromDate:self.currentIncome.dateReceived];
    
    //Display item value upon loading screen
    self.incomeSourceField.text = self.currentIncome.sourceName;
    self.incomeValueField.text = [NSString stringWithFormat:@"%d$",self.currentIncome.incomeValue];
    self.incomeDateField.text = date;
    
}
- (void)viewDidDisappear:(BOOL)animated
{
    
    NSLog(@"viewDidDisappear was called");
    [super viewWillDisappear:animated];
    
    // Clear first responder
    [self.view endEditing:YES];
    
    // "Save" changes to item
    Income *saveIncome = self.currentIncome;
    saveIncome.sourceName =  self.incomeSourceField.text;
    saveIncome.incomeValue = [self.incomeValueField.text intValue];
    
    
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
    sourceString = self.incomeSourceField.text;
    valueString = self.incomeValueField.text;
    dateString = self.incomeDateField.text;
    
    //Create a new instance of an income
    Income *newIncome = [[IncomeStore sharedStore] createItem];
    
    // Create a new BNRItem and add it to the store
    newIncome.sourceName = sourceString;
    newIncome.incomeValue = [valueString intValue];
    newIncome.dateReceived = self.currentIncome.dateReceived;
    
    
    NSLog(@"Income Added");
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:self.dismissBlock];
}


- (void)cancelItem:(id)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:self.dismissBlock];
}

@end
