//
//  DLForecastCell.m
//  Forecast
//
//  Created by Dmitry Laenko on 01/07/15.
//  Copyright (c) 2015 home. All rights reserved.
//

#import "DLForecastCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "NSDate+DL.h"

@interface DLForecastCell()

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *tempLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *dataLabel;

@end

@implementation DLForecastCell

- (void)awakeFromNib
{
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:NO];
}

- (void)setForecast:(DLForecast *)forecast
{
    if (![_forecast isEqual:forecast]){
        _forecast = forecast;
        self.timeLabel.text = [_forecast.dataTime dataTime];
        [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:_forecast.icon]];
        self.tempLabel.text = [NSString stringWithFormat:@"%i˚C", (int)_forecast.tempValue];
        self.descLabel.text = _forecast.desc;
        self.dataLabel.text = [NSString stringWithFormat:@"Влажность %@%%, Давление %@ hPa", _forecast.humidity, _forecast.pressure];
    }
}
@end
