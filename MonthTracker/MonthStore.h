//
//  MonthStore.h
//  MonthTracker
//
//  Created by Group7 on 11/19/15.
//
//

#import <Foundation/Foundation.h>

@class Month;
@class Income;
@class Expense;

@interface MonthStore : NSObject

@property (nonatomic) NSMutableArray *allMonths;
@property (nonatomic) NSMutableArray *allIncome;
@property (nonatomic) NSMutableArray *allExpense;

+ (instancetype) sharedStore;
- (BOOL)saveChanges;
- (Month *)createItem:(NSString *)name;
- (Expense *)createExpense;
- (Income *)createIncome;

@end
