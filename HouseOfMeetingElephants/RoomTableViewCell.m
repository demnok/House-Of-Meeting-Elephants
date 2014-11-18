//
//  RoomTableViewCell.m
//  HouseOfMeetingElephants
//
//  Created by Stolniceanu Stefan on 04/11/14.
//  Copyright (c) 2014 Stefan Stolniceanu. All rights reserved.
//

#import "RoomTableViewCell.h"

@implementation RoomTableViewCell

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)setCurrentRoom:(Room *)currentRoom {
    [self populateInterface:currentRoom];
}

-(void)populateInterface:(Room *)room {
    self.roomNameLabel.text = room.name;
}

@end
