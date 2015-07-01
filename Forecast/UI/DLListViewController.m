//
//  DLListViewController.m
//  Forecast
//
//  Created by Dmitry Laenko on 01/07/15.
//  Copyright (c) 2015 home. All rights reserved.
//

#import "DLListViewController.h"
#import "DLCitiesDataSource.h"
#import "DLWeatherManager.h"
#import "DLCityManager.h"
#import "DLForecastViewController.h"

@interface DLListViewController()<UITableViewDelegate>{
    UIRefreshControl *refreshControl;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) DLCitiesDataSource *datasource;
@end

@implementation DLListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.datasource = [[DLCitiesDataSource alloc] initWithTableView:self.tableView];
    self.tableView.delegate = self;
    
    refreshControl = [[UIRefreshControl alloc] init];
    
    [refreshControl addTarget:self action:@selector(refreshCities:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];

    [[DLWeatherManager getInstance] currentWeatherByIds:[[DLCityManager getInstance] allCitiesId] withCompletion:nil];
}

- (void)refreshCities:(id)sender
{
    [[DLWeatherManager getInstance] currentWeatherByIds:[[DLCityManager getInstance] allCitiesId] withCompletion:^(id result, BOOL isCancelled, NSError *error) {
        
    }];
    [refreshControl endRefreshing];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showForecast"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        DLCity *city = [self.datasource cityByIndexPath:indexPath];
        if (city)
            [[segue destinationViewController] setCity:city];
    }
}


@end
