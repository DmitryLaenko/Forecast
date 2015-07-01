//
//  AppDelegate.m
//  Forecast
//
//  Created by Dmitry Laenko on 30/06/15.
//  Copyright (c) 2015 home. All rights reserved.
//

#import "AppDelegate.h"
#import "DLWeatherManager.h"
#import "DLSystem.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

    [DLSystem init];
    if ([self isFirstTimeOpening]){
        [[DLWeatherManager getInstance] currentWeatherByIds:@[@(498817), @(524901)] withCompletion:nil];
    }
    
    return YES;
}

- (BOOL)isFirstTimeOpening
{
    NSUserDefaults *theDefaults = [NSUserDefaults standardUserDefaults];
    if([theDefaults integerForKey:@"wasLaunched"] == 0) {
        [theDefaults setInteger:1 forKey:@"wasLaunched"];
        [theDefaults synchronize];
        return true;
    }
    return false;
}

@end
