//
//  Month.h
//  MonthTracker
//
//  Created by Group7 on 11/24/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Expense, Income;

@interface Month : NSManagedObject

@property (nonatomic) float balance;
@property (nonatomic, retain) NSString * monthName;
@property (nonatomic) double  orderingValue;
@property (nonatomic, retain) NSMutableSet *expenses;
@property (nonatomic, retain) NSMutableSet *incomes;
@end

@interface Month (CoreDataGeneratedAccessors)

- (void)addExpensesObject:(Expense *)value;
- (void)removeExpensesObject:(Expense *)value;
- (void)addExpenses:(NSSet *)values;
- (void)removeExpenses:(NSSet *)values;

- (void)addIncomesObject:(Income *)value;
- (void)removeIncomesObject:(Income *)value;
- (void)addIncomes:(NSSet *)values;
- (void)removeIncomes:(NSSet *)values;

@end
