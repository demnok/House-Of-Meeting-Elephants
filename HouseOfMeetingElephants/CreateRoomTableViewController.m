//
//  CreateRoomTableViewController.m
//  HouseOfMeetingElephants
//
//  Created by Stolniceanu Stefan on 05/11/14.
//  Copyright (c) 2014 Stefan Stolniceanu. All rights reserved.
//

#import "CreateRoomTableViewController.h"
#import "Room.h"

@interface CreateRoomTableViewController ()

@property (nonatomic, strong) Room *room;

@end

@implementation CreateRoomTableViewController

@synthesize delegate, roomNameTextField;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.room = [[Room alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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

 #pragma mark - Navigation

 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 
 }

- (IBAction)cancelRoom:(id)sender {
    [self.delegate CreateRoomTableViewControllerDelegateDidCancel:self];
}

- (IBAction)saveRoom:(id)sender {
    
    self.room.name = self.roomNameTextField.text;
    
    [self.delegate CreateRoomTableViewControllerDelegateDidSave:self room:self.room];
}
@end
