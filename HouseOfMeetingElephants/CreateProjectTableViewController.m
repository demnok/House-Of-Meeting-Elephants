//
//  CreateProjectTableViewController.m
//  HouseOfMeetingElephants
//
//  Created by Stolniceanu Stefan on 05/11/14.
//  Copyright (c) 2014 Stefan Stolniceanu. All rights reserved.
//

#import "CreateProjectTableViewController.h"

@interface CreateProjectTableViewController ()

@property (nonatomic, strong) Project *project;

@end

@implementation CreateProjectTableViewController

@synthesize colorDisplayer, color;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.project = [[Project alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
    return [super numberOfSectionsInTableView:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [super tableView:tableView numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    [[super tableView:tableView cellForRowAtIndexPath:indexPath] setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
}

- (IBAction)cancelProject:(id)sender {
    [self.delegate CreateProjectTableViewControllerDelegateDidCancel:self];
}

- (IBAction)saveProject:(id)sender {
    
    self.project.color = self.color;
    self.project.name = self.projectNameTextField.text;
    
    [self.delegate CreateProjectTableViewControllerDelegateDidSave:self project:self.project];
}
@end
