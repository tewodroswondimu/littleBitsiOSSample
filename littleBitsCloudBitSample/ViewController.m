//
//  ViewController.m
//  littleBitsCloudBitSample
//
//  Created by Tewodros Wondimu on 2/21/15.
//  Copyright (c) 2015 Tewodros Wondimu. All rights reserved.
//

#import "ViewController.h"
#import "LittleBitsObject.h"

// Your Device ID. You can find it at control.littlebitscloud.cc, after you login, choose your cloudbit on the left and click settings from the tab bar, and copy the deviceID
#define deviceID @"Your_Device_ID"

// The authorization is the string "Bearer XXXX" where XXXX is your accessToken, your accessToken can be found in the same page you found the device ID
#define authorization @"Bearer XXXX"

#define contentType @"application/json"
#define accept @"application/vnd.littlebits.v2+json"

@interface ViewController ()

@property NSDictionary *deviceInfo;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Retrieves the device information from little bits and saves it into an ns dictionary
    [LittleBitsObject retrieveDeviceInfoWithDeviceID:deviceID authorizationAccessToken:authorization theContentType:contentType acceptFormat:accept withCompletionBlock:^(NSDictionary *deviceInfo) {
        self.deviceInfo = deviceInfo;
    }];
}

- (IBAction)onTurnOnButtonPressed:(UIButton *)sender
{
    // Set HTTP Body, try changing the value for the percent and duration
    // Current value sets the value of the module connected to 100% for a duration of 50000 microseconds
    NSDictionary *dictionary = @{
         @"percent": @100,
         @"duration_ms": @50000
     };
    [LittleBitsObject turnDeviceOnWithDeviceInfo:self.deviceInfo authorizationAccessToken:authorization theContentType:contentType acceptFormat:accept bodyDictionary:(NSDictionary *)dictionary];
}

- (IBAction)onTurnOffButtonPressed:(UIButton *)sender
{
    // Set HTTP Body, turns off the module in 1 microsecond
    NSDictionary *dictionary = @{
                                 @"percent": @0,
                                 @"duration_ms": @1
                                 };
    [LittleBitsObject turnDeviceOnWithDeviceInfo:self.deviceInfo authorizationAccessToken:authorization theContentType:contentType acceptFormat:accept bodyDictionary:(NSDictionary *)dictionary];
}

@end
