//
//  BookingDetailTableViewController.m
//  HouseOfMeetingElephants
//
//  Created by Stolniceanu Stefan on 04/12/14.
//  Copyright (c) 2014 Stefan Stolniceanu. All rights reserved.
//

#import "BookingDetailTableViewController.h"

@interface BookingDetailTableViewController ()

@property (strong, nonatomic) RoomList *roomList;

@end

@implementation BookingDetailTableViewController

@synthesize detailBooking, roomLabel, startPointLabel, endPointLabel, assignedProjectLabel, isRecurrent, bookingNameTextField, delegate;

-(void)viewDidLoad {
    [super viewDidLoad];
    [self populateInterfaceWithBooking:self.detailBooking];
}

-(void)populateInterfaceWithBooking:(Booking *)booking {
    
    self.bookingNameTextField.text = booking.name;
    self.roomLabel.text = booking.room.name;
    [self.isRecurrent setOn:booking.isRecurrent animated:YES];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd-HH:mm"];
    
    self.startPointLabel.text = [dateFormatter stringFromDate:booking.startDate];
    self.endPointLabel.text = [dateFormatter stringFromDate:booking.endDate];

    self.assignedProjectLabel.text = booking.project.name;
    self.assignedProjectLabel.textColor = booking.project.color;
    
}

#pragma mark Prepare for segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"chooseRoom"]) {
        
        UINavigationController *navigationController = segue.destinationViewController;
        
        ChooseRoomViewController *destination = navigationController.viewControllers.firstObject;
        
        self.roomList.delegate = destination;
        [self.roomList fetchRooms];
        
        destination.delegate = self;
    }
    
    if([segue.identifier isEqualToString:@"chooseProject"]) {
        
        UINavigationController *navigationController = segue.destinationViewController;
        
        ChooseProjectViewController *destination = navigationController.viewControllers.firstObject;
        
        destination.delegate = self;
    }
    
    if([segue.identifier isEqualToString:@"chooseStartPoint"]) {
        
        UINavigationController *navigationController = segue.destinationViewController;
        
        ChooseStartPointViewController *destination = navigationController.viewControllers.firstObject;
        
        destination.delegate = self;
    }
    
    if([segue.identifier isEqualToString:@"chooseEndPoint"]) {
        
        UINavigationController *navigationController = segue.destinationViewController;
        
        ChooseEndPointViewController *destination = navigationController.viewControllers.firstObject;
        
        destination.delegate = self;
    }
}

#pragma mark Methods for Choose Room View Controller Delegate

-(void)ChooseRoomViewControllerDelegateDidCancel:(ChooseRoomViewController *)vc {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)ChooseRoomViewControllerDelegateDidSave:(ChooseRoomViewController *)vc withRoom:(Room *)room {
    
    self.detailBooking.room = room;
    self.roomLabel.text = room.name;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark Methods for Choose Project View Controller Delegate

-(void)ChooseProjectViewControllerDelegateDidCancel:(ChooseProjectViewController *)vc {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)ChooseProjectViewControllerDelegateDidSave:(ChooseProjectViewController *)vc withProject:(Project *)project {
    
    self.detailBooking.project = project;
    self.assignedProjectLabel.text = project.name;
    self.assignedProjectLabel.textColor = project.color;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark Methods for Choose Start Point View Controller Delegate

-(void)ChooseStartPointViewControllerDelegateDidCancel:(ChooseStartPointViewController *)vc {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)ChooseStartPointViewControllerDelegateDidSave:(ChooseStartPointViewController *)vc withDate:(NSDate *)date {
    
    self.detailBooking.startDate = date;
    self.startPointLabel.text = [self convertDateToString:date];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark Methods for Choose End Point View Controller Delegate

-(void)ChooseEndPointViewControllerDelegateDidCancel:(ChooseEndPointViewController *)vc {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)ChooseEndPointViewControllerDelegateDidSave:(ChooseEndPointViewController *)vc withDate:(NSDate *)date {
    
    self.detailBooking.endDate = date;
    self.endPointLabel.text = [self convertDateToString:date];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(NSString *)convertDateToString:(NSDate *)date {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'zzz'Z'"];
    
    NSString *formattedDate = [dateFormatter stringFromDate:date];
    
    return formattedDate;
}

#pragma mark - Table view data source

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [super tableView:tableView numberOfRowsInSection:section];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    [[super tableView:tableView cellForRowAtIndexPath:indexPath] setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
}

- (IBAction)goBack:(id)sender {
    [self.delegate BookingDetailViewControllerDelegateDidGoBack:self];
}

- (IBAction)updateBooking:(id)sender {
    self.detailBooking.name = self.bookingNameTextField.text;
    self.detailBooking.recurrent = self.isRecurrent.isOn;
    
    [self.delegate BookingDetailViewControllerDelegateDidUpdate:self
                                                    withBooking:self.detailBooking];
}
@end
