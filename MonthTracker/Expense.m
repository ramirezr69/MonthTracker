//
//  Expense.m
//  MonthTracker
//
//  Created by Group7 on 11/18/15.
//
//

#import "Expense.h"

@implementation Expense

+ (id)randomItem
{
    // Create an array of three adjectives
    NSArray *randomWorkList = @[@"Emerald", @"Necklace", @"Laptop"];
    
    // Create an array of three nouns
    NSInteger workIndex = rand() % [randomWorkList count];
    // Note that NSInteger is not an object, but a type definition
    // for "unsigned long"
    NSString *randomSource = [NSString stringWithFormat:@"%@",
                              randomWorkList[workIndex]];
    int randomValue = rand() % 100;
    
    Expense *newItem =
    [[self alloc] initWithExpenseName:randomSource
                         expenseValue:randomValue];
    
    return newItem;
}

- (id)initWithExpenseName:(NSString *)name
             expenseValue:(int)value
{
    //Call the superclass's designateed initializer
    self = [super init];
    
    if(self){
        //Give the instance variables initial values
        self.expenseName = name;
        self.expenseValue = value;
        self.dateOfPurchase = [[NSDate alloc] init];
    }
    return self;
}

- (id)init {
    return [self initWithExpenseName:@"Expense"
                        expenseValue:0];
}

- (NSString *)description
{
    // You need a NSDateFormatter that will turn a date into a simple date string
    static NSDateFormatter *dateFormatter;
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateStyle = NSDateFormatterShortStyle;
        dateFormatter.timeStyle = NSDateFormatterNoStyle;
    }
    NSString *date = [dateFormatter stringFromDate:self.dateOfPurchase];
    
    NSString *descriptionString =
    [[NSString alloc] initWithFormat:@"%@ worth %d$ purchased in %@",self.expenseName,self.expenseValue, date];
    return descriptionString;
    
}
@end
