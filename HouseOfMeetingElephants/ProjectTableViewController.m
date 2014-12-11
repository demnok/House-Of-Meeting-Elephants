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
@property (nonatomic, strong) Project *sentProject;
@property (nonatomic, strong) ProjectList *projectList;

@end

@implementation ProjectTableViewController

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.projectList = [[ProjectList alloc] init];
    self.projectList.delegate = self;
    [self.projectList fetchProjects];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.project = [[Project alloc] init];
    [self.tableView registerNib:[UINib nibWithNibName:@"ProjectTableViewCell" bundle:nil] forCellReuseIdentifier:@"ProjectTableViewCell"];
}

-(void)passProjects:(NSMutableArray *)projects {
    [self.tableView reloadData];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([segue.identifier isEqualToString:@"createProject"]) {
        
        UINavigationController *navigationController = segue.destinationViewController;
        
        CreateProjectTableViewController *destination = navigationController.viewControllers.firstObject;
        
        destination.delegate = self;
    }
    
    if([segue.identifier isEqualToString:@"projectDetail"]) {
        UINavigationController *navigationController = segue.destinationViewController;
        
        ProjectDetailTableViewController *destination = navigationController.viewControllers.firstObject;
        
        destination.detailProject = self.sentProject;
        destination.color = self.sentProject.color;
        destination.delegate = self;
    }

}

-(void)CreateProjectTableViewControllerDelegateDidCancel:(CreateProjectTableViewController *)vc {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)CreateProjectTableViewControllerDelegateDidSave:(CreateProjectTableViewController *)vc project:(Project *)project {
    
    [self.projectList addProject:project];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark Methods for Project Detail Table View Controller Delegate

-(void)ProjectDetailTableViewControllerDelegateDidGoBack:(ProjectDetailTableViewController *)vc {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)ProjectDetailTableViewControllerDelegateDidUpdate:(ProjectDetailTableViewController *)vc withProject:(Project *)project {
    
    [self.projectList updateProject:project];
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.projectList.projects.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ProjectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProjectTableViewCell"];
   
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    Project *projectInCell = self.projectList.projects[indexPath.row];
    
    cell.currentProject = projectInCell;
    cell.projectNameLabel.textColor = projectInCell.color;
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.sentProject = [self.projectList.projects objectAtIndex:indexPath.row];
    
    [self performSegueWithIdentifier:@"projectDetail" sender:nil];
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [self.projectList deleteProject:[self.projectList.projects objectAtIndex:indexPath.row]];
        
        [tableView reloadData];
    }
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

@end
