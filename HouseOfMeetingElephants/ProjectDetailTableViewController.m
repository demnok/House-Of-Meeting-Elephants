//
//  ProjectDetailTableViewController.m
//  HouseOfMeetingElephants
//
//  Created by Stolniceanu Stefan on 09/12/14.
//  Copyright (c) 2014 Stefan Stolniceanu. All rights reserved.
//

#import "ProjectDetailTableViewController.h"

@interface ProjectDetailTableViewController ()

@property (nonatomic, strong) Project *project;

@end

@implementation ProjectDetailTableViewController

@synthesize colorDisplayer, color, detailProject, projectNameTextField;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self populateInterfaceWithProject:self.detailProject];
}

-(void)populateInterfaceWithProject:(Project *)project {
    self.colorDisplayer.backgroundColor = self.detailProject.color;
    self.projectNameTextField.text = self.detailProject.name;
    
}

-(IBAction)chooseColor:(id)sender{
    FCColorPickerViewController *colorPicker = [FCColorPickerViewController colorPicker];
    colorPicker.color = self.color;
    colorPicker.delegate = self;
    
    [self presentViewController:colorPicker animated:YES completion:nil];
}

#pragma mark - FCColorPickerViewControllerDelegate Methods

-(void)colorPickerViewController:(FCColorPickerViewController *)colorPicker didSelectColor:(UIColor *)color {
    self.color = color;
    colorDisplayer.backgroundColor = color;
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)colorPickerViewControllerDidCancel:(FCColorPickerViewController *)colorPicker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [super tableView:tableView numberOfRowsInSection:section];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    [[super tableView:tableView cellForRowAtIndexPath:indexPath] setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
}

- (IBAction)updateProject:(id)sender {
    self.detailProject.name = self.projectNameTextField.text;
    self.detailProject.color = self.color;
    
    [self.delegate ProjectDetailTableViewControllerDelegateDidUpdate:self
                                                         withProject:self.detailProject];
}

- (IBAction)goBack:(id)sender {
    [self.delegate ProjectDetailTableViewControllerDelegateDidGoBack:self];
}

@end
