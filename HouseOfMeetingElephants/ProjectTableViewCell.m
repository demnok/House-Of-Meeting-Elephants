//
//  ProjectTableViewCell.m
//  HouseOfMeetingElephants
//
//  Created by Stolniceanu Stefan on 04/11/14.
//  Copyright (c) 2014 Stefan Stolniceanu. All rights reserved.
//

#import "ProjectTableViewCell.h"

@implementation ProjectTableViewCell

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)setCurrentProject:(Project *)currentProject {
    [self populateInterface:currentProject];
}

-(void)populateInterface:(Project *)project {
    self.projectNameLabel.text = project.name;
    self.projectNameLabel.textColor = project.color;
}

@end
