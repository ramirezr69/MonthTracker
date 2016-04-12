//
//  IncomeViewController.m
//  MonthTracker
//
//  Created by Group7 on 11/17/15.
//
//

#import "IncomeViewController.h"
#import "Income.h"
#import "Month.h"
#import "AppDelegate.h"

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
    // Reading preferences
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *incomeSource = [defaults objectForKey:NextIncomeSourcePrefsKey];
    float incomeAmount = [defaults integerForKey:NextIncomeAmountPrefsKey];
    NSString *incomeDate = [defaults objectForKey:NextIncomeDatePrefsKey];
    
    //Display item value upon loading screen
    self.incomeSourceField.text = incomeSource;
    self.incomeValueField.text = [NSString stringWithFormat:@"%.2f$", incomeAmount];
    self.incomeDateField.text = incomeDate;
    
    /*// You need a NSDateFormatter that will turn a date into a simple date string
    static NSDateFormatter *dateFormatter;
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateStyle = NSDateFormatterLongStyle;
        dateFormatter.timeStyle = NSDateFormatterNoStyle;
    }
    
    NSString *date = [dateFormatter stringFromDate:self.currentIncome.dateReceived];
    
    
    self.incomeSourceField.text = self.currentIncome.sourceName;
    self.incomeValueField.text = [NSString stringWithFormat:@"%.2f$",self.currentIncome.incomeValue];
    self.incomeDateField.text = date;*/
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // Clear first responder
    [self.view endEditing:YES];
    
    // "Save" changes to item
    Income *saveIncome = self.currentIncome;
    
    NSString *source = self.incomeSourceField.text;
    float value = [self.incomeValueField.text floatValue];
    NSString *date = self.incomeDateField.text;
    
    if (source != saveIncome.sourceName)
    {
        saveIncome.sourceName = source;
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:source forKey:NextIncomeSourcePrefsKey];
    }
    
    if (value != saveIncome.incomeValue)
    {
        saveIncome.incomeValue = value;
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setFloat:value forKey:NextIncomeAmountPrefsKey];
    }
    
    // Changing the date into the string so we can
    // compare it to the default string
    static NSDateFormatter *dateFormatter;
    if (!dateFormatter)
    {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"EE, d LLLL yyyy HH:mm:ss Z"];
    }
    NSString *asgDate = [dateFormatter stringFromDate:saveIncome.dateReceived];
    
    if (date != asgDate)
    {
        saveIncome.dateReceived = [dateFormatter dateFromString:date];
                                   
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                                   [defaults setObject:date forKey:NextIncomeDatePrefsKey];
    }
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
            /*
            UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                        target:self
                                                                                        action:@selector(cancelItem:)];
            self.navigationItem.leftBarButtonItem = cancelItem;
             */
        }
    }
    
    return self;
}

- (void)save:(id)sender
{
    NSLog(@"Income Added");
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:self.dismissBlock];
}

- (void)cancelItem:(id)sender
{
    // If the user cancelled, then remoce the BNRItem from the store
    //[[MonthStore sharedStore] removeExpense:self.currentIncome];
    [self.presentingViewController dismissViewControllerAnimated:YES completion:self.dismissBlock];
}

@end
