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

-(void)populateInterfaceWithRoom:(Room *)room {
    self.roomNameTextField.text = room.name;
}

- (IBAction)updateRoom:(id)sender {
    self.detailRoom.name = self.roomNameTextField.text;
    
    [self.delegate RoomDetailTableViewControllerDelegateDidUpdate:self
                                                         withRoom:self.detailRoom];
}

- (IBAction)goBack:(id)sender {
    [self.delegate RoomDetailTableViewControllerDelegateDidGoBack:self];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    [[super tableView:tableView cellForRowAtIndexPath:indexPath] setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
}

@end
