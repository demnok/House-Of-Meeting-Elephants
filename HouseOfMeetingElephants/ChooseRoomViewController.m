//
//  ChooseRoomViewController.m
//  HouseOfMeetingElephants
//
//  Created by Stolniceanu Stefan on 10/11/14.
//  Copyright (c) 2014 Stefan Stolniceanu. All rights reserved.
//

#import "ChooseRoomViewController.h"

@interface ChooseRoomViewController ()

@property (nonatomic, strong) RoomList *roomList;

@end

@implementation ChooseRoomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.roomList = [[RoomList alloc] init];
    
    self.roomList.delegate = self;
    [self.roomList fetchRooms];
    
    self.roomPicker.delegate = self;

}

-(void)passRooms:(NSMutableArray *)rooms {
    self.roomPickerSource = rooms;
    [self.roomPicker reloadAllComponents];
}

#pragma mark Methods for UIPickerView

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.roomPickerSource count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [[self.roomPickerSource objectAtIndex:row] name];
}


#pragma mark Methods for the Create Room View Controller Delegate

-(void)CreateRoomTableViewControllerDelegateDidCancel:(CreateRoomTableViewController *)vc {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)CreateRoomTableViewControllerDelegateDidSave:(CreateRoomTableViewController *)vc room:(Room *)room {
    
    
    [self.roomList addRoom:room];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark Preparing for segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([segue.identifier isEqualToString:@"createRoom"]) {
        
        UINavigationController *navigationController = segue.destinationViewController;
        
        CreateRoomTableViewController *destination = navigationController.viewControllers.firstObject;
        
        destination.delegate = self;
    }
    
}

#pragma mark Save & Cancel

- (IBAction)cancelChoiceOfRoom:(id)sender {
    [self.delegate ChooseRoomViewControllerDelegateDidCancel:self];
}

- (IBAction)saveChoiceOfRoom:(id)sender {
    [self.delegate ChooseRoomViewControllerDelegateDidSave:self withRoom:[self.roomPickerSource objectAtIndex:[self.roomPicker selectedRowInComponent:0]]];
}
@end
