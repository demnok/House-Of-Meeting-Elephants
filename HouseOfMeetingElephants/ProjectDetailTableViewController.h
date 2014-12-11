//
//  ProjectDetailTableViewController.h
//  HouseOfMeetingElephants
//
//  Created by Stolniceanu Stefan on 09/12/14.
//  Copyright (c) 2014 Stefan Stolniceanu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColorPickerViewController.h"
#import "ProjectList.h"
#import "ProjectDetailTableViewControllerDelegate.h"

@interface ProjectDetailTableViewController : UITableViewController <FCColorPickerViewControllerDelegate>

- (IBAction)updateProject:(id)sender;
- (IBAction)goBack:(id)sender;

- (IBAction)chooseColor:(id)sender;

@property (strong, nonatomic) UIColor *color;
@property (strong, nonatomic) Project *detailProject;

@property (weak, nonatomic) IBOutlet UIView *colorDisplayer;
@property (weak, nonatomic) IBOutlet UITextField *projectNameTextField;

@property (weak, nonatomic) id<ProjectDetailTableViewControllerDelegate>delegate;

@end
