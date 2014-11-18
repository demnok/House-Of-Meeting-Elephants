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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)colorPickerViewController:(FCColorPickerViewController *)colorPicker didSelectColor:(UIColor *)color {
    self.color = color;
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)colorPickerViewControllerDidCancel:(FCColorPickerViewController *)colorPicker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
