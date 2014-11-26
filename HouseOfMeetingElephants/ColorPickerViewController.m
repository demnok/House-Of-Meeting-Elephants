//
//  ColorPickerViewController.m
//  HouseOfMeetingElephants
//
//  Created by Stolniceanu Stefan on 10/11/14.
//  Copyright (c) 2014 Stefan Stolniceanu. All rights reserved.
//

#import "ColorPickerViewController.h"

@interface ColorPickerViewController ()

@end

@implementation ColorPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setModalPresentationStyle:UIModalPresentationFormSheet];
    [self presentViewController:self animated:YES completion:nil];
}

-(void)colorPickerViewController:(FCColorPickerViewController *)colorPicker didSelectColor:(UIColor *)color {
    self.color = color;
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)colorPickerViewControllerDidCancel:(FCColorPickerViewController *)colorPicker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
