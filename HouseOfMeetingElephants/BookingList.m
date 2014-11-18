//
//  ReservationList.m
//  HouseOfMeetingElephants
//
//  Created by Stolniceanu Stefan on 11/11/14.
//  Copyright (c) 2014 Stefan Stolniceanu. All rights reserved.
//

#import "BookingList.h"

@implementation BookingList

+(BookingList *)sharedInstance {
    
    static BookingList *_bookingList = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _bookingList = [[BookingList alloc] init];
    });
    
    return _bookingList;
}

-(NSMutableArray *)bookings {
    
    if (!_bookings) {
        _bookings = [NSMutableArray array];
        
        NSCalendar *calendar = [NSCalendar currentCalendar];
        
        NSDateComponents *firstSetComponents = [[NSDateComponents alloc] init];
        [firstSetComponents setYear:2014];
        [firstSetComponents setMonth:11];
        [firstSetComponents setDay:11];
        [firstSetComponents setHour:11];
        [firstSetComponents setMinute:0];
        [firstSetComponents setSecond:0];
        NSDate *firstDate = [calendar dateFromComponents:firstSetComponents];
        
        NSDateComponents *secondSetComponents = [[NSDateComponents alloc] init];
        [secondSetComponents setYear:2014];
        [secondSetComponents setMonth:11];
        [secondSetComponents setDay:11];
        [secondSetComponents setHour:12];
        [secondSetComponents setMinute:0];
        [secondSetComponents setSecond:0];
        NSDate *secondDate = [calendar dateFromComponents:secondSetComponents];

        
        Room *testRoomOne = [[Room alloc] initWithRoomName:@"Room1"];
        Project *testProjectOne = [[Project alloc] initWithName:@"Project1" andColor:[UIColor blueColor]];
        
        Booking *bookingOne = [[Booking alloc] initWithBookingName:@"Reservation1" bookingRoom:testRoomOne bookingStartDate:firstDate bookingEndDate:secondDate bookedByProject:testProjectOne recurrency:NO];
        [_bookings addObject:bookingOne];
        
    }
    
    return _bookings;
}

@end
