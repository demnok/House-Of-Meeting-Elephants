//
//  BookingDetailViewControllerDelegate.h
//  HouseOfMeetingElephants
//
//  Created by Stolniceanu Stefan on 17/11/14.
//  Copyright (c) 2014 Stefan Stolniceanu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BookingDetailTableViewController;
@class Booking;

@protocol BookingDetailViewControllerDelegate <NSObject>

-(void)BookingDetailViewControllerDelegateDidGoBack:(BookingDetailTableViewController *)vc;
-(void)BookingDetailViewControllerDelegateDidUpdate:(BookingDetailTableViewController *)vc withBooking:(Booking *)booking;

@end
