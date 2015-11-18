//
//  Income.m
//  Expenses
//
//  Created by Group8 on 11/17/15.
//  Copyright (c) 2015 Group7. All rights reserved.
//

#import "Income.h"

@implementation Income

+ (id)randomItem
{
    // Create an array of three adjectives
    NSArray *randomWorkList = @[@"Mcdonalds", @"UHD", @"Shlumburger"];
    
    // Create an array of three nouns
    NSInteger workIndex = rand() % [randomWorkList count];
    // Note that NSInteger is not an object, but a type definition
    // for "unsigned long"
    NSString *randomSource = [NSString stringWithFormat:@"%@",
                            randomWorkList[workIndex]];
    int randomValue = rand() % 100;

    Income *newItem =
    [[self alloc] initWithSourceName:randomSource
                         incomeValue:randomValue];
    return newItem;
}

- (id)initWithSourceName:(NSString *)sourceName
             incomeValue:(int)value
{
    //Call the superclass's designateed initializer
    self = [super init];
    
    if(self){
        //Give the instance variables initial values
        self.sourceName = sourceName;
        self.incomeValue = value;
        self.dateReceived = [[NSDate alloc] init];
    }
    return self;
}

- (id)init {
    return [self initWithSourceName:@"Source"
                        incomeValue:0];
}
            
- (NSString *)description
{
    // You need a NSDateFormatter that will turn a date into a simple date string
    static NSDateFormatter *dateFormatter;
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateStyle = NSDateFormatterShortStyle;
        dateFormatter.timeStyle = NSDateFormatterNoStyle;
    }
    NSString *date = [dateFormatter stringFromDate:self.dateReceived];
    
    NSString *descriptionString =
    [[NSString alloc] initWithFormat:@"%d$ from %@ in %@",self.incomeValue,self.sourceName, date];
    return descriptionString;

}

@end
