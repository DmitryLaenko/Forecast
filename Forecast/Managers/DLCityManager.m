//
//  DLCityManager.m
//  Forecast
//
//  Created by Dmitry Laenko on 30/06/15.
//  Copyright (c) 2015 home. All rights reserved.
//

#import "DLCityManager.h"

@implementation DLCityManager

+ (instancetype)getInstance
{
    static DLCityManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [DLCityManager new];
    });
    return manager;
}

- (NSFetchedResultsController *)getFetchedResultsController
{
    NSFetchRequest *cityFetchRequest = [[NSFetchRequest alloc] initWithEntityName: @"City"];
    cityFetchRequest.sortDescriptors = @[[[NSSortDescriptor alloc] initWithKey: @"name" ascending: NO]];
    
    [NSFetchedResultsController deleteCacheWithName: @"CityCacheName"];
    __block NSFetchedResultsController *fetchRequest;
    [[DLCoreDataManager getInstance] performSync:^(NSManagedObjectContext *context) {
        fetchRequest = [[NSFetchedResultsController alloc] initWithFetchRequest: cityFetchRequest managedObjectContext: context sectionNameKeyPath: nil cacheName: @"CityCacheName"];
        [fetchRequest performFetch:nil];
    }];
    return fetchRequest;
}

- (NSArray *)allCities
{
    __block NSArray *arCities;
    [[DLCoreDataManager getInstance] performSync:^(NSManagedObjectContext *context) {
        arCities = [DLCity MR_findAllInContext:context];
    }];
    return arCities;
}

- (NSArray *)allCitiesId
{
    NSMutableArray *arCitiesId = [NSMutableArray new];
    [[self allCities] enumerateObjectsUsingBlock:^(DLCity *city, NSUInteger idx, BOOL *stop) {
        [arCitiesId addObject:city.cid];
    }];
    return [NSArray arrayWithArray:arCitiesId];
};

- (DLCity *)updateValue:(NSDictionary *)dict
{
    if (IS_NULL(dict[kKeyId])) return nil;
    
    NSString *cid = STRING(dict[kKeyId]);
    __block DLCity *city;
    [[DLCoreDataManager getInstance] performSyncAndSave:^(NSManagedObjectContext *context) {
        city = [DLCity MR_findFirstByAttribute:@"cid" withValue:cid inContext:context];
        if (city==nil){
            city = [DLCity MR_createEntityInContext:context];
            city.cid = cid;
            city.name = STRING(dict[kKeyName]);
        }
        city.tempValue = FLOAT(dict[kKeyMain][kKeyTemp]);
        city.humidityValue = INTEGER(dict[kKeyMain][kKeyHumidity]);
        city.pressureValue = INTEGER(dict[kKeyMain][kKeyPressure]);
        
        city.country = STRING(dict[kKeySys][kKeyCountry]);
        
        city.icon = [NSString stringWithFormat:@"%@%@.png", kWeatherIconUrl, STRING(dict[kKeyWeather][0][kKeyIcon])];
        city.desc = STRING(dict[kKeyWeather][0][kKeyDesc]);
        
    }];
    return city;
}

- (DLCity *)cityById:(NSString *)cityId
{
    __block DLCity *city;
    [[DLCoreDataManager getInstance] performSyncAndSave:^(NSManagedObjectContext *context) {
        city = [DLCity MR_findFirstByAttribute:@"cid" withValue:cityId inContext:context];
    }];
    return city;
}

- (NSArray *)updateValues:(NSArray *)array
{
    NSMutableArray *mar = [NSMutableArray new];
    for (NSDictionary *di in array) {
        DLCity *city = [self updateValue:di];
        if (city)
            [mar addObject:city];
    }
    return [NSArray arrayWithArray:mar];
}

- (NSArray *)parseJSON:(NSDictionary *)JSON{
    BOOL multiple = JSON[kKeyList];
    if (multiple) {
        return [self updateValues:JSON[kKeyList]];
    }else {
        NSArray *objects = nil;
        if (IS_NOT_NULL(JSON))
        {
            id object = [self updateValue:JSON];
            if (object) objects = @[object];
            else objects = @[];
        }
        return objects;
    }
}

- (void)deleteCityById:(NSString *)cityId
{
    [[DLCoreDataManager getInstance] performSyncAndSave:^(NSManagedObjectContext *context) {
        [DLCity MR_deleteAllMatchingPredicate:[NSPredicate predicateWithFormat:@"self.cid == %@", cityId] inContext:context];
    }];
}
@end
