//
//  IncomeExpensiveViewController.m
//  MonthTracker
//
//  Created by Group7 on 11/17/15.
//
//

#import "IncomeExpensiveViewController.h"
#import "IncomeViewController.h"
#import "ExpensiveViewController.h"

@interface IncomeExpensiveViewController ()
@property (weak, nonatomic) IBOutlet UITableView *incomeTableView;
@property (weak, nonatomic) IBOutlet UITableView *expensiveTableView;
@property (weak, nonatomic) IBOutlet UILabel *balanceLabel;

@end

@implementation IncomeExpensiveViewController

- (instancetype)init
{
    // Displayint title
    self.navigationItem.title = @"Month";
    //Create a new bar button item that will send addNewItem: to BNRItemsViewController
    UIBarButtonItem *bbi = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                         target:self
                                                                         action:@selector(addIncomeExpensive:)];
    //Seting right bar button
    self.navigationItem.rightBarButtonItem = bbi;
    
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

// Action button right bar button item
- (IBAction)addIncomeExpensive:(id)sender
{
    // Creating popup menu for user selection
    UIActionSheet *popup = [[UIActionSheet alloc]initWithTitle:@"Add"
                                                      delegate:self
                                             cancelButtonTitle:@"Cancel"
                                        destructiveButtonTitle:nil
                                             otherButtonTitles:@"Income", @"Expensive", nil];
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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
