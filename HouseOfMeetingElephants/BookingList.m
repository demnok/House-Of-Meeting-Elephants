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
    NSString *host;
    NSString *pathByID;
    AFHTTPRequestOperationManager *manager;
}

#pragma mark - Initialisation

- (instancetype)init {
    
    if (self = [super init]) {
        [self initHost];
        [self initManager];
    }
    
    return self;
}

- (void)initHost {
    host = [[NSString alloc] init];
    host = @"http://localhost:8001/reservations/";
}

- (void)initManager {
    manager = [AFHTTPRequestOperationManager manager];
}

#pragma mark - Helper methods

- (NSString *)merge:(NSString *)firstString with:(NSString *)secondString {
    
    NSMutableString *result = [firstString mutableCopy];
    [result appendString:[secondString mutableCopy]];
    
    return [result copy];
}

- (NSString *)toString:(id)object {
   
    NSDictionary *obj = (NSDictionary *)object;
    NSString *str = [NSString stringWithFormat:@"%@", obj];
    
    return str;
}

#pragma mark - Server communication related methods

-(void)fetchDataForBookingsFromRoomList:(RoomList *)roomList
                     andFromProjectList:(ProjectList *)projectList{
    
    __block NSMutableArray *bookingsToPass = [NSMutableArray array];
    __block Booking *bk = [[Booking alloc] init];
    
    [manager GET:host
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
    
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'zzz'Z'";
        
        NSMutableArray *bookings = (NSMutableArray *)responseObject[@"reservations"];
    
        [bookings enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            NSDictionary *object = (NSDictionary *)obj;
            
            NSString *roomID = [NSString alloc];
            NSString *projectID = [NSString alloc];
            
            roomID = [self toString:object[@"meetingRoom"]];
            projectID = [self toString:object[@"project"]];

            bk.name = [self toString:object[@"meetingName"]];

            bk.startDate = [dateFormatter dateFromString:object[@"startDate"]];
            bk.endDate = [dateFormatter dateFromString:object[@"endDate"]];
            
            bk.room = [self searchForRoomWithID:roomID inRoomList:roomList];
            bk.room.roomID = roomID;

            bk.project = [self searchForProjectWithID:projectID inProjectList:projectList];
            bk.project.projectID = projectID;
            
            bk.recurrent = [object[@"isRecurrent"] boolValue];
            
            bk.bookingID = object[@"_id"];
            
            [bookingsToPass addObject:bk];
        }];
                
        self.bookings = bookingsToPass;
        [self.delegate passData:bookingsToPass];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
}



-(void)addBooking:(Booking *)booking {
    
    NSDictionary *bookingToSend = @{@"meetingName": booking.name,
                                    @"meetingRoom": booking.room.roomID,
                                    @"startDate": booking.startDate,
                                    @"endDate": booking.endDate,
                                    @"project": booking.project.projectID,
                                    @"isRecurrent": [NSString stringWithFormat:@"%@",(booking.isRecurrent ? @"true" : @"false")]};
    
    [manager POST:host parameters:bookingToSend success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        booking.bookingID = [self toString:responseObject[@"reservation"][@"_id"]];
        
        [self.bookings addObject:booking];
        
        [self.delegate passData:self.bookings];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
    
}

-(void)updateBooking:(Booking *)booking {

    NSDictionary *bookingToSend = @{@"meetingName": booking.name,
                                   @"meetingRoom": booking.room.roomID,
                                   @"startDate": booking.startDate,
                                   @"endDate": booking.endDate,
                                   @"project": booking.project.projectID,
                                   @"isRecurrent": [NSString stringWithFormat:@"%@",(booking.isRecurrent ? @"true" : @"false")]};
    
    pathByID = [self merge:host with:booking.bookingID];
    
    [manager PUT:pathByID
      parameters:bookingToSend
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self.delegate passData:self.bookings];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
}

-(void)deleteBooking:(Booking *)booking {

    pathByID = [self merge:host with:booking.bookingID];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager DELETE:pathByID
         parameters:nil
            success:^(AFHTTPRequestOperation *operation, id responseObject) {
       
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
        
        NSString *string = [self toString:project.projectID];
        
        if([string isEqualToString:projectID]) {
            sentProject = project;
            
            (*stop) = YES;
        }
    }];
    
    return sentProject;
}

@end
