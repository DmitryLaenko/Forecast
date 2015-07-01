//
//  DLCitiesDataSource.h
//  Forecast
//
//  Created by Dmitry Laenko on 01/07/15.
//  Copyright (c) 2015 home. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DLCity;
@interface DLCitiesDataSource : UITableViewCell

- (instancetype)initWithTableView:(UITableView *)table;
- (DLCity *)cityByIndexPath:(NSIndexPath *)indexPath;

@end
