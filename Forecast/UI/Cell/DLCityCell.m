//
//  DLCityCell.m
//  Forecast
//
//  Created by Dmitry Laenko on 01/07/15.
//  Copyright (c) 2015 home. All rights reserved.
//

#import "DLCityCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface DLCityCell()

@property (weak, nonatomic) IBOutlet UILabel *cityNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *tempLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *dataLabel;

@end

@implementation DLCityCell

- (void)awakeFromNib
{
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:NO];
}

- (void)setCity:(DLCity *)city
{
    if (![_city isEqual:city]){
        _city = city;
        self.cityNameLabel.text = [NSString stringWithFormat:@"%@, %@", _city.name, [_city.country uppercaseString]];
        [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:_city.icon]];
        self.tempLabel.text = [NSString stringWithFormat:@"%i˚C", (int)_city.tempValue];
        self.descLabel.text = _city.desc;
        self.dataLabel.text = [NSString stringWithFormat:@"Влажность %@%%, Давление %@ hPa", _city.humidity, _city.pressure];
    }
}
@end
