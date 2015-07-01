//
//  DLForecastDataSource.m
//  Forecast
//
//  Created by Dmitry Laenko on 01/07/15.
//  Copyright (c) 2015 home. All rights reserved.
//

#import "DLForecastDataSource.h"
#import "DLForecastManager.h"
#import "DLForecastCell.h"

@interface DLForecastDataSource()<UITableViewDataSource, NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSFetchedResultsController *feathController;

@end

@implementation DLForecastDataSource

- (instancetype)initWithTableView:(UITableView *)table city:(DLCity *)city
{
    self = [super init];
    if (self) {
        self.tableView = table;
        self.feathController = [[DLForecastManager getInstance] getFetchedResultsControllerByCity:city];
        self.tableView.dataSource = self;
        self.feathController.delegate = self;
        [self.tableView reloadData];
    }
    return self;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.feathController)
        return [self.feathController.fetchedObjects count];
    else
        return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identif = @"forecastCell";
    DLForecastCell *cell = (DLForecastCell *)[tableView dequeueReusableCellWithIdentifier:identif];
    
    cell.forecast = (DLForecast *)self.feathController.fetchedObjects[indexPath.row];
    return cell;
}

#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller \
{
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath
     forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    
    switch(type) {
        case NSFetchedResultsChangeInsert: {
            
            [self.tableView insertRowsAtIndexPaths: [NSArray arrayWithObject: newIndexPath]
                                  withRowAnimation: UITableViewRowAnimationFade];
            
        }
            break;
            
        case NSFetchedResultsChangeDelete: {
            
            [self.tableView deleteRowsAtIndexPaths: [NSArray arrayWithObject: indexPath]
                                  withRowAnimation: UITableViewRowAnimationFade];
            
        }
            break;
            
        case NSFetchedResultsChangeUpdate: {
            
            DLForecastCell *cell = (DLForecastCell *) [self.tableView cellForRowAtIndexPath: indexPath];
            DLForecast *forecast = [self.feathController objectAtIndexPath: indexPath];
            cell.forecast = forecast;
        }
            break;
            
        case NSFetchedResultsChangeMove: {
            
            [self.tableView deleteRowsAtIndexPaths: [NSArray arrayWithObject: indexPath]
                                  withRowAnimation: UITableViewRowAnimationFade];
            [self.tableView insertRowsAtIndexPaths: [NSArray arrayWithObject: newIndexPath]
                                  withRowAnimation: UITableViewRowAnimationFade];
        }
            break;
    }
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{    
    [self.tableView endUpdates];
}

@end
