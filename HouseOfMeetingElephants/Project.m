//
//  Project.m
//  HouseOfMeetingElephants
//
//  Created by Stolniceanu Stefan on 22/12/14.
//  Copyright (c) 2014 Stefan Stolniceanu. All rights reserved.
//

#import "Project.h"

@implementation Project

-(instancetype)initWithName:(NSString *)name andColor:(UIColor *)color {
    self = [super init];
    if (self) {
        self.name = name;
        self.color = color;
    }
    
    return self;
}

@end
