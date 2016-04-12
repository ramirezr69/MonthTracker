//
//  Income.h
//  MonthTracker
//
//  Created by Group7 on 11/24/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Month;

@interface Income : NSManagedObject

@property (nonatomic, retain) NSDate * dateReceived;
@property (nonatomic) float incomeValue;
@property (nonatomic, retain) NSString * sourceName;
@property (nonatomic, retain) Month *month;

@end
