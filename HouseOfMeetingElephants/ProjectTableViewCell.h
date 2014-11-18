//
//  ProjectTableViewCell.h
//  HouseOfMeetingElephants
//
//  Created by Stolniceanu Stefan on 04/11/14.
//  Copyright (c) 2014 Stefan Stolniceanu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Project.h"

@interface ProjectTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *projectNameLabel;

@property (strong, nonatomic) Project *currentProject;

@end
