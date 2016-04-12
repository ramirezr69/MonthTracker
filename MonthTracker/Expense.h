//
//  Expense.h
//  MonthTracker
//
//  Created by Group7 on 11/24/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Month;

@interface Expense : NSManagedObject

@property (nonatomic, retain) NSDate * dateOfPurchase;
@property (nonatomic, retain) NSString * expenseName;
@property (nonatomic) float expenseValue;
@property (nonatomic, retain) Month *month;

@end
