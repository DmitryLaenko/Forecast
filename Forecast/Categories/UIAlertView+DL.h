//
//  UIAlertView+DL.h
//  Forecast
//
//  Created by Dmitry Laenko on 01/07/15.
//  Copyright (c) 2015 home. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertView (DL)

+ (void)showAlertWithErrorMessage:(NSString *)errorMessage;
+ (void)showMessage:(NSString *)message;

@end
