//
//  ReservationList.m
//  HouseOfMeetingElephants
//
//  Created by Stolniceanu Stefan on 11/11/14.
//  Copyright (c) 2014 Stefan Stolniceanu. All rights reserved.
//

#import "BookingList.h"
#import "AFNetworking.h"

@implementation BookingList

+(BookingList *)sharedInstance {
    
    static BookingList *_bookingList = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _bookingList = [[BookingList alloc] init];
    });
    
    return _bookingList;
}

-(void)fetchData {
    NSMutableArray *bookingsToPass = [NSMutableArray array];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:@"http://localhost:8001/reservations" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
    
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'zzz'Z'";
        
        for(NSDictionary *individualObject in responseObject[@"reservations"]) {
            
            Room *localRoom = [[Room alloc] initWithRoomName:@"Room"];
            
            Project *localProject = [[Project alloc] initWithName:@"project"
                                                         andColor:[UIColor blueColor]];
            
            NSDate *startDate = [[NSDate alloc] init];
            NSDate *endDate = [[NSDate alloc] init];
            
            startDate = [dateFormatter dateFromString:individualObject[@"startDate"]];
            endDate = [dateFormatter dateFromString:individualObject[@"endDate"]];
            
            Booking *bookingToAdd = [[Booking alloc] initWithBookingName:individualObject[@"meetingName"]
                                                             bookingRoom:localRoom
                                                        bookingStartDate:startDate
                                                          bookingEndDate:endDate
                                                         bookedByProject:localProject
                                                              recurrency:[individualObject[@"isRecurrent"] boolValue]];
            
            [bookingsToPass addObject:bookingToAdd];
            }
        
        self.bookings = bookingsToPass;
        [self.delegate passData:bookingsToPass];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
}

@end
