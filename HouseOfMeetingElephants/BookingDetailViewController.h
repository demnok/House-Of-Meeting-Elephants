//
//  BookingDetailViewController.h
//  HouseOfMeetingElephants
//
//  Created by Stolniceanu Stefan on 17/11/14.
//  Copyright (c) 2014 Stefan Stolniceanu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Booking.h"
#import "BookingDetailViewControllerDelegate.h"

@interface BookingDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *bookingLabel;
@property (weak, nonatomic) IBOutlet UILabel *projectLabel;
@property (weak, nonatomic) IBOutlet UILabel *roomLabel;
@property (weak, nonatomic) IBOutlet UILabel *recurrencyLabel;
@property (weak, nonatomic) IBOutlet UILabel *startPointLabel;
@property (weak, nonatomic) IBOutlet UILabel *endPointLabel;

@property (nonatomic, strong) Booking *detailBooking;

@property (nonatomic, weak) id<BookingDetailViewControllerDelegate>delegate;

- (IBAction)dismissViewController:(id)sender;

@end
