//
//  AddRoomViewController.m
//  GeoChat
//
//  Created by Art Sevilla on 1/9/15.
//  Copyright (c) 2015 MosRedRocket. All rights reserved.
//

#import "AddRoomViewController.h"

@interface AddRoomViewController ()

@property (nonatomic, strong) NSMutableArray *menuItems;

@end

@implementation AddRoomViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.menuItems.count;
}



@end
