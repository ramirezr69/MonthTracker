//
//  MonthStore.m
//  MonthTracker
//
//  Created by Group7 on 11/19/15.
//
//

#import "MonthStore.h"
#import "Month.h"
#import "Expense.h"

@import CoreData;

@interface MonthStore()
@property (nonatomic, strong) NSManagedObjectContext *context;
@property (nonatomic, strong) NSManagedObjectModel *model;
@end

@implementation MonthStore

+ (instancetype)sharedStore
{
    static MonthStore *sharedStore;
    
    // Do I need to create a sharedStore?
    if (!sharedStore) {
        sharedStore = [[self alloc] init];
    }
    
    return sharedStore;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        // Read in Homepwner.xcdatamodeld
        _model = [NSManagedObjectModel mergedModelFromBundles:nil];
        
        
        //1) What are my entities/relations? -> model
        NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:_model];
        
        // Where does the SQLite file go?
        NSString *path = self.itemArchivePath;
        NSURL *storeURL = [NSURL fileURLWithPath:path];
        
        NSError *error;
        //Where do I save it?
        if (![psc addPersistentStoreWithType:NSSQLiteStoreType
                               configuration:nil
                                         URL:storeURL
                                     options:nil
                                       error:&error]) {
            @throw [NSException exceptionWithName:@"OpenFailure"
                                           reason:[error localizedDescription]
                                         userInfo:nil];
        }
        
        // Create the managed object context
        _context = [[NSManagedObjectContext alloc] init];
        _context.persistentStoreCoordinator = psc;
        
        [self loadAllMonths];
    }
    
    return self;
}

- (void)removeExpense:(Expense *) item
{
    [self.context deleteObject:item];
    [self.allExpense removeObjectIdenticalTo:item];
}

- (void)removeIncome:(Income *)item
{
    [self.context deleteObject:item];
    [self.allIncome removeObjectIdenticalTo:item];

}

- (Month *)createItem:(NSString *)name
{
    Month *item = [NSEntityDescription insertNewObjectForEntityForName:@"Month"
                                                inManagedObjectContext:self.context];
    double order;
    if ([self.allMonths count] == 0) {
        order = 1.0;
    } else {
        order = [[self.allMonths lastObject] orderingValue] + 1.0;
    }
    
    item.orderingValue = order;
    
    item.monthName = name;
    [self.allMonths addObject:item];
    return item;
}

- (Expense *)createExpense
{
    Expense *item = [NSEntityDescription insertNewObjectForEntityForName:@"Expense"
                                                inManagedObjectContext:self.context];
    [self.allExpense addObject:item];
    return item;
}

- (Income *)createIncome
{
    Income *item = [NSEntityDescription insertNewObjectForEntityForName:@"Income"
                                                  inManagedObjectContext:self.context];
    [self.allIncome addObject:item];
    return item;
}

- (NSString *)itemArchivePath
{
    // Make sure that the first argument is NSDocumentDirectory
    // and not NSDocumentationDirectory
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    // Get the one document directory from that list
    NSString *documentDirectory = [documentDirectories firstObject];
    
    return [documentDirectory stringByAppendingPathComponent:@"store.data"];
}

- (BOOL)saveChanges
{
    NSError *error;
    BOOL successful = [self.context save:&error];
    if (!successful) {
        NSLog(@"Error saving: %@", [error localizedDescription]);
    }
    return successful;
}

- (void)loadAllMonths
{
    if (!self.allMonths) {
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        
        NSEntityDescription *e = [NSEntityDescription entityForName:@"Month"
                                             inManagedObjectContext:self.context];
        
        request.entity = e;
        
        //Sort Array
        NSSortDescriptor *sd = [NSSortDescriptor
                                sortDescriptorWithKey:@"orderingValue"
                                ascending:YES];
        
        request.sortDescriptors = @[sd];
        
        
        NSError *error;
        NSArray *result = [self.context executeFetchRequest:request error:&error];
        if (!result) {
            [NSException raise:@"Fetch failed"
                        format:@"Reason: %@", [error localizedDescription]];
        }
        
        self.allMonths = [[NSMutableArray alloc] initWithArray:result];
    }
}
@end
