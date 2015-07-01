//
//  DLForecastDataSource.h
//  Forecast
//
//  Created by Dmitry Laenko on 01/07/15.
//  Copyright (c) 2015 home. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DLCity.h"

@interface DLForecastDataSource : NSObject

- (instancetype)initWithTableView:(UITableView *)table city:(DLCity *)city;

@end
