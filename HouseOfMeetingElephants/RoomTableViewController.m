//
//  RoomTableViewController.m
//  HouseOfMeetingElephants
//
//  Created by Stolniceanu Stefan on 04/11/14.
//  Copyright (c) 2014 Stefan Stolniceanu. All rights reserved.
//

#import "RoomTableViewController.h"

@interface RoomTableViewController ()

@end

@implementation RoomTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"RoomTableViewCell" bundle:nil] forCellReuseIdentifier:@"RoomTableViewCell"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [RoomList sharedInstance].rooms.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RoomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RoomTableViewCell"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.currentRoom = [RoomList sharedInstance].rooms[indexPath.row];
    
    return cell;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if(editingStyle == UITableViewCellEditingStyleDelete) {
        [[RoomList sharedInstance].rooms removeObjectAtIndex:indexPath.row];
        [tableView reloadData];
    }
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}
#pragma mark Methods for the Create Room Table View Controller Delegate


-(void)CreateRoomTableViewControllerDelegateDidCancel:(CreateRoomTableViewController *)vc {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)CreateRoomTableViewControllerDelegateDidSave:(CreateRoomTableViewController *)vc room:(Room *)room {
    
    [[RoomList sharedInstance].rooms addObject:room];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark Prepare for segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([segue.identifier isEqualToString:@"createRoom"]) {
        
        UINavigationController *navigationController = segue.destinationViewController;
        
        CreateRoomTableViewController *destination = navigationController.viewControllers.firstObject;
        
        destination.delegate = self;
    }
}

@end
