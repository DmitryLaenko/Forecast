//
//  DLCoreDataManager.m
//  Forecast
//
//  Created by Dmitry Laenko on 30/06/15.
//  Copyright (c) 2015 home. All rights reserved.
//

#import "DLCoreDataManager.h"
#import <RestKit/RestKit.h>

@interface NSManagedObjectContext ()
+ (void)MR_setRootSavingContext:(NSManagedObjectContext *)context;
+ (void)MR_setDefaultContext:(NSManagedObjectContext *)moc;
@end

@implementation DLCoreDataManager

+ (instancetype)getInstance
{
    static DLCoreDataManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [DLCoreDataManager alloc];
    });
    return manager;
}

- (void)initializeStorage
{
    [self initializeStorageFromPath:nil withBlock:nil];
}

- (void)initializeStorageFromPath:(NSString *)path withBlock:(DLCompletionBlock)block;
{
    //  Configure RestKit Core Data stack
    NSError *error = nil;
    
    NSString *pathMomd = [[NSBundle mainBundle] pathForResource:@"Forecast" ofType:@"momd"];
    NSURL *modelURL = [NSURL fileURLWithPath:pathMomd];
    NSManagedObjectModel *managedObjectModel = [[[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL] mutableCopy];
    RKManagedObjectStore *managedObjectStore = [[RKManagedObjectStore alloc] initWithManagedObjectModel:managedObjectModel];
    
    [managedObjectStore createPersistentStoreCoordinator];
    
    
    NSPersistentStore *persistentStore =
    [managedObjectStore addSQLitePersistentStoreAtPath:[kDocumentsPath stringByAppendingPathComponent:@"forecast.sqlite"]
                                fromSeedDatabaseAtPath:path
                                     withConfiguration:nil
                                               options:nil
                                                 error:&error];
    if (block && error){
        block(nil, NO, error);
        return;
    }
    NSAssert(persistentStore, @"Failed to add persistent store: %@", error);
    FSLog(@"persistent store %@", persistentStore);
    
    [managedObjectStore createManagedObjectContexts];
    
    [RKManagedObjectStore setDefaultStore:managedObjectStore];
    
    // Configure MagicalRecord to use RestKit's Core Data stack
    [NSPersistentStoreCoordinator MR_setDefaultStoreCoordinator:managedObjectStore.persistentStoreCoordinator];
    [NSManagedObjectContext MR_setRootSavingContext:managedObjectStore.persistentStoreManagedObjectContext];
    [NSManagedObjectContext MR_setDefaultContext:managedObjectStore.mainQueueManagedObjectContext];
    if (block) block(nil, NO, nil);
}

- (NSManagedObjectContext *)mainThreadReadonlyContext
{
    return [NSManagedObjectContext MR_defaultContext];
}

- (void)performSync:(void (^)(NSManagedObjectContext *context))block
{
    NSManagedObjectContext *context = self.mainThreadReadonlyContext;
    
    if (block)
    {
        [context performBlockAndWait:^()
         {
             block(context);
         }];
    }
}

- (void)performAsync:(void (^)(NSManagedObjectContext *context))block
{
    if (block)
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^()
                       {
                           [self performSync:^(NSManagedObjectContext *context)
                            {
                                block(context);
                            }];
                       });
    }
}

- (void)performSyncAndSave:(void (^)(NSManagedObjectContext *context))block
{
    [self performSync:^(NSManagedObjectContext *context)
     {
         if (block)
         {
             block(context);
         }
         
         [self saveContext:context];
     }];
}

- (void)saveContext:(NSManagedObjectContext *)context
{
    if (context.hasChanges)
    {
        [context MR_saveWithOptions:MRSaveParentContexts|MRSaveSynchronously completion:nil];
    }
}

@end
