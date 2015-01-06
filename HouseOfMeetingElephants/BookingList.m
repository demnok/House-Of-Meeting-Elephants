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
{
    NSString *_host;
    NSString *_pathByID;
    AFHTTPRequestOperationManager *_manager;
    NSDateFormatter *_dateFormatter;
    NSDictionary *_bookingToSend;
}

#pragma mark - Initialisation

- (instancetype)init {
    
    if (self = [super init]) {
        [self setupHost];
        [self setupManager];
        [self setupDateFormatter];
    }
    
    return self;
}

- (void)setupHost {
    _host = [[NSString alloc] init];
    _host = @"http://localhost:8001/reservations/";
}

- (void)setupManager {
    _manager = [AFHTTPRequestOperationManager manager];
}

- (void)setupDateFormatter {
    _dateFormatter = [[NSDateFormatter alloc] init];
    _dateFormatter.dateFormat = @"yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'zzz'Z'";
}

#pragma mark - Generic helper methods 
//TODO: De implementat cu categorii

- (NSString *)merge:(NSString *)firstString
               with:(NSString *)secondString {
    
    NSMutableString *result = [firstString mutableCopy];
    [result appendString:[secondString mutableCopy]];
    
    return [result copy];
}

#pragma mark - Class helper method

- (NSDate *)dateFrom:(id)object
{
    NSString *obj = [NSString stringWithFormat:@"%@", object];
    
    return [_dateFormatter dateFromString:obj];
}

#pragma mark - Server communication related methods

-(void)fetchDataForBookingsFromRoomList:(RoomList *)roomList
                     andFromProjectList:(ProjectList *)projectList{
    
    __block NSMutableArray *bookingsToPass = [NSMutableArray array];
    __block Booking *bk = [[Booking alloc] init];
    
    [_manager GET:_host
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSMutableArray *bookings = (NSMutableArray *)responseObject[@"reservations"];
    
        [bookings enumerateObjectsUsingBlock:^(NSDictionary *bookingDict, NSUInteger idx, BOOL *stop)
        {
            NSString *roomID = nil;
            NSString *projectID = nil;

            roomID = [bookingDict[@"meetingRoom"] description];
            projectID = [bookingDict[@"project"] description];

            bk.name = [bookingDict[@"meetingName"] description];

            bk.startDate = [self dateFrom:bookingDict[@"startDate"]];
            bk.endDate = [self dateFrom:bookingDict[@"endDate"]];
            
            bk.room = [self searchForRoomWithID:roomID inRoomList:roomList];
            bk.room.roomID = roomID;

            bk.project = [self searchForProjectWithID:projectID inProjectList:projectList];
            bk.project.projectID = projectID;
            
            bk.recurrent = [bookingDict[@"isRecurrent"] boolValue];
            
            bk.bookingID = [bookingDict[@"_id"] description];
            
            [bookingsToPass addObject:bk];
        }];
                
        self.bookings = bookingsToPass;
        [self.delegate passData:bookingsToPass];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
}



-(void)addBooking:(Booking *)booking {
    
    _bookingToSend = @{@"meetingName": booking.name,
                                    @"meetingRoom": booking.room.roomID,
                                    @"startDate": booking.startDate,
                                    @"endDate": booking.endDate,
                                    @"project": booking.project.projectID,
                                    @"isRecurrent": [NSString stringWithFormat:@"%@",(booking.isRecurrent ? @"true" : @"false")]};
    
    [_manager POST:_host
       parameters:_bookingToSend
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        booking.bookingID = [responseObject[@"reservation"][@"_id"] description];
        
        [self.bookings addObject:booking];
        
        [self.delegate passData:self.bookings];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
    
}

-(void)updateBooking:(Booking *)booking {

    _bookingToSend = @{@"meetingName": booking.name,
                      @"meetingRoom": booking.room.roomID,
                      @"startDate": booking.startDate,
                      @"endDate": booking.endDate,
                      @"project": booking.project.projectID,
                      @"isRecurrent": [NSString stringWithFormat:@"%@",(booking.isRecurrent ? @"true" : @"false")]};
    
    _pathByID = [_host stringByAppendingString:booking.bookingID];
    
    [_manager PUT:_pathByID
      parameters:_bookingToSend
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self.delegate passData:self.bookings];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
}

-(void)deleteBooking:(Booking *)booking {
    
    _pathByID = [_host stringByAppendingString:booking.bookingID];
    
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [_manager DELETE:_pathByID
         parameters:nil
            success:^(AFHTTPRequestOperation *operation, id responseObject) {
       
        [self.bookings removeObject:booking];
        
        [self.delegate passData:self.bookings];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

#pragma mark - Searching within list methods

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
        
        NSString *string = [project.projectID description];
        
        if([string isEqualToString:projectID]) {
            sentProject = project;
            
            (*stop) = YES;
        }
    }];
    
    return sentProject;
}

@end
