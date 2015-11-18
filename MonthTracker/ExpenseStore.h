//
//  ExpenseStore.h
//  MonthTracker
//
//  Created by Group7 on 11/18/15.
//
//

#import <Foundation/Foundation.h>

@class Expense;

@interface ExpenseStore : NSObject

@property (nonatomic) NSMutableArray *allExpenses;

// Notice that this is a class method and prefixed with a + instead of a -
+ (instancetype)sharedStore;
- (Expense *)createItem;
- (void)removeItem:(Expense *)item;
- (void)moveItemAtIndex:(NSInteger)fromIndex
                toIndex:(NSInteger)toIndex;
@end
