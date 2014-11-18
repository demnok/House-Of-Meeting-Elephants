//
//  CreateProjectViewControllerDelegate.h
//  HouseOfMeetingElephants
//
//  Created by Stolniceanu Stefan on 14/11/14.
//  Copyright (c) 2014 Stefan Stolniceanu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CreateProjectTableViewController;
@class Project;

@protocol CreateProjectViewControllerDelegate <NSObject>

-(void) CreateProjectTableViewControllerDelegateDidCancel:(CreateProjectTableViewController *)vc;
-(void) CreateProjectTableViewControllerDelegateDidSave:(CreateProjectTableViewController *)vc project:(Project *)project;

@end
