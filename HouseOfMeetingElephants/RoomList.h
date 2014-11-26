//
//  RoomList.h
//  HouseOfMeetingElephants
//
//  Created by Stolniceanu Stefan on 11/11/14.
//  Copyright (c) 2014 Stefan Stolniceanu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SingletonProtocol.h"
#import "PassDataProtocol.h"
#import "Room.h"

@interface RoomList : NSObject <SingletonProtocol>

@property (nonatomic, strong) NSMutableArray *rooms;
@property (nonatomic, weak) id<PassDataProtocol> delegate;

- (void)fetchRooms;
- (void)deleteRoom:(Room *)room;
- (void)addRoom:(Room *)room;

@end
