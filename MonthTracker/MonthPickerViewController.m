//
//  MonthPickerViewController.m
//  MonthTracker
//
//  Created by Group7 on 11/17/15.
//
//

#import "MonthPickerViewController.h"
#import "ItemsViewcontroller.h"

@interface MonthPickerViewController ()
@property (strong, nonatomic) IBOutlet UIPickerView *monthYearPicker;
@property (strong, nonatomic) NSMutableArray *month;
@property (strong, nonatomic) NSMutableArray *year;
@property (weak, nonatomic) IBOutlet UILabel *testLabel;

@end

@implementation MonthPickerViewController

NSString *selectedMonth;
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(component == 0)
    {
        return [_year count];
    }
    else
    {
        return [_month count];
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    if(component == 0)
    {
        return [_year objectAtIndex:row];
    }
    else
    {
        return [_month objectAtIndex:row];
    }
    
    return nil;
}

- (instancetype)init
{
    // Displayint title
    self.navigationItem.title = @"Month Picker";
    
    //Create a new bar button item that will send addNewItem: to BNRItemsViewController
    /*UIBarButtonItem *bbi = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
     target:self
     action:@selector(nextView:)];
     //Seting right bar button
     self.navigationItem.rightBarButtonItem = bbi;*/
    
    
    return self;
}

- (IBAction)nextView:(id)sender
{
    
    // Creating an instance of IncomeViewController
    ItemsViewController *ievc = [[ItemsViewController alloc] init];
    
    //Set month selected into the next view
    ievc.monthSelected = selectedMonth;
    
    // Push it onto the top of the navigation controller's stack
    [self.navigationController pushViewController:ievc
                                         animated:YES];
    
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    /*NSInteger firstComponentRow = [self.monthYearPicker selectedRowInComponent:0];
     NSInteger secondComponentRow = [self.monthYearPicker selectedRowInComponent:1];
     
     switch(firstComponentRow)
     {
     }
     
     switch(secondComponentRow)
     {
     }*/
    
    selectedMonth = [NSString stringWithFormat: @"%@, %@", [_year objectAtIndex:[_monthYearPicker selectedRowInComponent:0]],[_month objectAtIndex:[_monthYearPicker selectedRowInComponent:1]]];
    self.testLabel.text = [NSString stringWithFormat: @"%@, %@", [_year objectAtIndex:[_monthYearPicker selectedRowInComponent:0]],[_month objectAtIndex:[_monthYearPicker selectedRowInComponent:1]]];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.year = [[NSMutableArray alloc] initWithObjects: @"2001",@"2002",@"2003",@"2004",@"2005",@"2006",@"2007",@"2008",@"2009",@"2010",@"2011",@"2012",@"2013", @"2014", @"2015", nil];
    
    self.month = [[NSMutableArray alloc] initWithObjects: @"Jan",@"Feb",@"Mar",@"Apr",@"May",@"Jun",@"July",@"Aug",@"Sep",@"Oct",@"Nov",@"Dec", nil];
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
