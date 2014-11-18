//
//  CreateRoomViewControllerDelegate.h
//  HouseOfMeetingElephants
//
//  Created by Stolniceanu Stefan on 14/11/14.
//  Copyright (c) 2014 Stefan Stolniceanu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CreateRoomTableViewController;
@class Room;

@protocol CreateRoomViewControllerDelegate <NSObject>

-(void)CreateRoomTableViewControllerDelegateDidCancel:(CreateRoomTableViewController *)vc;
-(void)CreateRoomTableViewControllerDelegateDidSave:(CreateRoomTableViewController *)vc room:(Room *)room;

@end
