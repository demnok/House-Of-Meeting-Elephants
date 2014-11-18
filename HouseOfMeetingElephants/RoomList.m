//
//  RoomList.m
//  HouseOfMeetingElephants
//
//  Created by Stolniceanu Stefan on 11/11/14.
//  Copyright (c) 2014 Stefan Stolniceanu. All rights reserved.
//

#import "RoomList.h"
#import "Room.h"
#import "AFNetworking.h"

@implementation RoomList

+ (RoomList *)sharedInstance {
    
    static RoomList *_roomList = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _roomList = [[RoomList alloc] init];
    });
    
    return _roomList;
}

- (NSMutableArray *)rooms {
    
    if(!_rooms) {
        _rooms = [NSMutableArray array];
        
        Room *testRoomOne = [[Room alloc] initWithRoomName:@"Room number one"];
        [_rooms addObject:testRoomOne];
        
        Room *testRoomTwo = [[Room alloc] initWithRoomName:@"Room number two"];
        [_rooms addObject:testRoomTwo];
        
        Room *testRoomThree = [[Room alloc] initWithRoomName:@"Room number three"];
        [_rooms addObject:testRoomThree];
    }
    
    return _rooms;
}

@end
