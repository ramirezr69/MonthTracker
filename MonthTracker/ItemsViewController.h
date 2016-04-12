//
//  ItemsViewController.h
//  Expenses
//
//  Created by Group7 on 11/17/15.
//  Copyright (c) 2015 Group7. All rights reserved.
//

#import <UIKit/UIKit.h>


@class Month;
@interface ItemsViewController : UIViewController < UINavigationControllerDelegate, UITextFieldDelegate, UIActionSheetDelegate>
@property (nonatomic, strong) NSString *monthSelected;
@property (nonatomic, strong) Month *currentMonth;
@end
