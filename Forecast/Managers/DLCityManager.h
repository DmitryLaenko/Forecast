//
//  DLCityManager.h
//  Forecast
//
//  Created by Dmitry Laenko on 30/06/15.
//  Copyright (c) 2015 home. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DLCity.h"

@interface DLCityManager : NSObject

+ (instancetype)getInstance;

- (NSFetchedResultsController *)getFetchedResultsController;

- (NSArray *)allCities;
- (NSArray *)allCitiesId;

- (DLCity *)cityById:(NSString *)cityId;

- (NSArray *)parseJSON:(NSDictionary *)JSON;

- (void)deleteCityById:(NSString *)cityId;
@end
