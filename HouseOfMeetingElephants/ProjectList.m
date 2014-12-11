//
//  ProjectList.m
//  HouseOfMeetingElephants
//
//  Created by Stolniceanu Stefan on 11/11/14.
//  Copyright (c) 2014 Stefan Stolniceanu. All rights reserved.
//

#import "ProjectList.h"
#import "AFNetworking.h"

@implementation ProjectList

-(void)fetchProjects {
    
    NSMutableArray *projectsToPass = [NSMutableArray array];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:@"http://localhost:8001/project" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        for (NSDictionary *individualObject in responseObject) {
            
            Project *projectToAdd = [[Project alloc] init];
            
            projectToAdd.name = individualObject[@"name"];
            projectToAdd.color = [self transformToColorFromHexString:individualObject[@"color"]];
            projectToAdd.projectID = [NSString stringWithFormat:@"%@",individualObject[@"id"]];
            
            [projectsToPass addObject:projectToAdd];
        }
        
        self.projects = projectsToPass;
        [self.delegate passProjects:projectsToPass];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
}

-(void)addProject:(Project *)project {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary *projectToSend = @{@"name": project.name,
                                    @"color": [self transformToStringFromColor:project.color]};
    
    [manager POST:@"http://localhost:8001/project" parameters:projectToSend success:^(AFHTTPRequestOperation *operation, id responseObject) {
       
        project.projectID = responseObject[@"id"];
        [self.projects addObject:project];
        
        [self.delegate passProjects:self.projects];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
    
}

-(void)deleteProject:(Project *)project {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *targetServer = @"http://localhost:8001/project/";
    NSString *projectToBeRemovedWithID = project.projectID;
    
    [manager DELETE:[NSString stringWithFormat:@"%@%@",targetServer,projectToBeRemovedWithID] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self.projects removeObject:project];
        
        [self.delegate passProjects:self.projects];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
    
}

-(void)updateProject:(Project *)project {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary *projectToSend = @{@"name": project.name,
                                    @"color":[self transformToStringFromColor:project.color]};

    [manager PUT:[NSString stringWithFormat:@"%@%@",@"http://localhost:8001/project/", project.projectID] parameters:projectToSend success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self.delegate passProjects:self.projects];
    
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

#pragma mark Color to String and vice versa transformations

-(NSString *)transformToStringFromColor:(UIColor *)color {
    const size_t totalComponents = CGColorGetNumberOfComponents(color.CGColor);
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    
    return [NSString stringWithFormat:@"#%02X%02X%02X",
                                    (int)(255 * components[MIN(0,totalComponents-2)]),
                                    (int)(255 * components[MIN(1,totalComponents-2)]),
                                    (int)(255 * components[MIN(2,totalComponents-2)])];
}

-(UIColor *)transformToColorFromHexString:(NSString *)hexString {
    
    //Default
    UIColor *defaultResult = [UIColor blackColor];
    
    //Strip prefixed # hash
    if ([hexString hasPrefix:@"#"] && [hexString length] > 1) {
        hexString = [hexString substringFromIndex:1];
    }
    
    //Determine if 3 or 6 digits
    NSUInteger componentLength = 0;
    if ([hexString length] == 3)
    {
        componentLength = 1;
    }
    else if ([hexString length] == 6)
    {
        componentLength = 2;
    }
    else
    {
        return defaultResult;
    }
    
    BOOL isValid = YES;
    CGFloat components[3];
    
    //Seperate the R,G,B values
    for (NSUInteger i = 0; i < 3; i++) {
        NSString *component = [hexString substringWithRange:NSMakeRange(componentLength *i, componentLength)];
        if (componentLength == 1) {
            component = [component stringByAppendingString:component];
        }
        NSScanner *scanner = [NSScanner scannerWithString:component];
        unsigned int value;
        isValid &= [scanner scanHexInt:&value];
        components[i] = (CGFloat)value / 256.0f;
    }
    
    if (!isValid) {
        return defaultResult;
    }
    
    return [UIColor colorWithRed:components[0]
                           green:components[1]
                            blue:components[2]
                           alpha:1.0];
    
}

@end

