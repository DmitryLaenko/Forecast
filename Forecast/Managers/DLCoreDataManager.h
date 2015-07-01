//
//  DLCoreDataManager.h
//  Forecast
//
//  Created by Dmitry Laenko on 30/06/15.
//  Copyright (c) 2015 home. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MagicalRecord/MagicalRecord.h>


@interface DLCoreDataManager : NSObject

+ (instancetype)getInstance;

- (void)initializeStorage;
- (void)initializeStorageFromPath:(NSString *)path withBlock:(DLCompletionBlock)completion;

- (void)performSync:(void (^)(NSManagedObjectContext *context))block;
- (void)performSyncAndSave:(void (^)(NSManagedObjectContext *context))block;

@end
