//
//  ExpensiveViewController.m
//  MonthTracker
//
//  Created by Group7 on 11/17/15.
//
//

#import "ExpensiveViewController.h"

@interface ExpensiveViewController ()
@property (weak, nonatomic) IBOutlet UILabel *expensiveTypeLabel;

@end

@implementation ExpensiveViewController
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
    self.navigationItem.title = @"Expensive";
    self.expensiveTypeLabel.hidden = YES;
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
