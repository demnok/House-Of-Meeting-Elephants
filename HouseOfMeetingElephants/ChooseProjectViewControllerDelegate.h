//
//  ChooseProjectViewControllerDelegate.h
//  HouseOfMeetingElephants
//
//  Created by Stolniceanu Stefan on 18/11/14.
//  Copyright (c) 2014 Stefan Stolniceanu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ChooseProjectViewController;
@class Project;

@protocol ChooseProjectViewControllerDelegate <NSObject>

-(void)ChooseProjectViewControllerDelegateDidCancel:(ChooseProjectViewController *)vc;
-(void)ChooseProjectViewControllerDelegateDidSave:(ChooseProjectViewController *)vc withProject:(Project *)project;

@end
