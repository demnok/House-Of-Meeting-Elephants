//
//  CreateRoomTableViewController.h
//  HouseOfMeetingElephants
//
//  Created by Stolniceanu Stefan on 05/11/14.
//  Copyright (c) 2014 Stefan Stolniceanu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CreateRoomViewControllerDelegate.h"
#import "RoomList.h"

@interface CreateRoomTableViewController : UITableViewController <UITextViewDelegate, PassRoomsProtocol>

@property (nonatomic, weak) id<CreateRoomViewControllerDelegate> delegate;

- (IBAction)cancelRoom:(id)sender;
- (IBAction)saveRoom:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *roomNameTextField;

@end
