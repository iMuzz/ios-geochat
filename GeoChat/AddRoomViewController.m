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
    
    self.title = @"Create room";
    
    self.menuItems = [@[@"name cell", @"button cell", @"map cell"] mutableCopy];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(cancelRoom)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(createRoom)];
    
}

- (void)cancelRoom
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)createRoom
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    
    cell.textLabel.text = [self.menuItems objectAtIndex:indexPath.row];
    
    return cell;
    
}



@end
