//
//  BookingDetailTableViewController.h
//  HouseOfMeetingElephants
//
//  Created by Stolniceanu Stefan on 04/12/14.
//  Copyright (c) 2014 Stefan Stolniceanu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookingDetailViewControllerDelegate.h"
#import "ChooseRoomViewController.h"
#import "ChooseProjectViewController.h"
#import "ChooseStartPointViewController.h"
#import "ChooseEndPointViewController.h"
#import "BookingList.h"

@interface BookingDetailTableViewController : UITableViewController <UITextFieldDelegate, ChooseRoomViewControllerDelegate, ChooseProjectViewControllerDelegate, ChooseStartPointViewControllerDelegate, ChooseEndPointViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *bookingNameTextField;
@property (weak, nonatomic) IBOutlet UILabel *roomLabel;
@property (weak, nonatomic) IBOutlet UILabel *startPointLabel;
@property (weak, nonatomic) IBOutlet UILabel *endPointLabel;
@property (weak, nonatomic) IBOutlet UILabel *assignedProjectLabel;
@property (weak, nonatomic) IBOutlet UISwitch *isRecurrent;

@property (weak, nonatomic) id<BookingDetailViewControllerDelegate>delegate;

@property (strong, nonatomic) Booking *detailBooking;

- (IBAction)goBack:(id)sender;
- (IBAction)updateBooking:(id)sender;

@end
