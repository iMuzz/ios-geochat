//
//  LoginViewController.m
//  GeoChat
//
//  Created by Faraaz Nishtar on 1/7/15.
//  Copyright (c) 2015 MosRedRocket. All rights reserved.
//

#import <AFOAuth2Manager/AFOAuth2Manager.h>
#import "LoginViewController.h"
#import "MainViewController.h"
#import "GeoChatManager.h"
#import "GeoChatAPIManager.h"

@interface LoginViewController () <FBLoginViewDelegate>

@property (nonatomic, strong) IBOutlet FBLoginView *fbLoginButton;

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIColor *color = [UIColor colorWithRed:196.0f green:245.0f blue:233.0f alpha:1.0f];
    
    self.view.backgroundColor = color;
    self.navigationController.navigationBarHidden = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFinishLoggingIn:) name:@"didFinishLoggingIn" object:nil];
    
    self.fbLoginButton.delegate = self;
    self.fbLoginButton.readPermissions = @[@"public_profile"];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didFinishLoggingIn:(NSNotification *)notification
{
    NSLog(@"%s: %@", __PRETTY_FUNCTION__, notification);
    
    MainViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"mainView"];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
    
    [self.navigationController presentViewController:navController animated:NO completion:nil];
}

-(void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user
{
    NSLog(@"%@", [[[FBSession activeSession] accessTokenData] accessToken]);
    
    BOOL validCredentials = [AFOAuthCredential retrieveCredentialWithIdentifier:@"kOAuthTokenIdentifier"];
    
    if (validCredentials) {
        NSLog(@"Logging in...");
        [[GeoChatAPIManager sharedManager] loginWithAssertion:[[[FBSession activeSession] accessTokenData] accessToken]];
    } else {
        NSLog(@"Bypassing notification...");
        MainViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"mainView"];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
        
        [self.navigationController presentViewController:navController animated:NO completion:nil];
    }
}

- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView
{
    
}

@end