//
//  UIAlertView+DL.m
//  Forecast
//
//  Created by Dmitry Laenko on 01/07/15.
//  Copyright (c) 2015 home. All rights reserved.
//

#import "UIAlertView+DL.h"

@implementation UIAlertView (DL)

+ (void)showAlertWithErrorMessage:(NSString *) errorMessage
{
    
    UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Ошибка"
                                                             message:errorMessage
                                                            delegate:nil
                                                   cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [errorAlertView show];
}

+ (void)showMessage:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:message delegate:nil
                                          cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alert show];
    
}
@end
