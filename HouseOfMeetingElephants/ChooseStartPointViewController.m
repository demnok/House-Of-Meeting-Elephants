//
//  ChooseStartPointViewController.m
//  HouseOfMeetingElephants
//
//  Created by Stolniceanu Stefan on 12/11/14.
//  Copyright (c) 2014 Stefan Stolniceanu. All rights reserved.
//

#import "ChooseStartPointViewController.h"

@interface ChooseStartPointViewController ()

@end

@implementation ChooseStartPointViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)saveChoiceOfStartPointDate:(id)sender {
    [self.delegate ChooseStartPointViewControllerDelegateDidSave:self withDate:[self.startPointDatePicker date]];
}

- (IBAction)cancelChoiceOfStartPointDate:(id)sender {
    [self.delegate ChooseStartPointViewControllerDelegateDidCancel:self];
}
@end
