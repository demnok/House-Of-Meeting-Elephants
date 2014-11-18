//
//  ChooseStartPointViewController.h
//  HouseOfMeetingElephants
//
//  Created by Stolniceanu Stefan on 12/11/14.
//  Copyright (c) 2014 Stefan Stolniceanu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChooseStartPointViewControllerDelegate.h"

@interface ChooseStartPointViewController : UIViewController


@property (weak, nonatomic) IBOutlet UIDatePicker *startPointDatePicker;

- (IBAction)saveChoiceOfStartPointDate:(id)sender;
- (IBAction)cancelChoiceOfStartPointDate:(id)sender;

@property (nonatomic, weak) id<ChooseStartPointViewControllerDelegate>delegate;

@end
