//
//  Room.m
//  HouseOfMeetingElephants
//
//  Created by Stolniceanu Stefan on 04/11/14.
//  Copyright (c) 2014 Stefan Stolniceanu. All rights reserved.
//

#import "Room.h"

@implementation Room

- (instancetype)initWithRoomName:(NSString *)roomName {
    self = [super init];
    if(self) {
        self.name = roomName;
    }
    
    return self;
}

@end
