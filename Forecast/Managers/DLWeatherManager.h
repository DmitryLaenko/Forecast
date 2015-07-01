//
//  DLWeatherManager.h
//  Forecast
//
//  Created by Dmitry Laenko on 30/06/15.
//  Copyright (c) 2015 home. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DLWeatherManager : NSObject

+ (instancetype)getInstance;

// get current weather
- (void)currentWeatherByCity:(NSString *)name country:(NSString *)country withCompletion:(DLCompletionBlock)completion;
- (void)currentWeatherByIds:(NSArray *)Ids withCompletion:(DLCompletionBlock)completion;
// get forecast
- (void)forecastForCity:(NSString *)cityId  withCompletion:(DLCompletionBlock)completion;
@end
