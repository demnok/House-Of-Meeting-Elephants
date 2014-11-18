//
//  ChooseProjectViewController.m
//  HouseOfMeetingElephants
//
//  Created by Stolniceanu Stefan on 12/11/14.
//  Copyright (c) 2014 Stefan Stolniceanu. All rights reserved.
//

#import "ChooseProjectViewController.h"

@interface ChooseProjectViewController ()

@end

@implementation ChooseProjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.projectPickerSource = [[NSMutableArray alloc] init];
    self.projectPickerSource = [ProjectList sharedInstance].projects;
    self.projectPicker.delegate = self;
}

# pragma-mark Methods for the UIPickerView delegate

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.projectPickerSource count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [[self.projectPickerSource objectAtIndex:row] name];
}

# pragma-mark Methods for Create Project Table View Controller Delegate

-(void)CreateProjectTableViewControllerDelegateDidCancel:(CreateProjectTableViewController *)vc {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)CreateProjectTableViewControllerDelegateDidSave:(CreateProjectTableViewController *)vc project:(Project *)project {
    [[ProjectList sharedInstance].projects addObject:project];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

# pragma-mark Preparing for segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([segue.identifier isEqualToString:@"createProject"]) {
        
        UINavigationController *navigationController = segue.destinationViewController;
        
        CreateProjectTableViewController *destination= navigationController.viewControllers.firstObject;
        
        destination.delegate = self;
    }
}

- (IBAction)saveChoiceOfProject:(id)sender {
    [self.delegate ChooseProjectViewControllerDelegateDidSave:self withProject:[self.projectPickerSource objectAtIndex:[self.projectPicker selectedRowInComponent:0]]];
}

- (IBAction)cancelChoiceOfProject:(id)sender {
    [self.delegate ChooseProjectViewControllerDelegateDidCancel:self];
}
@end
