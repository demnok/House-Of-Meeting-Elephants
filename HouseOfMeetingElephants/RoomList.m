 //
//  RoomList.m
//  HouseOfMeetingElephants
//
//  Created by Stolniceanu Stefan on 11/11/14.
//  Copyright (c) 2014 Stefan Stolniceanu. All rights reserved.
//

#import "RoomList.h"
#import "AFNetworking.h"

@interface RoomList ()

@end

@implementation RoomList

#pragma mark - Host setter method

-(NSString *)host{
    NSString *host = [[NSString alloc] init];
    host = @"http://192.168.0.199:8001/room/";
    
    return host;
}

#pragma mark - Server communication related methods

-(void)fetchRooms {
    
    __block NSMutableArray *roomsToPass = [NSMutableArray array];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:[self host] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSMutableArray *rooms = (NSMutableArray *)responseObject;
        
        [rooms enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            NSDictionary *object = (NSDictionary *)obj;
            
            Room *roomToAdd = [[Room alloc] init];
            
            roomToAdd.name = [NSString stringWithFormat:@"%@", object[@"name"]];
            
            NSString *roomID = [NSString stringWithFormat:@"%@", object[@"id"]];
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
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *deletePath = [[NSString alloc] initWithFormat:@"%@%@",[self host],room.roomID];
    
    [manager DELETE:deletePath parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self.rooms removeObject:room];
        
        [self.delegate passRooms:self.rooms];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];

    
}

-(void)addRoom:(Room *)room {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary *roomToSend = @{@"name" : room.name};
    
    [manager POST:[self host] parameters:roomToSend success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        room.roomID = [NSString stringWithFormat:@"%@",(NSDictionary *)responseObject[@"id"]];
        [self.rooms addObject:room];
        
        [self.delegate passRooms:self.rooms];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

-(void)updateRoom:(Room *)room {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary *roomToSend = @{@"name" : room.name};
    
    [manager PUT:[NSString stringWithFormat:@"%@%@",[self host],room.roomID]
      parameters:roomToSend
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             
        [self.delegate passRooms:self.rooms];
    }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             
    }];
    
}

@end
