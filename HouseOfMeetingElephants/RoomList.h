//
//  RoomList.h
//  HouseOfMeetingElephants
//
//  Created by Stolniceanu Stefan on 11/11/14.
//  Copyright (c) 2014 Stefan Stolniceanu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PassRoomsProtocol.h"
#import "Room.h"

@interface RoomList : NSObject

@property (nonatomic, strong) NSMutableArray *rooms;
@property (nonatomic, weak) id<PassRoomsProtocol> delegate;

- (void)fetchRooms;
- (void)deleteRoom:(Room *)room;
- (void)addRoom:(Room *)room;
- (void)updateRoom:(Room *)room;
@end
