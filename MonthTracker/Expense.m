//
//  Expense.m
//  MonthTracker
//
//  Created by Group7 on 11/24/15.
//
//

#import "Expense.h"
#import "Month.h"


@implementation Expense

@dynamic dateOfPurchase;
@dynamic expenseName;
@dynamic expenseValue;
@dynamic month;

- (void)awakeFromInsert
{
    [super awakeFromInsert];
    self.dateOfPurchase = [NSDate date];
    
}

- (NSString *)description
{
    if(!self.expenseName)
    {
        self.expenseName = @"Expense";
    }
    // You need a NSDateFormatter that will turn a date into a simple date string
    static NSDateFormatter *dateFormatter;
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateStyle = NSDateFormatterShortStyle;
        dateFormatter.timeStyle = NSDateFormatterNoStyle;
    }
    NSString *date = [dateFormatter stringFromDate:self.dateOfPurchase];
    
    NSString *descriptionString =
    [[NSString alloc] initWithFormat:@"%@ worth %.2f$ purchased in %@",self.expenseName,self.expenseValue, date];
    return descriptionString;
}
@end
