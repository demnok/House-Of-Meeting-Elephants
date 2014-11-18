//
//  ReservationList.h
//  HouseOfMeetingElephants
//
//  Created by Stolniceanu Stefan on 11/11/14.
//  Copyright (c) 2014 Stefan Stolniceanu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Booking.h"

@interface BookingList : NSObject

@property (nonatomic, strong) NSMutableArray *bookings;

+ (BookingList *)sharedInstance;

@end
