//
//  ChooseEndPointViewController.m
//  HouseOfMeetingElephants
//
//  Created by Stolniceanu Stefan on 12/11/14.
//  Copyright (c) 2014 Stefan Stolniceanu. All rights reserved.
//

#import "ChooseEndPointViewController.h"

@interface ChooseEndPointViewController ()

@end

@implementation ChooseEndPointViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)saveChoiceOfEndPointDate:(id)sender {
    [self.delegate ChooseEndPointViewControllerDelegateDidSave:self withDate:[self.endPointDatePicker date]];
}

- (IBAction)cancelChoiceOfEndPointDate:(id)sender {
    [self.delegate ChooseEndPointViewControllerDelegateDidCancel:self];
}
@end
