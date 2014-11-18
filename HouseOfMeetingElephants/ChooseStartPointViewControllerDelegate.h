//
//  ChooseStartPointViewControllerDelegate.h
//  HouseOfMeetingElephants
//
//  Created by Stolniceanu Stefan on 18/11/14.
//  Copyright (c) 2014 Stefan Stolniceanu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ChooseStartPointViewController;
@class NSDate;

@protocol ChooseStartPointViewControllerDelegate <NSObject>

-(void)ChooseStartPointViewControllerDelegateDidCancel:(ChooseStartPointViewController *)vc;
-(void)ChooseStartPointViewControllerDelegateDidSave:(ChooseStartPointViewController *)vc withDate:(NSDate *)date;

@end
