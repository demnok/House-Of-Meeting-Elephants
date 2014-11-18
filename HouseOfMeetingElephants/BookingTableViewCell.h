//
//  BookingTableViewCell.h
//  HouseOfMeetingElephants
//
//  Created by Stolniceanu Stefan on 04/11/14.
//  Copyright (c) 2014 Stefan Stolniceanu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Booking.h"

@interface BookingTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *bookingTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *bookingRoomLabel;
@property (weak, nonatomic) IBOutlet UILabel *bookingDurationLabel;

@property (nonatomic, strong) Booking *currentBooking;

@end
