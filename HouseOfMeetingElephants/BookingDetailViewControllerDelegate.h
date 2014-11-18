//
//  BookingDetailViewControllerDelegate.h
//  HouseOfMeetingElephants
//
//  Created by Stolniceanu Stefan on 17/11/14.
//  Copyright (c) 2014 Stefan Stolniceanu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BookingDetailViewController;

@protocol BookingDetailViewControllerDelegate <NSObject>

-(void)BookingDetailViewControllerDelegateDidGoBack:(BookingDetailViewController *)vc;

@end
