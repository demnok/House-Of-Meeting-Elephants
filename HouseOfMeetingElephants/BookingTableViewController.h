//
//  BookingTableViewController.h
//  HouseOfMeetingElephants
//
//  Created by Stolniceanu Stefan on 04/11/14.
//  Copyright (c) 2014 Stefan Stolniceanu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookingTableViewCell.h"
#import "BookingList.h"
#import "CreateBookingTableViewController.h"
#import "BookingDetailTableViewController.h"

@interface BookingTableViewController : UITableViewController <CreateBookingViewControllerDelegate, BookingDetailViewControllerDelegate, PassBookingsDelegate, PassRoomsProtocol, PassProjectsProtocol>

- (IBAction)bookingsRefresh:(id)sender;

@end
