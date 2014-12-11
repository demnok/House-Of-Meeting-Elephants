//
//  BookingTableViewController.m
//  HouseOfMeetingElephants
//
//  Created by Stolniceanu Stefan on 04/11/14.
//  Copyright (c) 2014 Stefan Stolniceanu. All rights reserved.
//

#import "BookingTableViewController.h"

@interface BookingTableViewController ()

@property (nonatomic, strong) BookingList *bookingList;
@property (nonatomic, strong) ProjectList *projectList;
@property (nonatomic, strong) RoomList *roomList;

@property (nonatomic, strong) Booking *sentBooking;

@end

@implementation BookingTableViewController

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.roomList = [[RoomList alloc] init];
    
    self.roomList.delegate = self;
    [self.roomList fetchRooms];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.bookingList = [[BookingList alloc] init];
    self.projectList = [[ProjectList alloc] init];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"BookingTableViewCell" bundle:nil] forCellReuseIdentifier:@"BookingTableViewCell"];
}

-(void)passRooms:(NSMutableArray *)rooms {
    [self.tableView reloadData];
    
    self.projectList.delegate = self;
    [self.projectList fetchProjects];
}

-(void)passProjects:(NSMutableArray *)projects {
    [self.tableView reloadData];
    
    self.bookingList.delegate = self;
    [self.bookingList fetchDataForBookingsFromRoomList:self.roomList andFromProjectList:self.projectList];
}

-(void)passData:(NSMutableArray *)data {
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Methods for Create Booking View Controller Delegate

-(void)createBookingViewControllerDelegateDidCancel:(CreateBookingTableViewController *)vc {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)createBookingViewControllerDelegateDidSave:(CreateBookingTableViewController *)vc booking:(Booking *)booking {
    
    [self.bookingList addBooking:booking];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark Methods for Booking Detail View Controller Delegate

-(void)BookingDetailViewControllerDelegateDidGoBack:(BookingDetailTableViewController *)vc {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)BookingDetailViewControllerDelegateDidUpdate:(BookingDetailTableViewController *)vc withBooking:(Booking *)booking {
    
    [self.bookingList updateBooking:booking];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark Prepare for segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"createBooking"]) {
        
        UINavigationController *navigationController = segue.destinationViewController;
        
        CreateBookingTableViewController *destination = navigationController.viewControllers.firstObject;
        
        destination.delegate = self;
    }
    
    if([segue.identifier isEqualToString:@"bookingDetail"]) {
        
        UINavigationController *navigationController = segue.destinationViewController;
     
        BookingDetailTableViewController *destination = navigationController.viewControllers.firstObject;
        
        destination.detailBooking = self.sentBooking;
        destination.delegate = self;
    }
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.bookingList.bookings.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BookingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BookingTableViewCell"];
    
    cell.currentBooking = self.bookingList.bookings[indexPath.row];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.sentBooking = self.bookingList.bookings[indexPath.row];
    
    [self performSegueWithIdentifier:@"bookingDetail" sender:nil];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if(editingStyle == UITableViewCellEditingStyleDelete) {
        Booking *booking = [self.bookingList.bookings objectAtIndex:indexPath.row];
        [self.bookingList deleteBooking:booking];
    }
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

@end
