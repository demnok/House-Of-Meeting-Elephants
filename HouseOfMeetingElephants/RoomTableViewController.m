//
//  RoomTableViewController.m
//  HouseOfMeetingElephants
//
//  Created by Stolniceanu Stefan on 04/11/14.
//  Copyright (c) 2014 Stefan Stolniceanu. All rights reserved.
//

#import "RoomTableViewController.h"

@interface RoomTableViewController () {
    NSString *cellID;
}

@property (nonatomic, strong) Room *sentRoom;
@property (nonatomic, strong) RoomList *roomList;

@end

@implementation RoomTableViewController

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.roomList = [[RoomList alloc] init];
    [self.roomList fetchRooms];
    self.roomList.delegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    cellID = @"RoomTableViewCell";
    
    UINib *nib = [UINib nibWithNibName:cellID bundle:nil];
    
    [self.tableView registerNib:nib forCellReuseIdentifier:cellID];
}

#pragma mark - Reloading data methods

- (IBAction)roomsRefresh:(id)sender {
    [self.roomList fetchRooms];
}

-(void)passRooms:(NSMutableArray *)rooms {
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.roomList.rooms.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RoomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.currentRoom = self.roomList.rooms[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.sentRoom = [self.roomList.rooms objectAtIndex:indexPath.row];
    
    [self performSegueWithIdentifier:@"roomDetail" sender:nil];
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if(editingStyle == UITableViewCellEditingStyleDelete) {
        
        Room *room = [self.roomList.rooms objectAtIndex:indexPath.row];
        
        [self.roomList deleteRoom:room];
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
    
    
    [self.roomList addRoom:room];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark Methods for the Booking Detail Table View Controller Delegate

-(void)RoomDetailTableViewControllerDelegateDidGoBack:(RoomDetailTableViewController *)vc {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)RoomDetailTableViewControllerDelegateDidUpdate:(RoomDetailTableViewController *)vc withRoom:(Room *)room {
    
    [self.roomList updateRoom:room];
    
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark Prepare for segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([segue.identifier isEqualToString:@"createRoom"]) {
        
        UINavigationController *navigationController = segue.destinationViewController;
        
        CreateRoomTableViewController *destination = navigationController.viewControllers.firstObject;
        
        destination.delegate = self;
    }
    
    if([segue.identifier isEqualToString:@"roomDetail"]) {
        
        RoomDetailTableViewController *destination = segue.destinationViewController;

        destination.detailRoom = self.sentRoom;
        destination.delegate = self;
    }
}

@end
