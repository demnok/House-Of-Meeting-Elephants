//
//  RoomList.h
//  HouseOfMeetingElephants
//
//  Created by Stolniceanu Stefan on 11/11/14.
//  Copyright (c) 2014 Stefan Stolniceanu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SingletonProtocol.h"


@interface RoomList : NSObject <SingletonProtocol>

@property (nonatomic, strong) NSMutableArray *rooms;
@end
