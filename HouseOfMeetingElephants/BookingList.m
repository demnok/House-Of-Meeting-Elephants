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

#pragma mark - Host setting method

-(NSString *)host{
    NSString *host = [[NSString alloc] init];
    host = @"http://192.168.0.199:8001/reservations/";
    
    return host;
}

#pragma mark - Server communication related methods

-(void)fetchDataForBookingsFromRoomList:(RoomList *)roomList
                     andFromProjectList:(ProjectList *)projectList{
    
    __block NSMutableArray *bookingsToPass = [NSMutableArray array];
    __block NSString *name;
    __block NSDate *startDate;
    __block NSDate *endDate;
    __block Room *room;
    __block Project *project;
    __block BOOL recurrency;
    __block NSString *roomID;
    __block NSString *projectID;
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:[self host] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
    
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'zzz'Z'";
        
        NSMutableArray *bookings = (NSMutableArray *)responseObject[@"reservations"];
    
        [bookings enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            NSDictionary *object = (NSDictionary *)obj;
            
            roomID = [NSString stringWithFormat:@"%@",object[@"meetingRoom"]];
            projectID = [NSString stringWithFormat:@"%@",object[@"project"]];
            
            name = object[@"meetingName"];
            startDate = [dateFormatter dateFromString:object[@"startDate"]];
            endDate = [dateFormatter dateFromString:object[@"endDate"]];
            room = [self searchForRoomWithID:roomID inRoomList:roomList];
            project = [self searchForProjectWithID:projectID inProjectList:projectList];
            recurrency = [object[@"isRecurrent"] boolValue];
            
            Booking *addedBooking = [[Booking alloc] initWithBookingName:name
                                                             bookingRoom:room
                                                        bookingStartDate:startDate
                                                          bookingEndDate:endDate
                                                         bookedByProject:project
                                                              recurrency:recurrency];
            
            addedBooking.bookingID = object[@"_id"];
            
            [bookingsToPass addObject:addedBooking];
        }];
                
        self.bookings = bookingsToPass;
        [self.delegate passData:bookingsToPass];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
}



-(void)addBooking:(Booking *)booking {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary *bookingToSend = @{@"meetingName": booking.name,
                                    @"meetingRoom": booking.room.roomID,
                                    @"startDate": booking.startDate,
                                    @"endDate": booking.endDate,
                                    @"project": booking.project.projectID,
                                    @"isRecurrent": [NSString stringWithFormat:@"%@",(booking.isRecurrent ? @"true" : @"false")]};
    
    [manager POST:[self host] parameters:bookingToSend success:^(AFHTTPRequestOperation *operation, id responseObject) {
       
        NSDictionary *response = (NSDictionary *)responseObject[@"reservation"][@"_id"];
        
        booking.bookingID = [NSString stringWithFormat:@"%@", response ];
        
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
    
    [manager PUT: [NSString stringWithFormat:@"%@%@", [self host],booking.bookingID] parameters:bookingToSend success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self.delegate passData:self.bookings];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
}

-(void)deleteBooking:(Booking *)booking {

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *deletePath = [NSString stringWithFormat:@"%@%@", [self host], booking.bookingID];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager DELETE:deletePath parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
       
        [self.bookings removeObject:booking];
        
        [self.delegate passData:self.bookings];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

#pragma mark - Searching within lists methods

-(Room *)searchForRoomWithID:(NSString *)roomID
                  inRoomList:(RoomList *)roomList {
    
    __block Room *sentRoom = [[Room alloc] initWithRoomName:@"no room"];
    sentRoom.roomID =@"No room";
    
    [roomList.rooms enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        Room *room = (Room *)obj;
        
        if([room.roomID isEqualToString:roomID]) {
            sentRoom = room;
            
            (*stop) = YES;
        }
    }];
    
    return sentRoom;
}

-(Project *)searchForProjectWithID:(NSString *)projectID
                     inProjectList:(ProjectList *)projectList{
    
    __block Project *sentProject = [[Project alloc] initWithName:@"no project"
                                                        andColor:[UIColor redColor]];
    sentProject.projectID = @"No project";
    
    [projectList.projects enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        Project *project = (Project *)obj;
        
        NSString *string = [NSString stringWithFormat:@"%@", project.projectID];
        
        if([string isEqualToString:projectID]) {
            sentProject = project;
            
            (*stop) = YES;
        }
    }];
    
    return sentProject;
}

@end
