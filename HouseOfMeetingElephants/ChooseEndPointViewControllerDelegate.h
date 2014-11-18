//
//  ChooseEndPointViewControllerDelegate.h
//  HouseOfMeetingElephants
//
//  Created by Stolniceanu Stefan on 18/11/14.
//  Copyright (c) 2014 Stefan Stolniceanu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ChooseEndPointViewController;
@class NSDate;

@protocol ChooseEndPointViewControllerDelegate <NSObject>

-(void)ChooseEndPointViewControllerDelegateDidCancel:(ChooseEndPointViewController *)vc;
-(void)ChooseEndPointViewControllerDelegateDidSave:(ChooseEndPointViewController *)vc withDate:(NSDate *)date;

@end
