//
//  MainViewController.m
//  GeoChat
//
//  Created by Art Sevilla on 1/8/15.
//  Copyright (c) 2015 MosRedRocket. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "MainViewController.h"

@interface MainViewController () <CLLocationManagerDelegate, UIActionSheetDelegate>

@property (nonatomic, strong) NSMutableArray *roomItems;
@property (nonatomic, strong) NSMutableArray *joinedRooms;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndictor;

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"GeoChat!";
    
    self.roomItems = [@[@{@"room_name" : @"test room", @"distance" : @"0.05"}, @{@"room_name" : @"test room 2", @"distance" : @"0.07"}] mutableCopy];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"System-settings-icon"] style:UIBarButtonItemStylePlain target:self action:@selector(showSettings)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addRoom)];
}

- (void)addRoom
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (void)showSettings
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Options" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Show profile", @"Logout", nil];
    
    [actionSheet showInView:self.view];
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
    return self.roomItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    
    cell.textLabel.text = [[self.roomItems objectAtIndex:indexPath.row] objectForKey:@"room_name"];
    
    cell.detailTextLabel.textColor = [UIColor lightGrayColor];
    cell.detailTextLabel.text = [[self.roomItems objectAtIndex:indexPath.row] objectForKey:@"distance"];
    
    return cell;
}

#pragma mark - Action sheet delegate

- (void)actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            NSLog(@"First");
            break;
            
        case 1:
            NSLog(@"Second");
            break;
            
        case 2:
            NSLog(@"Third");
            break;
            
        default:
            break;
    }
}


@end
