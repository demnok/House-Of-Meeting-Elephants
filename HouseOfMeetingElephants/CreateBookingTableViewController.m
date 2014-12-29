//
//  CreateBookingTableViewController.m
//  HouseOfMeetingElephants
//
//  Created by Stolniceanu Stefan on 05/11/14.
//  Copyright (c) 2014 Stefan Stolniceanu. All rights reserved.
//

#import "CreateBookingTableViewController.h"
#import "BookingList.h"

@interface CreateBookingTableViewController ()

@property (strong, nonatomic) Booking *booking;
@property (strong, nonatomic) RoomList *roomList;

@end

@implementation CreateBookingTableViewController

@synthesize roomLabel, startPointLabel, endPointLabel, assignedProjectLabel, isRecurrent, bookingNameTextField, delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialDeclaration];
    self.bookingNameTextField.delegate = self;
    self.booking = [[Booking alloc] init];
}

#pragma mark - Reload data methods

-(void)passRooms:(NSMutableArray *)rooms {
    [self.tableView reloadData];
}

#pragma mark - Initial data method

-(void)initialDeclaration {
    NSMutableArray *labelArray = [[NSMutableArray alloc] init];
    [labelArray addObject:self.roomLabel];
    [labelArray addObject:self.startPointLabel];
    [labelArray addObject:self.endPointLabel];
    [labelArray addObject:self.assignedProjectLabel];
    
    for(UILabel *label in labelArray) {
        label.text = @"Not yet chosen";
    }
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

-(void)ChooseRoomViewControllerDelegateDidSave:(ChooseRoomViewController *)vc
                                      withRoom:(Room *)room {
    
    self.booking.room = room;
    self.roomLabel.text = room.name;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark Methods for Choose Project View Controller Delegate

-(void)ChooseProjectViewControllerDelegateDidCancel:(ChooseProjectViewController *)vc {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)ChooseProjectViewControllerDelegateDidSave:(ChooseProjectViewController *)vc
                                      withProject:(Project *)project {
    
    self.booking.project = project;
    self.assignedProjectLabel.text = project.name;
    self.assignedProjectLabel.textColor = project.color;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark Methods for Choose Start Point View Controller Delegate

-(void)ChooseStartPointViewControllerDelegateDidCancel:(ChooseStartPointViewController *)vc {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)ChooseStartPointViewControllerDelegateDidSave:(ChooseStartPointViewController *)vc
                                            withDate:(NSDate *)date {
    
    self.booking.startDate = date;
    self.startPointLabel.text = [self convertDateToString:date];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark Methods for Choose End Point View Controller Delegate

-(void)ChooseEndPointViewControllerDelegateDidCancel:(ChooseEndPointViewController *)vc {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)ChooseEndPointViewControllerDelegateDidSave:(ChooseEndPointViewController *)vc
                                          withDate:(NSDate *)date {
    
    self.booking.endDate = date;
    self.endPointLabel.text = [self convertDateToString:date];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(NSString *)convertDateToString:(NSDate *)date {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'zzz'Z'"];
    
    NSString *formattedDate = [dateFormatter stringFromDate:date];
    
    return formattedDate;
}

#pragma mark - Navigation bar methods

- (IBAction)saveBooking:(id)sender {
    self.booking.name = self.bookingNameTextField.text;
    self.booking.recurrent = self.isRecurrent.isOn;

    if (!self.booking.project) {
        self.booking.project = [[Project alloc] init];
        self.booking.project.projectID = @"No project";
    }

    if (!self.booking.room) {
        self.booking.room = [[Room alloc] init];
        self.booking.room.roomID = @"No room";
    }
    
    if (!self.booking.endDate || !self.booking.startDate) {
        
        NSString* msg  = @"Please choose both dates before proceeding";
        NSString* title = @"Date not found";
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title  message:msg  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
        
    } else {
    
        [self.delegate createBookingViewControllerDelegateDidSave:self booking:self.booking];
        
    }
}

- (IBAction)cancelBooking:(id)sender {
    [self.delegate createBookingViewControllerDelegateDidCancel:self];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [super tableView:tableView numberOfRowsInSection:section];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}

@end
