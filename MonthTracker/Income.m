//
//  Income.m
//  MonthTracker
//
//  Created by Group7 on 11/24/15.
//
//

#import "Income.h"
#import "Month.h"


@implementation Income

@dynamic dateReceived;
@dynamic incomeValue;
@dynamic sourceName;
@dynamic month;

- (void)awakeFromInsert
{
    [super awakeFromInsert];
    
    self.dateReceived = [NSDate date];
    
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
    NSString *date = [dateFormatter stringFromDate:self.dateReceived];
    
    NSString *descriptionString =
    [[NSString alloc] initWithFormat:@"%.2f$ from %@ in %@",self.incomeValue,self.sourceName, date];
    return descriptionString;
}
@end
