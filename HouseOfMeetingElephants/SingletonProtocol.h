//
//  SingletonProtocol.h
//  HouseOfMeetingElephants
//
//  Created by Stolniceanu Stefan on 18/11/14.
//  Copyright (c) 2014 Stefan Stolniceanu. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SingletonProtocol <NSObject>

+ (instancetype)sharedInstance;
@end
