//
//  IncomeStore.h
//  Expenses
//
//  Created by Group8 on 11/17/15.
//  Copyright (c) 2015 Group7. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Income;
@interface IncomeStore : NSObject

@property (nonatomic) NSMutableArray *allSources;

// Notice that this is a class method and prefixed with a + instead of a -
+ (instancetype)sharedStore;
- (Income *)createItem;
- (void)removeItem:(Income *)item;
- (void)moveItemAtIndex:(NSInteger)fromIndex
                toIndex:(NSInteger)toIndex;
@end
