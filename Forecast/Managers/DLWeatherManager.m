//
//  DLWeatherManager.m
//  Forecast
//
//  Created by Dmitry Laenko on 30/06/15.
//  Copyright (c) 2015 home. All rights reserved.
//

#import "DLWeatherManager.h"
#import <AFNetworking/AFNetworking.h>
#import "DLCityManager.h"
#import "DLForecastManager.h"

@interface DLWeatherManager(){
    AFHTTPClient *client;
    dispatch_queue_t backgroundQueue;
}

@property (strong, nonatomic) NSString *appClientID;

@end

#define kKeyUnits   @"units"
#define kKeyLang    @"lang"

@implementation DLWeatherManager

+ (instancetype)getInstance
{
    static DLWeatherManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[DLWeatherManager alloc] init];
    });
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self){
        client = [AFHTTPClient clientWithBaseURL:[NSURL URLWithString:kWeatherBaseUrl]];
        [client setParameterEncoding:AFJSONParameterEncoding];
        [client registerHTTPOperationClass:[AFJSONRequestOperation class]];
        backgroundQueue = dispatch_queue_create("background", NULL);
        self.appClientID = kWeatherAppClientId;
    }
    return self;
}

- (void)currentWeatherByCity:(NSString *)name country:(NSString *)country withCompletion:(DLCompletionBlock)block
{
    NSAssert(name && country, @"City and Country must be fill");
    [self requesGETWithParameter:@{@"q" : name} url:@"weather" responseManager:[DLCityManager class] withBlock:block];
}

- (void)currentWeatherByIds:(NSArray *)Ids withCompletion:(DLCompletionBlock)block
{
    [self requesGETWithParameter:@{@"id" : [Ids componentsJoinedByString:@","]} url:@"group" responseManager:[DLCityManager class] withBlock:block];
}

- (void)forecastForCity:(NSString *)cityId  withCompletion:(DLCompletionBlock)block
{
    if (cityId==nil){
        RESULT_CANCELLED_BLOCK(block);
    }
    
    [self requesGETWithParameter:@{@"id" : cityId} url:@"forecast" responseManager:[DLForecastManager class] withBlock:block];
}

- (NSURLRequest *)requesGETWithParameter:(NSDictionary*)params url:(NSString *)urlString responseManager:(Class)managerClass withBlock:(DLCompletionBlock)block
{
    
    NSMutableDictionary *requestParam;
    if (params==nil)
        requestParam = [NSMutableDictionary new];
    else
        requestParam = params.mutableCopy;
    
    [requestParam setObject:@"metric" forKey:kKeyUnits];
    [requestParam setObject:@"ru" forKey:kKeyLang];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    NSMutableURLRequest *request = [client requestWithMethod:@"GET"
                                                        path:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]
                                                  parameters:requestParam];
    
    dispatch_async(backgroundQueue, ^{
        [[AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
            
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            
            NSError *error = [self errorFromJSON:JSON];
            
            if (error){
                dispatch_async(dispatch_get_main_queue(), ^{
                    RESULT_FAILED_BLOCK(nil, NO, error, block);
                });
                return;
            }
            
            NSArray *objects = [[managerClass getInstance] parseJSON:JSON];
            dispatch_async(dispatch_get_main_queue(), ^{
                RESULT_SUCCESS_BLOCK(objects, block);
            });
            
            
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            RESULT_FAILED_BLOCK(nil, NO, error, block);
        }] start];
    });
    
    return request;
}

- (NSError *)errorFromJSON:(NSDictionary *)data
{
    if (IS_NULL(data)) return nil;
    if (IS_NULL(data[kKeyCode])) return nil;
    
    NSInteger code = INTEGER(data[kKeyCode]);
    
    if (code<200 || code>299){
        return [[NSError alloc] initWithDomain:@"" code:INTEGER(data[kKeyCode]) userInfo:@{NSLocalizedDescriptionKey: STRING(data[kKeyMessage])}];
    }
    
    return nil;
}

@end
