//
//  IncomeStore.m
//  Expenses
//
//  Created by Group8 on 11/17/15.
//  Copyright (c) 2015 Group7. All rights reserved.
//

#import "IncomeStore.h"
#import "Income.h"

@implementation IncomeStore
+ (instancetype)sharedStore
{
    static IncomeStore *sharedStore;
    
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
        _allSources = [[NSMutableArray alloc] init];
    }
    return self;
}

- (Income *)createItem
{
    Income *item = [Income randomItem];
    
    [self.allSources addObject:item];
    
    return item;
}

- (void)removeItem:(Income *)item
{
    [self.allSources removeObjectIdenticalTo:item];
}

- (void)moveItemAtIndex:(NSInteger)fromIndex
                toIndex:(NSInteger)toIndex
{
    if (fromIndex == toIndex) {
        return;
    }
    // Get pointer to object being moved so you can re-insert it
    Income *item = self.allSources[fromIndex];
    
    // Remove item from array
    [self.allSources removeObjectAtIndex:fromIndex];
    
    // Insert item in array at new location
    [self.allSources insertObject:item atIndex:toIndex];
}

@end