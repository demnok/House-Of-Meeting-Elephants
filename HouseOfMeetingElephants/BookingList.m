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

-(void)fetchDataForBookingsFromRoomList:(RoomList *)roomList andFromProjectList:(ProjectList *)projectList{
    NSMutableArray *bookingsToPass = [NSMutableArray array];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:@"http://localhost:8001/reservations" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
    
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'zzz'Z'";
        
        for(NSDictionary *individualObject in responseObject[@"reservations"]) {
            
            NSDate *startDate = [[NSDate alloc] init];
            NSDate *endDate = [[NSDate alloc] init];
            
            startDate = [dateFormatter dateFromString:individualObject[@"startDate"]];
            endDate = [dateFormatter dateFromString:individualObject[@"endDate"]];
            
            Booking *bookingToAdd = [[Booking alloc] initWithBookingName:individualObject[@"meetingName"]
                                                             bookingRoom:[self searchForRoomWithID:individualObject[@"meetingRoom"] inRoomList:roomList]
                                                        bookingStartDate:startDate
                                                          bookingEndDate:endDate
                                                         bookedByProject:[self searchForProjectWithID:individualObject[@"project"] inProjectList:projectList]
                                                              recurrency:[individualObject[@"isRecurrent"] boolValue]];
            
            bookingToAdd.bookingID = individualObject[@"_id"];
            
            [bookingsToPass addObject:bookingToAdd];
            }
        
        
        
        self.bookings = bookingsToPass;
        [self.delegate passData:bookingsToPass];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
}

-(Room *)searchForRoomWithID:(NSString *)roomID
                  inRoomList:(RoomList *)roomList {
    
    for(Room *room in roomList.rooms) {
        if([room.roomID isEqualToString:roomID]) {
            return room;
        }
    }
    
    Room *errorRoom = [[Room alloc] initWithRoomName:@"no room"];
    errorRoom.roomID =@"No room";
    
    return errorRoom;
}

-(Project *)searchForProjectWithID:(NSString *)projectID
                     inProjectList:(ProjectList *)projectList{
    
    for (Project *project in projectList.projects) {
        if ([project.projectID isEqualToString:projectID]) {
            return project;
        }
    }
    
    Project *errorProject = [[Project alloc] initWithName:@"no project" andColor:[UIColor redColor]];
    errorProject.projectID = @"No project";
    
    return errorProject;
}

-(void)addBooking:(Booking *)booking {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary *bookingToSend = @{@"meetingName": booking.name,
                                    @"meetingRoom": booking.room.roomID,
                                    @"startDate": booking.startDate,
                                    @"endDate": booking.endDate,
                                    @"project": booking.project.projectID,
                                    @"isRecurrent": [NSString stringWithFormat:@"%@",(booking.isRecurrent ? @"true" : @"false")]};
    
    [manager POST:@"http://localhost:8001/reservations" parameters:bookingToSend success:^(AFHTTPRequestOperation *operation, id responseObject) {
       
        booking.bookingID = [NSString stringWithFormat:@"%@", (NSDictionary *)responseObject[@"reservation"][@"_id"]];
        
        [self.bookings addObject:booking];
        
        [self.delegate passData:self.bookings];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
    
}

-(void)updateBooking:(Booking *)booking {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary *bookingToSend = @{@"meetingName": booking.name,
                                   @"meetingRoom": booking.room.roomID,
                                   @"startDate": booking.startDate,
                                   @"endDate": booking.endDate,
                                   @"project": booking.project.projectID,
                                   @"isRecurrent": [NSString stringWithFormat:@"%@",(booking.isRecurrent ? @"true" : @"false")]};
    
    [manager PUT: [NSString stringWithFormat:@"%@%@", @"http://localhost:8001/reservations/",booking.bookingID] parameters:bookingToSend success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.delegate passData:self.bookings];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
}

-(void)deleteBooking:(Booking *)booking {

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *targetServer = @"http://localhost:8001/reservations/";
    NSString *bookingToBeRemovedWithID = booking.bookingID;
    
    NSString *deletePath = [NSString stringWithFormat:@"%@%@", targetServer, bookingToBeRemovedWithID];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager DELETE:deletePath parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
       
        [self.bookings removeObject:booking];
        
        [self.delegate passData:self.bookings];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

@end
