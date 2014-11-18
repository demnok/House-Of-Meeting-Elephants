//
//  Room.h
//  HouseOfMeetingElephants
//
//  Created by Stolniceanu Stefan on 04/11/14.
//  Copyright (c) 2014 Stefan Stolniceanu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Room : NSObject

@property (nonatomic, strong) NSString *name;

- (instancetype)initWithRoomName:(NSString *)name;

@end
