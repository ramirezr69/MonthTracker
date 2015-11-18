//
//  Expense.h
//  MonthTracker
//
//  Created by Group7 on 11/18/15.
//
//

#import <Foundation/Foundation.h>

@interface Expense : NSObject

@property (nonatomic, copy) NSString *expenseName;
@property (nonatomic) NSDate *dateOfPurchase;
@property (nonatomic) int expenseValue;

+ (id)randomItem;
- (id)initWithExpenseName:(NSString *)name
             expenseValue:(int)value;
@end
