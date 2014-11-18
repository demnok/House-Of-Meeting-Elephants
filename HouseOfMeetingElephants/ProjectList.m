//
//  ProjectList.m
//  HouseOfMeetingElephants
//
//  Created by Stolniceanu Stefan on 11/11/14.
//  Copyright (c) 2014 Stefan Stolniceanu. All rights reserved.
//

#import "ProjectList.h"

@implementation ProjectList

+(ProjectList *)sharedInstance {
    
    static ProjectList *_projectList = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _projectList = [[ProjectList alloc] init];
    });
    
    return _projectList;
}

-(NSMutableArray *)projects {
    
    if(!_projects) {
        _projects = [NSMutableArray array];
        
        Project *testProjectOne = [[Project alloc] initWithName:@"Test project 1" andColor:[UIColor redColor]];
        [_projects addObject:testProjectOne];
        
        Project *testProjectTwo = [[Project alloc] initWithName:@"Test project 2" andColor:[UIColor blueColor]];
        [_projects addObject:testProjectTwo];
        
        Project *testProjectThree = [[Project alloc] initWithName:@"Test project 3" andColor:[UIColor greenColor]];
        [_projects addObject:testProjectThree];
    }
    
    return _projects;
}

@end
