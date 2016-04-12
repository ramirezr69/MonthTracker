//
//  ExpensiveViewController.h
//  MonthTracker
//
//  Created by Group7 on 11/17/15.
//
//

#import <UIKit/UIKit.h>
@class Expense;
@class Month;

@interface ExpensiveViewController : UIViewController < UIActionSheetDelegate>

//holds current Expense
@property (nonatomic) Expense *currentExpense;
- (instancetype)initForNewItem:(BOOL)isNew;
@property (nonatomic, copy) void (^dismissBlock)(void);
@property (nonatomic, strong) Month *currentMonth;
@end
