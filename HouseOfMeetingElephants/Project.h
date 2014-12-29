//
//  Project.h
//  HouseOfMeetingElephants
//
//  Created by Stolniceanu Stefan on 22/12/14.
//  Copyright (c) 2014 Stefan Stolniceanu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Project : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, strong) NSString *projectID;

- (instancetype)initWithName:(NSString *)project andColor:(UIColor *)color;

@end
