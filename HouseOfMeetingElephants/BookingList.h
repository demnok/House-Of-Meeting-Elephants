//
//  ReservationList.h
//  HouseOfMeetingElephants
//
//  Created by Stolniceanu Stefan on 11/11/14.
//  Copyright (c) 2014 Stefan Stolniceanu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Booking.h"
#import "PassDataProtocol.h"
#import "RoomList.h"
#import "ProjectList.h"

@interface BookingList : NSObject



@property (nonatomic, strong) NSMutableArray *bookings;
@property (nonatomic, weak) id<PassBookingsDelegate>delegate;

-(void)fetchDataForBookingsFromRoomList:(RoomList *)roomList andFromProjectList:(ProjectList *)projectList;
-(void)addBooking:(Booking *)booking;
-(void)deleteBooking:(Booking *)booking;
-(void)updateBooking:(Booking *)booking;

@end
