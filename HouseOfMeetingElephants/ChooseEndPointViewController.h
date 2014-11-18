//
//  ChooseEndPointViewController.h
//  HouseOfMeetingElephants
//
//  Created by Stolniceanu Stefan on 12/11/14.
//  Copyright (c) 2014 Stefan Stolniceanu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChooseEndPointViewControllerDelegate.h"

@interface ChooseEndPointViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIDatePicker *endPointDatePicker;

@property (nonatomic, weak) id<ChooseEndPointViewControllerDelegate>delegate;

- (IBAction)saveChoiceOfEndPointDate:(id)sender;
- (IBAction)cancelChoiceOfEndPointDate:(id)sender;

@end
