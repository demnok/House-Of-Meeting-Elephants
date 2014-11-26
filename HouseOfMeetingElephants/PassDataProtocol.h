//
//  PassDataProtocol.h
//  HouseOfMeetingElephants
//
//  Created by Stolniceanu Stefan on 21/11/14.
//  Copyright (c) 2014 Stefan Stolniceanu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NSMutableArray;

@protocol PassDataProtocol <NSObject>

-(void)passData:(NSMutableArray *)data;

@end
