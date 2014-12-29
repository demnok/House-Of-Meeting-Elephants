//
//  RoomDetailTableViewController.m
//  HouseOfMeetingElephants
//
//  Created by Stolniceanu Stefan on 08/12/14.
//  Copyright (c) 2014 Stefan Stolniceanu. All rights reserved.
//

#import "RoomDetailTableViewController.h"
#import "RoomList.h"

@implementation RoomDetailTableViewController

@synthesize roomNameTextField,detailRoom;

-(void)viewDidLoad {
    [super viewDidLoad];
    self.roomNameTextField.text = self.detailRoom.name;
}

#pragma mark - Population methods

-(void)populateInterfaceWithRoom:(Room *)room {
    self.roomNameTextField.text = room.name;
}


#pragma mark - Table view data source

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [super tableView:tableView numberOfRowsInSection:section];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}

#pragma mark - Navigation bar methods

- (IBAction)updateRoom:(id)sender {
    self.detailRoom.name = self.roomNameTextField.text;
    
    [self.delegate RoomDetailTableViewControllerDelegateDidUpdate:self
                                                         withRoom:self.detailRoom];
}

- (IBAction)goBack:(id)sender {
    [self.delegate RoomDetailTableViewControllerDelegateDidGoBack:self];
}

@end
