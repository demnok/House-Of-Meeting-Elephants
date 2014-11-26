//
//  BookingTableViewController.m
//  HouseOfMeetingElephants
//
//  Created by Stolniceanu Stefan on 04/11/14.
//  Copyright (c) 2014 Stefan Stolniceanu. All rights reserved.
//

#import "BookingTableViewController.h"

@interface BookingTableViewController ()

@property (nonatomic, strong) Booking *sentBooking;

@end

@implementation BookingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [BookingList sharedInstance].delegate = self;
    [[BookingList sharedInstance] fetchData];
    [self.tableView registerNib:[UINib nibWithNibName:@"BookingTableViewCell" bundle:nil] forCellReuseIdentifier:@"BookingTableViewCell"];
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
    
    [[BookingList sharedInstance].bookings addObject:booking];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark Methods for Booking Detail View Controller Delegate

-(void)BookingDetailViewControllerDelegateDidGoBack:(BookingDetailViewController *)vc {
    [self.navigationController popViewControllerAnimated:YES];
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
     
        BookingDetailViewController *destination = navigationController.viewControllers.firstObject;
        destination.detailBooking = self.sentBooking;
        destination.delegate = self;
    }
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [BookingList sharedInstance].bookings.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BookingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BookingTableViewCell"];
    
    cell.currentBooking = [BookingList sharedInstance].bookings[indexPath.row];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.sentBooking = [BookingList sharedInstance].bookings[indexPath.row];
    
    [self performSegueWithIdentifier:@"bookingDetail" sender:nil];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if(editingStyle == UITableViewCellEditingStyleDelete) {
        [[BookingList sharedInstance].bookings removeObjectAtIndex:indexPath.row];
        [tableView reloadData];
    }
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

@end
