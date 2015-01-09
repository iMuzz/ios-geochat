//
//  LoginViewController.m
//  GeoChat
//
//  Created by Faraaz Nishtar on 1/7/15.
//  Copyright (c) 2015 MosRedRocket. All rights reserved.
//

#import <FacebookSDK/FacebookSDK.h>
#import "LoginViewController.h"
#import "MainViewController.h"
#import "GeoChatManager.h"

@interface LoginViewController () <FBLoginViewDelegate>

@property (nonatomic, strong) IBOutlet FBLoginView *fbLoginButton;

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFinishLoggingIn:) name:@"didFinishLoggingIn" object:nil];
    
    self.fbLoginButton.delegate = self;
    self.fbLoginButton.readPermissions = @[@"public_profile", @"email"];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didFinishLoggingIn:(NSNotification *)notification
{
    NSLog(@"%s: %@", __PRETTY_FUNCTION__, notification);
}

-(void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user
{
    NSLog(@"%@", [[[FBSession activeSession] accessTokenData] accessToken]);
    MainViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"mainView"];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
    
    [self presentViewController:navController animated:NO completion:nil];
}

- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

@end