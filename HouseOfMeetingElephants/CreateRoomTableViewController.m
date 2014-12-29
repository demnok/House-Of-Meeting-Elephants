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
@property (nonatomic, strong) RoomList *roomList;

@end

@implementation CreateRoomTableViewController

@synthesize delegate, roomNameTextField;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.roomList = [[RoomList alloc] init];
    self.room = [[Room alloc] init];
}

#pragma mark - Reload data methods

-(void)passRooms:(NSMutableArray *)rooms {
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [super numberOfSectionsInTableView:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [super tableView:tableView numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
}

 #pragma mark - Prepare for segue

 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 
 }

#pragma mark - Navigation bar methods

- (IBAction)cancelRoom:(id)sender {
    
    self.roomList.delegate = self;
    [self.roomList fetchRooms];
    
    [self.delegate CreateRoomTableViewControllerDelegateDidCancel:self];
}

- (IBAction)saveRoom:(id)sender {
    
    self.room.name = self.roomNameTextField.text;
    
    self.roomList.delegate = self;
    [self.roomList fetchRooms];
    
    [self.delegate CreateRoomTableViewControllerDelegateDidSave:self room:self.room];
}
@end
