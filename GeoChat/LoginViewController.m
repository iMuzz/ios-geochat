//
//  LoginViewController.m
//  GeoChat
//
//  Created by Faraaz Nishtar on 1/7/15.
//  Copyright (c) 2015 MosRedRocket. All rights reserved.
//

#import "LoginViewController.h"
#import <FacebookSDK/FacebookSDK.h>

@interface LoginViewController () <FBLoginViewDelegate>

@property (nonatomic, strong) IBOutlet FBLoginView *fbLoginButton;

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.fbLoginButton.delegate = self;
    self.fbLoginButton.readPermissions = @[@"public_profile", @"email"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user
{
    NSLog(@"%@", [[[FBSession activeSession] accessTokenData] accessToken]);
}

- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView
{
    //
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end