//
//  DLNewViewController.m
//  Forecast
//
//  Created by Dmitry Laenko on 01/07/15.
//  Copyright (c) 2015 home. All rights reserved.
//

#import "DLNewViewController.h"
#import "DLWeatherManager.h"
#import "UIAlertView+DL.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface DLNewViewController()

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *countryField;

@end
@implementation DLNewViewController


- (IBAction)clickDone:(id)sender
{
    
    if ([self.nameField.text length]<1){
        [UIAlertView showAlertWithErrorMessage:@"Название города не может быть пустым"];
        return;
    }
    if ([self.countryField.text length]<1){
        [UIAlertView showAlertWithErrorMessage:@"Название страны не может быть пустым"];
        return;
    }
    
    [SVProgressHUD show];
    __weak typeof(self)weakSelf = self;
    [[DLWeatherManager getInstance] currentWeatherByCity:self.nameField.text country:self.countryField.text withCompletion:^(id result, BOOL isCancelled, NSError *error) {
        [SVProgressHUD dismiss];
        if (isCancelled || error || [result count]==0){
            [UIAlertView showAlertWithErrorMessage:@"Город не найден"];
            return;
        }
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
}

@end
