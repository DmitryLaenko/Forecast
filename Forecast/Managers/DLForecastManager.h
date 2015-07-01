//
//  DLForecastManager.h
//  Forecast
//
//  Created by Dmitry Laenko on 01/07/15.
//  Copyright (c) 2015 home. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DLForecast.h"
#import "DLCity.h"


@interface DLForecastManager : NSObject

+ (instancetype)getInstance;

- (NSFetchedResultsController *)getFetchedResultsControllerByCity:(DLCity *)city;

- (NSArray *)parseJSON:(NSDictionary *)JSON;

@end
