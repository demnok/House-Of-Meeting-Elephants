//
//  ProjectList.h
//  HouseOfMeetingElephants
//
//  Created by Stolniceanu Stefan on 11/11/14.
//  Copyright (c) 2014 Stefan Stolniceanu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Project.h"
#import "PassProjectsProtocol.h"

@interface ProjectList : NSObject 

@property (nonatomic, strong) NSMutableArray *projects;

@property (nonatomic, weak) id<PassProjectsProtocol>delegate;

-(void)fetchProjects;
-(void)addProject:(Project *)project;
-(void)deleteProject:(Project *)project;
-(void)updateProject:(Project *)project;

@end
