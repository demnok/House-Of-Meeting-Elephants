//
//  RoomDetailTableViewController.h
//  HouseOfMeetingElephants
//
//  Created by Stolniceanu Stefan on 08/12/14.
//  Copyright (c) 2014 Stefan Stolniceanu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RoomDetailTableViewControllerDelegate.h"

@interface RoomDetailTableViewController : UITableViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *roomNameTextField;

@property (weak, nonatomic) id<RoomDetailTableViewControllerDelegate>delegate;

@property (strong, nonatomic) Room *detailRoom;

- (IBAction)updateRoom:(id)sender;
- (IBAction)goBack:(id)sender;

@end
