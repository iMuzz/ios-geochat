//
//  ProfileViewController.m
//  GeoChat
//
//  Created by Art Sevilla on 1/9/15.
//  Copyright (c) 2015 MosRedRocket. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()

@property (nonatomic, strong) NSMutableArray *userItems;

@end

@implementation ProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Profile";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(closeView)];
    self.userItems = [@[@"fb id", @"nickname stuff goes here"] mutableCopy];
}

- (void)closeView
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
    return self.userItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    
    cell.textLabel.text = [self.userItems objectAtIndex:indexPath.row];
    
    return cell;
}

@end
