//
//  RoomDetailTableViewControllerDelegate.h
//  HouseOfMeetingElephants
//
//  Created by Stolniceanu Stefan on 08/12/14.
//  Copyright (c) 2014 Stefan Stolniceanu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RoomDetailTableViewController;
@class Room;

@protocol RoomDetailTableViewControllerDelegate <NSObject>

-(void)RoomDetailTableViewControllerDelegateDidGoBack:(RoomDetailTableViewController *)vc;
-(void)RoomDetailTableViewControllerDelegateDidUpdate:(RoomDetailTableViewController *)vc withRoom:(Room *)room;

@end
