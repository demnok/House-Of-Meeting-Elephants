 //
//  RoomList.m
//  HouseOfMeetingElephants
//
//  Created by Stolniceanu Stefan on 11/11/14.
//  Copyright (c) 2014 Stefan Stolniceanu. All rights reserved.
//

#import "RoomList.h"
#import "AFNetworking.h"

@interface RoomList ()

@end

@implementation RoomList
{
    NSString *host;
    NSString *pathByID;
    AFHTTPRequestOperationManager *manager;
}

#pragma mark - Initialisation

- (instancetype)init {
    
    if (self = [super init]) {
        [self initHost];
        [self initManager];
    }
    
    return self;
}

- (void)initHost {
    host = [[NSString alloc] init];
    host = @"http://localhost:8001/room/";
}

- (void)initManager {
    manager = [AFHTTPRequestOperationManager manager];
}

#pragma mark - Helper methods

- (NSString *)stringFromDict:(id )dictionary {
    
    NSDictionary *dict = (NSDictionary *)dictionary;
    NSString *string = [NSString stringWithFormat:@"%@", dict];
    
    return string;
}

- (NSString *)merge:(NSString *)firstString with:(NSString *)secondString {
    
    NSMutableString *result = (NSMutableString *)firstString;
    
    [result appendString:secondString];
    
    return [result copy];
}

#pragma mark - Server communication related methods

-(void)fetchRooms {
    
    __block NSMutableArray *roomsToPass = [NSMutableArray array];
    
    [manager GET:host parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSMutableArray *rooms = (NSMutableArray *)responseObject;
        
        [rooms enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            NSDictionary *object = (NSDictionary *)obj;
            
            Room *roomToAdd = [[Room alloc] init];
            
            roomToAdd.name = [self stringFromDict:object[@"name"]];
            
            NSString *roomID = [self stringFromDict:object[@"id"]];
            roomToAdd.roomID = roomID;
            
            [roomsToPass addObject:roomToAdd];
        }];
                
        self.rooms = roomsToPass;
        [self.delegate passRooms:roomsToPass];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

-(void)deleteRoom:(Room *)room {

    pathByID = [self merge:host with:room.roomID];
    
    [manager DELETE:pathByID parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self.rooms removeObject:room];
        
        [self.delegate passRooms:self.rooms];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];

    
}

-(void)addRoom:(Room *)room {

    NSDictionary *roomToSend = @{@"name" : room.name};
    
    [manager POST:host parameters:roomToSend success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        room.roomID = [self stringFromDict:responseObject[@"id"]];
        [self.rooms addObject:room];
        
        [self.delegate passRooms:self.rooms];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

-(void)updateRoom:(Room *)room {
    
    pathByID = [self merge:host with:room.roomID];
    
    NSDictionary *roomToSend = @{@"name" : room.name};
    
    [manager PUT:pathByID
      parameters:roomToSend
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             
        [self.delegate passRooms:self.rooms];
    }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             
    }];
    
}

@end
