//
//  MainViewController.m
//  GeoChat
//
//  Created by Art Sevilla on 1/8/15.
//  Copyright (c) 2015 MosRedRocket. All rights reserved.
//

#import <MapKit/MapKit.h>
#import <AFOAuth2Manager/AFOAuth2Manager.h>
#import "GeoChatAPIManager.h"
#import "LoginViewController.h"
#import "MainViewController.h"
#import "AddRoomViewController.h"
#import "ProfileViewController.h"

@interface MainViewController () <CLLocationManagerDelegate, UIActionSheetDelegate, UIAlertViewDelegate>

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
    
    self.navigationController.navigationBarHidden = NO;
    
    UIColor *color = [UIColor colorWithRed:196.0f green:245.0f blue:233.0f alpha:1.0f];
    
    self.view.backgroundColor = color;
    
    self.roomItems = [@[@{@"room_name" : @"test room", @"distance" : @"0.05"}, @{@"room_name" : @"test room 2", @"distance" : @"0.07"}] mutableCopy];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"System-settings-icon"] style:UIBarButtonItemStylePlain target:self action:@selector(showSettings)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addRoom)];
    
    //locationManager
    self.locationManager = [[CLLocationManager alloc] init];
    [self.locationManager requestAlwaysAuthorization];
}

- (void)addRoom
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    AddRoomViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"addRoomView"];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
    [self.navigationController presentViewController:navController animated:YES completion:nil];
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
        case 0: {
            ProfileViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"profileView"];
            UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
            [self.navigationController presentViewController:navController animated:YES completion:nil];
        }
            break;
            
        case 1: {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Logout" message:@"Are you sure you want to logout?" delegate:self cancelButtonTitle:@"Never mind" otherButtonTitles:@"Logout", nil];
            [alert show];
        }
            break;
            
        case 2: {
            NSLog(@"Cancelling action sheet...");
        }
            break;
            
        default:
            break;
    }
}


#pragma mark - Alert view delegate

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0: {
            NSLog(@"First");
        }
            break;
            
        case 1: {
            NSLog(@"Second");
            [[FBSession activeSession] closeAndClearTokenInformation];
            if ([AFOAuthCredential deleteCredentialWithIdentifier:@"OAuthTokenIdentifier"]) {
                LoginViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"loginView"];
                [self.navigationController presentViewController:controller animated:NO completion:nil];
            } else {
                NSLog(@"Something went wrong with deleting the credentials...");
            }
            
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - CLLocation Manager

@end
