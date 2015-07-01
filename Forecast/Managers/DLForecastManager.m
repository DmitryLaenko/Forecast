//
//  DLForecastManager.m
//  Forecast
//
//  Created by Dmitry Laenko on 01/07/15.
//  Copyright (c) 2015 home. All rights reserved.
//

#import "DLForecastManager.h"
#import "DLCityManager.h"


@implementation DLForecastManager

+ (instancetype)getInstance
{
    static DLForecastManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [DLForecastManager new];
    });
    return manager;
}

- (NSFetchedResultsController *)getFetchedResultsControllerByCity:(DLCity *)city
{
    NSFetchRequest *forecastFetchRequest = [[NSFetchRequest alloc] initWithEntityName: @"Forecast"];
    forecastFetchRequest.sortDescriptors = @[[[NSSortDescriptor alloc] initWithKey: @"dataTime" ascending: YES]];
    forecastFetchRequest.predicate = [NSPredicate predicateWithFormat:@"self.city == %@", city];
    
    [NSFetchedResultsController deleteCacheWithName: @"ForecastCacheName"];
    __block NSFetchedResultsController *fetchRequest;
    [[DLCoreDataManager getInstance] performSync:^(NSManagedObjectContext *context) {
        fetchRequest = [[NSFetchedResultsController alloc] initWithFetchRequest: forecastFetchRequest managedObjectContext: context sectionNameKeyPath: nil cacheName: @"ForecastCacheName"];
        [fetchRequest performFetch:nil];
    }];
    return fetchRequest;
}

- (void)deleteAllByCity:(DLCity *)city
{
    if (city==nil) return;
    [[DLCoreDataManager getInstance] performSyncAndSave:^(NSManagedObjectContext *context) {
        [DLForecast MR_deleteAllMatchingPredicate:[NSPredicate predicateWithFormat:@"self.city == %@", city] inContext:context];
    }];
}

- (DLForecast *)updateValue:(NSDictionary *)dict withCity:(DLCity *)city
{
    __block DLForecast *forecast;
    [[DLCoreDataManager getInstance] performSyncAndSave:^(NSManagedObjectContext *context) {
        forecast = [DLForecast MR_createEntityInContext:context];
        
        forecast.dataTime = [NSDate dateWithTimeIntervalSince1970:INTEGER(dict[kKeyDateTime])];
        forecast.tempValue = FLOAT(dict[kKeyMain][kKeyTemp]);
        forecast.humidityValue = INTEGER(dict[kKeyMain][kKeyHumidity]);
        forecast.pressureValue = INTEGER(dict[kKeyMain][kKeyPressure]);
        forecast.desc = STRING(dict[kKeyWeather][0][kKeyDesc]);
        forecast.icon = [NSString stringWithFormat:@"%@%@.png", kWeatherIconUrl, STRING(dict[kKeyWeather][0][kKeyIcon])];

        if (city)
            forecast.city = city;
        
    }];
    return forecast;
}

- (NSArray *)updateValues:(NSArray *)array withCity:(DLCity *)city
{
    NSMutableArray *mar = [NSMutableArray new];
    for (NSDictionary *di in array) {
        DLForecast *forecast = [self updateValue:di withCity:city];
        if (forecast)
            [mar addObject:forecast];
    }
    return [NSArray arrayWithArray:mar];
}

- (NSArray *)parseJSON:(NSDictionary *)JSON{
    DLCity *city=nil;
    if (IS_NOT_NULL(JSON[kKeyCity]) && IS_NOT_NULL(JSON[kKeyCity][kKeyId])){
        city = [[DLCityManager getInstance] cityById:STRING(JSON[kKeyCity][kKeyId])];
    }
    [self deleteAllByCity:city];
    return [self updateValues:JSON[kKeyList] withCity:city];
}
@end
