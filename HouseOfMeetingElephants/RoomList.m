 //
//  RoomList.m
//  HouseOfMeetingElephants
//
//  Created by Stolniceanu Stefan on 11/11/14.
//  Copyright (c) 2014 Stefan Stolniceanu. All rights reserved.
//

#import "RoomList.h"
#import "AFNetworking.h"

@implementation RoomList
{
    NSString *_host;
    NSString *_pathByID;
    AFHTTPRequestOperationManager *_manager;
    NSDictionary *_roomToSend;
}

#pragma mark - Initialisation

- (instancetype)init {
    
    if (self = [super init]) {
        [self setupHost];
        [self setupManager];
    }
    
    return self;
}

- (void)setupHost {
    _host = [[NSString alloc] init];
    _host = @"http://localhost:8001/room/";
}

- (void)setupManager {
    _manager = [AFHTTPRequestOperationManager manager];
}

#pragma mark - Server communication related methods

-(void)fetchRooms {
    
    __block NSMutableArray *roomsToPass = [NSMutableArray array];
    
    [_manager GET:_host
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSMutableArray *rooms = (NSMutableArray *)responseObject;
        
        [rooms enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            NSDictionary *object = (NSDictionary *)obj;
            
            Room *roomToAdd = [[Room alloc] init];
            
            roomToAdd.name = [object[@"name"] description];
            
            NSString *roomID = [NSString alloc];
            
            roomID = [object[@"id"] description];
            roomToAdd.roomID = roomID;
            
            [roomsToPass addObject:roomToAdd];
        }];
                
        self.rooms = roomsToPass;
        [self.delegate passRooms:roomsToPass];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

-(void)deleteRoom:(Room *)room {

    _pathByID = [_host stringByAppendingString:room.roomID];
    
    [_manager DELETE:_pathByID
         parameters:nil
            success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self.rooms removeObject:room];
        
        [self.delegate passRooms:self.rooms];
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];

    
}

-(void)addRoom:(Room *)room {

    _roomToSend = @{@"name" : room.name};
  
    [_manager POST:_host
       parameters:_roomToSend
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        room.roomID = [responseObject[@"id"] description];
        [self.rooms addObject:room];
        
        [self.delegate passRooms:self.rooms];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

-(void)updateRoom:(Room *)room {
    
    _pathByID = [_host stringByAppendingString:room.roomID];
    
    _roomToSend = @{@"name" : room.name};
  
    [_manager PUT:_pathByID
      parameters:_roomToSend
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             
        [self.delegate passRooms:self.rooms];
    }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             
    }];
    
}

@end
