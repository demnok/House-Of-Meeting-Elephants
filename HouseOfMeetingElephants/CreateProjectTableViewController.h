//
//  CreateProjectTableViewController.h
//  HouseOfMeetingElephants
//
//  Created by Stolniceanu Stefan on 05/11/14.
//  Copyright (c) 2014 Stefan Stolniceanu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColorPickerViewController.h"
#import "CreateProjectViewControllerDelegate.h"
#import "ProjectList.h"

@interface CreateProjectTableViewController : UITableViewController <FCColorPickerViewControllerDelegate>

- (IBAction)cancelProject:(id)sender;
- (IBAction)saveProject:(id)sender;

@property (strong, nonatomic) UIColor *colorForProject;
@property (strong, nonatomic) IBOutlet UIView *colorDisplayer;

@property (weak, nonatomic) IBOutlet UITextField *projectNameTextField;

@property (weak, nonatomic) id<CreateProjectViewControllerDelegate> delegate;

@end
