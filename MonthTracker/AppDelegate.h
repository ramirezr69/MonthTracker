//
//  AppDelegate.h
//  MonthTracker
//
//  Created by Group7 on 11/17/15.
//
//

#import <UIKit/UIKit.h>

extern NSString * const NextIncomeSourcePrefsKey;
extern NSString * const NextIncomeAmountPrefsKey;
extern NSString * const NextIncomeDatePrefsKey;
extern NSString * const NextExpenseTypePrefsKey;
extern NSString * const NextExpenseAmountPrefsKey;
extern NSString * const NextExpenseDatePrefsKey;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


@end

