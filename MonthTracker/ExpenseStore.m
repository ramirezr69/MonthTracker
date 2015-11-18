//
//  ExpenseStore.m
//  MonthTracker
//
//  Created by Group7 on 11/18/15.
//
//

#import "ExpenseStore.h"
#import "Expense.h"


@implementation ExpenseStore
+ (instancetype)sharedStore
{
    static ExpenseStore *sharedStore;
    
    // Do I need to create a sharedStore?
    if (!sharedStore) {
        sharedStore = [[self alloc] init];
    }
    
    return sharedStore;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _allExpenses = [[NSMutableArray alloc] init];
    }
    return self;
}

- (Expense *)createItem
{
    Expense *item = [Expense randomItem];
    
    [self.allExpenses addObject:item];
    
    return item;
}

- (void)removeItem:(Expense *)item
{
    [self.allExpenses removeObjectIdenticalTo:item];
}

- (void)moveItemAtIndex:(NSInteger)fromIndex
                toIndex:(NSInteger)toIndex
{
    if (fromIndex == toIndex) {
        return;
    }
    // Get pointer to object being moved so you can re-insert it
    Expense *item = self.allExpenses[fromIndex];
    
    // Remove item from array
    [self.allExpenses removeObjectAtIndex:fromIndex];
    
    // Insert item in array at new location
    [self.allExpenses insertObject:item atIndex:toIndex];
}

@end
