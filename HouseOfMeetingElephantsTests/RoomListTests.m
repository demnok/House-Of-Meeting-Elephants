////
////  RoomListTests.m
////  HouseOfMeetingElephants
////
////  Created by Stolniceanu Stefan on 29/12/14.
////  Copyright (c) 2014 Stefan Stolniceanu. All rights reserved.
////
//
//#import <UIKit/UIKit.h>
//#import <XCTest/XCTest.h>
//#import "RoomList.h"
//
//@interface RoomListTests : XCTestCase
//
//@end
//
//@implementation RoomListTests
//{
//    RoomList *roomList;
//    Room *room;
//    __block BOOL done;
//}
//
//- (void)setUp {
//    [super setUp];
//    roomList = [[RoomList alloc] init];
//    room.name = @"Test room";
//    room.roomID = @"Test room";
//}
//
//- (void)tearDown {
//    [super tearDown];
//}
//
//- (void)testRoomListClassExists {
//    XCTAssertNotNil(roomList, @"RoomList class exists");
//}
//
//- (void)testFetchRooms {
//    done = NO;
//    
//    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
//        [roomList fetchRooms];
//    });
//    
//    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
//        done = YES;
//    });
//    
//    XCTAssertTrue([self waitFor:&done timeOut:2], @"Takes less than 2 seconds to retrieve data");
//
//}
//
////- (void)testAddingARoom {
////    done = NO;
////    
////    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
////        [roomList addRoom:room];
////    });
////    
////    dispatch_sync(<#dispatch_queue_t queue#>, <#^(void)block#>)
////}
//
//- (BOOL)waitFor:(BOOL *)flag timeOut:(NSTimeInterval)timeOutSecs {
//    
//    NSDate *timeOutDate = [NSDate dateWithTimeIntervalSinceNow:timeOutSecs];
//    
//    do {
//        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:timeOutDate];
//        
//        if([timeOutDate timeIntervalSinceNow] < 0.0) {
//            break;
//        }
//    }while(!*flag);
//    
//    return *flag;
//}
//
//- (void)testPerformanceExample {
//    // This is an example of a performance test case.
//    [self measureBlock:^{
//        // Put the code you want to measure the time of here.
//    }];
//}
//
//@end
