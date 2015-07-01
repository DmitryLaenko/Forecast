//
//  DLLocation.m
//  Forecast
//
//  Created by Dmitry Laenko on 30/06/15.
//  Copyright (c) 2015 home. All rights reserved.
//

#import "DLLocation.h"

static NSString* const kDLLocationLongitude = @"LocationLongitudeKey";
static NSString* const kDLLocationLatitude = @"LocationLatitudeKey";

@implementation DLLocation

- (instancetype) initWithCoordinate: (CLLocationCoordinate2D) coordinate {
    
    self = [super init];
    if (self) {
        _longitude = coordinate.longitude;
        _latitude = coordinate.latitude;
    }
    
    return self;
}

- (id) initWithCoder: (NSCoder *) decoder
{
    if (!([decoder containsValueForKey: kDLLocationLongitude] && [decoder containsValueForKey: kDLLocationLatitude])) {
        return nil;
    }
    
    self = [super init];
    if(self)
    {
        _longitude = [decoder decodeDoubleForKey: kDLLocationLongitude];
        _latitude = [decoder decodeDoubleForKey: kDLLocationLatitude];
    }
    return self;
}


- (void) encodeWithCoder: (NSCoder *) encoder
{
    [encoder encodeDouble: self.longitude forKey: kDLLocationLongitude];
    [encoder encodeDouble: self.latitude forKey: kDLLocationLatitude];
}

#pragma mark - Properties

- (CLLocationCoordinate2D) coordinate {
    return CLLocationCoordinate2DMake(self.latitude, self.longitude);
}

@end
