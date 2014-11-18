//
//  BookingDetailViewController.m
//  HouseOfMeetingElephants
//
//  Created by Stolniceanu Stefan on 17/11/14.
//  Copyright (c) 2014 Stefan Stolniceanu. All rights reserved.
//

#import "BookingDetailViewController.h"

@interface BookingDetailViewController ()

@end

@implementation BookingDetailViewController

@synthesize bookingLabel, recurrencyLabel, projectLabel, roomLabel, startPointLabel, endPointLabel, detailBooking;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self populateInterfaceWithReservation:self.detailBooking];
}

- (IBAction)dismissViewController:(id)sender {
    [self.delegate BookingDetailViewControllerDelegateDidGoBack:self];
}

-(void)populateInterfaceWithReservation:(Booking *)booking {
    
    self.bookingLabel.text = booking.name;
    self.roomLabel.text = booking.room.name;
    
    self.projectLabel.text = booking.project.name;
    self.projectLabel.textColor = booking.project.color;
    
    if (booking.isRecurrent) {
        self.recurrencyLabel.text = @"Recurrent";
    } else {
        self.recurrencyLabel.text = @"Not recurrent";
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd-HH:mm"];
    
    self.startPointLabel.text = [dateFormatter stringFromDate:booking.startDate];
    self.endPointLabel.text = [dateFormatter stringFromDate:booking.endDate];
}

@end
