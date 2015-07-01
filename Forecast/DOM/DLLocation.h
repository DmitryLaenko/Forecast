//
//  DLLocation.h
//  Forecast
//
//  Created by Dmitry Laenko on 30/06/15.
//  Copyright (c) 2015 home. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DLLocation : NSObject<NSCoding>

@property (assign, nonatomic) double longitude;
@property (assign, nonatomic) double latitude;

@property (readonly, nonatomic) CLLocationCoordinate2D coordinate;

- (instancetype) initWithCoordinate: (CLLocationCoordinate2D) coordinate;


@end
