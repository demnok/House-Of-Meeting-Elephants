//
//  ProjectDetailTableViewControllerDelegate.h
//  HouseOfMeetingElephants
//
//  Created by Stolniceanu Stefan on 09/12/14.
//  Copyright (c) 2014 Stefan Stolniceanu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ProjectDetailTableViewController;
@class Project;

@protocol ProjectDetailTableViewControllerDelegate <NSObject>

-(void)ProjectDetailTableViewControllerDelegateDidGoBack:(ProjectDetailTableViewController *)vc;
-(void)ProjectDetailTableViewControllerDelegateDidUpdate:(ProjectDetailTableViewController *)vc withProject:(Project *)project;

@end
