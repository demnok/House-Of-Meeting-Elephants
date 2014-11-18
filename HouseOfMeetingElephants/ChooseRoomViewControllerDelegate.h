//
//  ChooseRoomViewControllerDelegate.h
//  HouseOfMeetingElephants
//
//  Created by Stolniceanu Stefan on 18/11/14.
//  Copyright (c) 2014 Stefan Stolniceanu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ChooseRoomViewController;
@class Room;

@protocol ChooseRoomViewControllerDelegate <NSObject>

-(void)ChooseRoomViewControllerDelegateDidCancel: (ChooseRoomViewController *)vc;
-(void)ChooseRoomViewControllerDelegateDidSave:(ChooseRoomViewController *)vc withRoom:(Room *)room;

@end
