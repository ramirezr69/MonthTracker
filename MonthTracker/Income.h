//
//  Income.h
//  Expenses
//
//  Created by Group8 on 11/17/15.
//  Copyright (c) 2015 Group7. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Income : NSObject

+ (instancetype)randomItem;

@property (nonatomic, copy) NSString *sourceName;
@property (nonatomic) int incomeValue;
@property (nonatomic, strong) NSDate *dateReceived;


- (id)initWithSourceName:(NSString *)sourceName
             incomeValue:(int)value;
@end
