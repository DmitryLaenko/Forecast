//
//  DLForecastViewController.m
//  Forecast
//
//  Created by Dmitry Laenko on 01/07/15.
//  Copyright (c) 2015 home. All rights reserved.
//

#import "DLForecastViewController.h"
#import "DLWeatherManager.h"
#import "DLForecastDataSource.h"

@interface DLForecastViewController ()<UITableViewDelegate>{
    NSArray *arDataSource;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) DLForecastDataSource *datasource;

@end

@implementation DLForecastViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updateSource];
}

- (void)setCity:(DLCity *)city
{
    if (![_city isEqual:city]){
        _city = city;
        self.navigationItem.title = _city.name;
        
        [self updateSource];
        
        [[DLWeatherManager getInstance] forecastForCity:_city.cid withCompletion:nil];
    }
}


- (void)updateSource
{
    if (self.tableView && self.city)
        self.datasource = [[DLForecastDataSource alloc] initWithTableView:self.tableView city:self.city];
}

@end
