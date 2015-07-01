//
//  DLSystem.m
//  Forecast
//
//  Created by Dmitry Laenko on 30/06/15.
//  Copyright (c) 2015 home. All rights reserved.
//

#import "DLSystem.h"


@implementation DLSystem

+ (void)init
{
    [[DLCoreDataManager getInstance] initializeStorage];
}

@end
