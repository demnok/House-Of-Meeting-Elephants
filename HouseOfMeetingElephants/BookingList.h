//
//  ReservationList.h
//  HouseOfMeetingElephants
//
//  Created by Stolniceanu Stefan on 11/11/14.
//  Copyright (c) 2014 Stefan Stolniceanu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SingletonProtocol.h"
#import "Booking.h"
#import "PassDataProtocol.h"

@interface BookingList : NSObject <SingletonProtocol>

@property (nonatomic, strong) NSMutableArray *bookings;
@property (nonatomic, weak) id<PassDataProtocol>delegate;

-(void)fetchData;

@end
