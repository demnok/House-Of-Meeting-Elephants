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
{
    NSString *_host;
    NSString *_pathByID;
    AFHTTPRequestOperationManager *_manager;
}

#pragma mark - Initialisation

- (instancetype)init {
    
    if (self = [super init]) {
        [self setupHost];
        [self setupManager];
    }
    
    return self;
}

- (void)setupHost {
    _host = [[NSString alloc] init];
    _host = @"http://localhost:8001/project/";
}

- (void)setupManager {
    _manager = [AFHTTPRequestOperationManager manager];
}

#pragma mark - Server communication related methods

-(void)fetchProjects {
    
    __block NSMutableArray *projectsToPass = [NSMutableArray array];
    __block UIColor *color;
    
    [_manager GET:_host
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSMutableArray *projects = (NSMutableArray *)responseObject;
        
        [projects enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            NSDictionary *object = (NSDictionary *)obj;
            Project *addedProject = [[Project alloc] init];
            
            color = [self transformToColorFromHexString:object[@"color"]];
            
            addedProject.projectID = [object[@"id"] description];
            addedProject.name = [object[@"name"] description];
            
            addedProject.color = color;
            
            [projectsToPass addObject:addedProject];
        }];
    
        self.projects = projectsToPass;
        [self.delegate passProjects:projectsToPass];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
}

-(void)addProject:(Project *)project {
    
    NSString *projectColor;
    projectColor = [self transformToStringFromColor:project.color];
    
    NSDictionary *projectToSend = @{@"name": project.name,
                                    @"color": projectColor};
    
    [_manager POST:_host
       parameters:projectToSend
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
       
        project.projectID = [responseObject[@"id"] description];
        [self.projects addObject:project];
        
        [self.delegate passProjects:self.projects];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
    
}

-(void)deleteProject:(Project *)project {

    _pathByID = [_host stringByAppendingString:project.projectID];
    
    [_manager DELETE:_pathByID
         parameters:nil
            success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self.projects removeObject:project];
        
        [self.delegate passProjects:self.projects];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
    
}

-(void)updateProject:(Project *)project {

    NSDictionary *projectToSend = @{@"name": project.name,
                                    @"color":[self transformToStringFromColor:project.color]};

    _pathByID = [_host stringByAppendingString:project.projectID];
    
    [_manager PUT:_pathByID
      parameters:projectToSend
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self.delegate passProjects:self.projects];
    
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

#pragma mark - Color to String and vice versa transformations

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
        NSRange range = NSMakeRange(componentLength *i, componentLength);
        NSString *component = [hexString substringWithRange:range];
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

