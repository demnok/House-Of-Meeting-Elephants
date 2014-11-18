//
//  Reservation.m
//  HouseOfMeetingElephants
//
//  Created by Stolniceanu Stefan on 04/11/14.
//  Copyright (c) 2014 Stefan Stolniceanu. All rights reserved.
//

#import "Booking.h"

@implementation Booking

- (instancetype)initWithBookingName:(NSString *)name bookingRoom:(Room *)room bookingStartDate:(NSDate *)startDate bookingEndDate:(NSDate *)endDate bookedByProject:(Project *)project recurrency:(BOOL)isRecurrent {
    
    self = [super init];
    
    if (self) {
        self.name = name;
        self.room = room;
        self.startDate = startDate;
        self.endDate = endDate;
        self.project = project;
        self.recurrent = isRecurrent;
    }
    return self;
}

- (NSString *)intervalOfTime {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    
    NSString *startPoint = [dateFormatter stringFromDate:self.startDate];
    NSString *endPoint = [dateFormatter stringFromDate:self.endDate];
    
    return [NSString stringWithFormat:@"%@ - %@", startPoint, endPoint];
}

@end
