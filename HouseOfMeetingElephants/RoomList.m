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

+ (RoomList *)sharedInstance {
    
    static RoomList *_roomList = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _roomList = [[RoomList alloc] init];
    });
    
    return _roomList;
    
    
}

- (void)fetchRooms {
    
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
        [self.delegate passData:roomsToPass];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

-(void)deleteRoom:(Room *)room {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager DELETE:[NSString stringWithFormat:@"%@%@",@"http://localhost:8001/room/", room.roomID] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self.rooms removeObject:room];
        
        [self.delegate passData:self.rooms];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];

    
}

-(void)addRoom:(Room *)room {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary *roomToSend = @{@"name" : room.name};
    
    [manager POST:@"http://localhost:8001/room" parameters:roomToSend success:^(AFHTTPRequestOperation *operation, id responseObject) {
        room.roomID = [NSString stringWithFormat:@"%@",(NSDictionary *)responseObject[@"id"]];
        [self.rooms addObject:room];
        
        [self.delegate passData:self.rooms];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];

}

@end
