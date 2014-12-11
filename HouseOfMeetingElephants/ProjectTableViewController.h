//
//  ProjectTableViewController.h
//  HouseOfMeetingElephants
//
//  Created by Stolniceanu Stefan on 04/11/14.
//  Copyright (c) 2014 Stefan Stolniceanu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CreateProjectTableViewController.h"
#import "ProjectTableViewCell.h"
#import "PassProjectsProtocol.h"
#import "ProjectDetailTableViewController.h"

@interface ProjectTableViewController : UITableViewController <CreateProjectViewControllerDelegate, PassProjectsProtocol, ProjectDetailTableViewControllerDelegate>


@end
