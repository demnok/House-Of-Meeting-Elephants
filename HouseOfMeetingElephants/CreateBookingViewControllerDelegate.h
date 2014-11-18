
//
//  CreateBookingViewControllerDismissProtocol.h
//  HouseOfMeetingElephants
//
//  Created by Stolniceanu Stefan on 14/11/14.
//  Copyright (c) 2014 Stefan Stolniceanu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CreateBookingTableViewController;
@class Booking;

@protocol CreateBookingViewControllerDelegate <NSObject>

-(void)createBookingViewControllerDelegateDidCancel:(CreateBookingTableViewController *)vc;
-(void)createBookingViewControllerDelegateDidSave:(CreateBookingTableViewController *)vc booking:(Booking *)booking;

@end
