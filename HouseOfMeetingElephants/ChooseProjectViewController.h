//
//  ChooseProjectViewController.h
//  HouseOfMeetingElephants
//
//  Created by Stolniceanu Stefan on 12/11/14.
//  Copyright (c) 2014 Stefan Stolniceanu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CreateProjectTableViewController.h"
#import "ChooseProjectViewControllerDelegate.h"
#import "PassProjectsProtocol.h"

@interface ChooseProjectViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate, CreateProjectViewControllerDelegate, PassProjectsProtocol>

@property (strong, nonatomic) NSMutableArray *projectPickerSource;
@property (weak, nonatomic) IBOutlet UIPickerView *projectPicker;

@property (nonatomic, weak) id<ChooseProjectViewControllerDelegate>delegate;

- (IBAction)saveChoiceOfProject:(id)sender;
- (IBAction)cancelChoiceOfProject:(id)sender;

@end
