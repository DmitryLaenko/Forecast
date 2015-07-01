//
//  DLCitiesDataSource.m
//  Forecast
//
//  Created by Dmitry Laenko on 01/07/15.
//  Copyright (c) 2015 home. All rights reserved.
//

#import "DLCitiesDataSource.h"
#import "DLCityManager.h"
#import "DLCityCell.h"

@interface DLCitiesDataSource()<UITableViewDataSource, NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSFetchedResultsController *feathController;

@end

@implementation DLCitiesDataSource

- (instancetype)initWithTableView:(UITableView *)table
{
    self = [super init];
    if (self) {
        self.tableView = table;
        self.feathController = [[DLCityManager getInstance] getFetchedResultsController];
        self.tableView.dataSource = self;
        self.feathController.delegate = self;
    }
    return self;
}

- (DLCity *)cityByIndexPath:(NSIndexPath *)indexPath
{
    if ([self.feathController.fetchedObjects count]>indexPath.row){
        return self.feathController.fetchedObjects[indexPath.row];
    }else{
        return nil;
    }
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.feathController.fetchedObjects count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identif = @"cityCell";
    DLCityCell *cell = (DLCityCell *)[tableView dequeueReusableCellWithIdentifier:identif];
    
    cell.city = (DLCity *)self.feathController.fetchedObjects[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        DLCity *city = (DLCity *)self.feathController.fetchedObjects[indexPath.row];
        [[DLCityManager getInstance] deleteCityById:city.cid];
    }
}

#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
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
            
            DLCityCell *cell = (DLCityCell *) [self.tableView cellForRowAtIndexPath: indexPath];
            DLCity *city = [self.feathController objectAtIndexPath: indexPath];
            cell.city = city;
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
