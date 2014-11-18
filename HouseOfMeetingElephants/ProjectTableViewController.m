//
//  ProjectTableViewController.m
//  HouseOfMeetingElephants
//
//  Created by Stolniceanu Stefan on 04/11/14.
//  Copyright (c) 2014 Stefan Stolniceanu. All rights reserved.
//

#import "ProjectTableViewController.h"
#import "Project.h"

@interface ProjectTableViewController ()

@property (nonatomic, strong) Project *project;

@end

@implementation ProjectTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.project = [[Project alloc] init];
    [self.tableView registerNib:[UINib nibWithNibName:@"ProjectTableViewCell" bundle:nil] forCellReuseIdentifier:@"ProjectTableViewCell"];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([segue.identifier isEqualToString:@"createProject"]) {
        
        UINavigationController *navigationController = segue.destinationViewController;
        
        CreateProjectTableViewController *destination = navigationController.viewControllers.firstObject;
        
        destination.delegate = self;
    }
    
}

-(void)CreateProjectTableViewControllerDelegateDidCancel:(CreateProjectTableViewController *)vc {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)CreateProjectTableViewControllerDelegateDidSave:(CreateProjectTableViewController *)vc project:(Project *)project {
    
    [[ProjectList sharedInstance].projects addObject:project];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [ProjectList sharedInstance].projects.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ProjectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProjectTableViewCell"];
   
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.currentProject = [ProjectList sharedInstance].projects[indexPath.row];
    
    return cell;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [[ProjectList sharedInstance].projects  removeObjectAtIndex:indexPath.row];
        [tableView reloadData];
    }
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

@end
