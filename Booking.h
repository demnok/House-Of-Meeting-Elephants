//
//  Reservation.h
//  HouseOfMeetingElephants
//
//  Created by Stolniceanu Stefan on 04/11/14.
//  Copyright (c) 2014 Stefan Stolniceanu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Room.h"
#import "Project.h"

@interface Booking : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) Room *room;
@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, strong) NSDate *endDate;
@property (nonatomic, strong) Project *project;
@property (nonatomic, getter=isRecurrent) BOOL recurrent;
@property (nonatomic, strong) NSString *bookingID;

@property (nonatomic, readonly) NSString *intervalOfTime;

- (instancetype)initWithBookingName:(NSString *)name
                       bookingRoom:(Room *)room
                  bookingStartDate:(NSDate *)startDate
                    bookingEndDate:(NSDate *)endDate
                   bookedByProject:(Project *)project
                        recurrency:(BOOL)isRecurrent;

@end
