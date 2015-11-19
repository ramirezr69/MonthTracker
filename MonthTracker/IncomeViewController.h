//
//  IncomeViewController.h
//  MonthTracker
//
//  Created by Group7 on 11/17/15.
//
//

#import <UIKit/UIKit.h>
@class Income;

@interface IncomeViewController : UIViewController <UINavigationControllerDelegate, UITextFieldDelegate>

//Holds the currentIncome to edit values
@property (nonatomic, strong) Income *currentIncome;
- (instancetype)initForNewItem:(BOOL)isNew;
@property (nonatomic, copy) void (^dismissBlock)(void);
@end
