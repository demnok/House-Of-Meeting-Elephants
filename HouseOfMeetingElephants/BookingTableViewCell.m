//
//  BookingTableViewCell.m
//  HouseOfMeetingElephants
//
//  Created by Stolniceanu Stefan on 04/11/14.
//  Copyright (c) 2014 Stefan Stolniceanu. All rights reserved.
//

#import "BookingTableViewCell.h"

@implementation BookingTableViewCell

- (void)awakeFromNib{
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)setCurrentBooking:(Booking *)currentBooking {
    [self populateInterface:currentBooking];
}

-(void)populateInterface:(Booking *)booking {
    self.bookingTitleLabel.text = booking.name;
    self.bookingRoomLabel.text = booking.room.name;
    self.bookingDurationLabel.text = booking.intervalOfTime;
        
    self.bookingTitleLabel.textColor = booking.project.color;
}
@end
