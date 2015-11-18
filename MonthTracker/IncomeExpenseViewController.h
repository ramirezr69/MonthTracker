//
//  IncomeExpensiveViewController.h
//  MonthTracker
//
//  Created by Group7 on 11/17/15.
//
//

#import <UIKit/UIKit.h>

@interface IncomeExpenseViewController : UIViewController < UINavigationControllerDelegate, UITextFieldDelegate, UIActionSheetDelegate>
@property (nonatomic, strong) NSString *monthSelected;
@end
