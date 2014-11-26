//
//  ChooseRoomViewController.h
//  HouseOfMeetingElephants
//
//  Created by Stolniceanu Stefan on 10/11/14.
//  Copyright (c) 2014 Stefan Stolniceanu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CreateRoomTableViewController.h"
#import "ChooseRoomViewControllerDelegate.h"
#import "PassDataProtocol.h"

@interface ChooseRoomViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate, CreateRoomViewControllerDelegate, PassDataProtocol>

@property(nonatomic, strong) NSMutableArray *roomPickerSource;
@property (strong, nonatomic) IBOutlet UIPickerView *roomPicker;

@property(nonatomic, weak) id<ChooseRoomViewControllerDelegate>delegate;


- (IBAction)cancelChoiceOfRoom:(id)sender;
- (IBAction)saveChoiceOfRoom:(id)sender;

@end
