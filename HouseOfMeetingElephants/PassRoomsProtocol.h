//
//  PassRoomsProtocol.h
//  HouseOfMeetingElephants
//
//  Created by Stolniceanu Stefan on 28/11/14.
//  Copyright (c) 2014 Stefan Stolniceanu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NSMutableArray;
@class Room;

@protocol PassRoomsProtocol <NSObject>

-(void)passRooms:(NSMutableArray *)rooms;

@end
