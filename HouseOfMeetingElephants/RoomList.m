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

-(void)fetchRooms {
    
    NSMutableArray *roomsToPass = [NSMutableArray array];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:@"http://localhost:8001/room" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        for (NSDictionary *individualObject in responseObject) {
            
            Room *roomToAdd = [[Room alloc] init];
            
            roomToAdd.name = individualObject[@"name"];
            roomToAdd.roomID = [NSString stringWithFormat:@"%@",individualObject[@"id"]];
            [roomsToPass addObject:roomToAdd];
            NSLog(@"%@",roomToAdd.name);
        }
        
        self.rooms = roomsToPass;
        [self.delegate passRooms:roomsToPass];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

-(void)deleteRoom:(Room *)room {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *deletePath = [[NSString alloc] initWithFormat:@"%@%@",@"http://localhost:8001/room/",room.roomID];
    
    [manager DELETE:deletePath parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self.rooms removeObject:room];
        
        [self.delegate passRooms:self.rooms];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];

    
}

-(void)addRoom:(Room *)room {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary *roomToSend = @{@"name" : room.name};
    
    [manager POST:@"http://localhost:8001/room" parameters:roomToSend success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
    
    [manager PUT:[NSString stringWithFormat:@"%@%@",@"http://localhost:8001/room/",room.roomID]
      parameters:roomToSend
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             
        [self.delegate passRooms:self.rooms];
    }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             
    }];
    
}

@end
