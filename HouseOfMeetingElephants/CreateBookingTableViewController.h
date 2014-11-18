//
//  CreateBookingTableViewController.h
//  HouseOfMeetingElephants
//
//  Created by Stolniceanu Stefan on 05/11/14.
//  Copyright (c) 2014 Stefan Stolniceanu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CreateBookingViewControllerDelegate.h"
#import "ChooseRoomViewController.h"
#import "ChooseProjectViewController.h"
#import "ChooseStartPointViewController.h"
#import "ChooseEndPointViewController.h"

@interface CreateBookingTableViewController : UITableViewController <UITextFieldDelegate, ChooseRoomViewControllerDelegate, ChooseProjectViewControllerDelegate, ChooseStartPointViewControllerDelegate, ChooseEndPointViewControllerDelegate>

@property (nonatomic, weak) id<CreateBookingViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITextField *bookingNameTextField;
@property (weak, nonatomic) IBOutlet UILabel *roomLabel;
@property (weak, nonatomic) IBOutlet UILabel *startPointLabel;
@property (weak, nonatomic) IBOutlet UILabel *endPointLabel;
@property (weak, nonatomic) IBOutlet UILabel *assignedProjectLabel;
@property (weak, nonatomic) IBOutlet UISwitch *isRecurrent;

- (IBAction)saveBooking:(id)sender;
- (IBAction)cancelBooking:(id)sender;


@end
