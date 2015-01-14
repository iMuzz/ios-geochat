//
//  GeoChatAPIManager.m
//  GeoChat
//
//  Created by Art Sevilla on 1/12/15.
//  Copyright (c) 2015 MosRedRocket. All rights reserved.
//

#define kGeoChatEndpoint @"https://geochat-v1.herokuapp.com"
#define kOAuthTokenIdentifier @"OAuthTokenIdentifier"

#import <AFNetworking/AFNetworking.h>
#import <AFOAuth2Manager/AFOAuth2Manager.h>
#import "GeoChatAPIManager.h"

@interface GeoChatAPIManager()

@property (nonatomic, strong) AFURLSessionManager *sessionManager;
@property (nonatomic, strong) AFOAuth2Manager *oAuthManager;

@end

static NSString *ClientID = @"81fc0fd70219e5701f54982262b0f6b3c4bb6643a289581ae023bc85513e32e3";
static NSString *ClientSecret = @"87fa1dde258a6bea536840d98b1c8934d26790cbb0124c3a136f1da2f2a8803b";
NSString *AccessToken;
NSString *RefreshToken;
dispatch_queue_t kBgQueue;

@implementation GeoChatAPIManager

+ (GeoChatAPIManager *)sharedManager
{
    static dispatch_once_t pred;
    static GeoChatAPIManager *manager = nil;
    
    dispatch_once(&pred, ^{
        NSLog(@"This is the only time you should be seeing this...");
        manager = [[GeoChatAPIManager alloc] init];
    });
    
    return manager;
}

- (id)init
{
    self = [super init];
    
    if (self) {
        NSLog(@"The API manager is initialized...");
        kBgQueue = dispatch_queue_create("com.MosRedRocket.GeoChatManager.bgqueue", NULL);
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _sessionManager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    }
    
    return self;
}

- (void)sendGETRequestForBaseURL:(NSString *)baseURL parameters:(NSDictionary *)parameters
{
    dispatch_async(kBgQueue, ^{
        [[AFHTTPRequestOperationManager manager] GET:[NSString stringWithFormat:@"%@/%@", kGeoChatEndpoint, baseURL] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"Did finish GET with object: %@", responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Did finish GET with error: %@", error.description);
        }];
    });
}

- (void)sendPOSTRequestForBaseURL:(NSString *)baseURL parameters:(NSDictionary *)parameters
{
    dispatch_async(kBgQueue, ^{
        [[AFHTTPRequestOperationManager manager] POST:[NSString stringWithFormat:@"%@/%@", kGeoChatEndpoint, baseURL] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"Did finish POST with object: %@", responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Did finish POST with error: %@", error.description);
        }];
    });
}

- (void)sendPATCHRequestForBaseURL:(NSString *)baseURL parameters:(NSDictionary *)parameters
{
    
}

- (void)loginWithAssertion:(NSString *)assertion
{
    NSURL *geoChatURL = [NSURL URLWithString:kGeoChatEndpoint];
    
    self.oAuthManager = [[AFOAuth2Manager alloc] initWithBaseURL:geoChatURL clientID:ClientID secret:ClientSecret];
    dispatch_async(kBgQueue, ^{
        [self.oAuthManager authenticateUsingOAuthWithURLString:@"oauth/token" parameters:@{@"grant_type":@"assertion", @"assertion":assertion} success:^(AFOAuthCredential *credential) {
            NSLog(@"Did finish successfully with oauth credentials: %@", credential);
            AccessToken = credential.accessToken;
            RefreshToken = credential.refreshToken;
            [AFOAuthCredential storeCredential:credential withIdentifier:kOAuthTokenIdentifier];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"Posting notification...");
                [[NSNotificationCenter defaultCenter] postNotificationName:@"didFinishLoggingIn" object:nil];
            });
            
            [self fetchRoomsForLatitude:@"35.259484" longitude:@"-120.687875"];
            
        } failure:^(NSError *error) {
            NSLog(@"Did finish with error: %@", error.description);
        }];
    });
}

- (void)logout
{
    NSLog(@"Logging out...");
}

- (void)fetchRoomsForLatitude:(NSString *)latitude longitude:(NSString *)longitude
{
    NSDictionary *parameters = @{@"access_token":AccessToken, @"latitude":latitude, @"longitude":longitude, @"offest": @"0", @"size": @"10", @"radius": @"10"};
    
    [self sendGETRequestForBaseURL:@"api/v1/chat_rooms" parameters:parameters];
}

- (void)fetchRoomForID:(NSString *)roomID
{
    
}

@end
