//
//  RoomTableViewController.h
//  HouseOfMeetingElephants
//
//  Created by Stolniceanu Stefan on 04/11/14.
//  Copyright (c) 2014 Stefan Stolniceanu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CreateRoomTableViewController.h"
#import "RoomTableViewCell.h"
#import "PassDataProtocol.h"

@interface RoomTableViewController : UITableViewController <CreateRoomViewControllerDelegate, PassDataProtocol>

@end
