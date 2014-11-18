//
//  RoomTableViewCell.h
//  HouseOfMeetingElephants
//
//  Created by Stolniceanu Stefan on 04/11/14.
//  Copyright (c) 2014 Stefan Stolniceanu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Room.h"

@interface RoomTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *roomNameLabel;

@property (nonatomic, strong) Room *currentRoom;

@end
