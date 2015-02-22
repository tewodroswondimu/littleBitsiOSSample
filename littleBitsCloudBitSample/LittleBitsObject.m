//
//  LittleBitsObject.m
//  littleBitsCloudBitSample
//
//  Created by Tewodros Wondimu on 2/21/15.
//  Copyright (c) 2015 Tewodros Wondimu. All rights reserved.
//

#import "LittleBitsObject.h"

@implementation LittleBitsObject

+ (void)retrieveDeviceInfoWithDeviceID:(NSString *)deviceID authorizationAccessToken:(NSString *)authorization theContentType:(NSString *)contentType acceptFormat:(NSString *)accept withCompletionBlock:(void(^)(NSDictionary *deviceInfo))complete
{
    // URL for the device
    NSString *urlString = @"https://api-http.littlebitscloud.cc/v2/devices";
    NSURL *url = [NSURL URLWithString:urlString];

    // Setup a URL Request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"GET"];
    [request setValue:authorization forHTTPHeaderField:@"Authorization"];
    [request setValue:contentType forHTTPHeaderField:@"Content-Type"];
    [request setValue:accept forHTTPHeaderField:@"Accept"];

    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (!connectionError) {
            NSError *error = nil;
            NSArray *response = [NSJSONSerialization JSONObjectWithData:data options:NSASCIIStringEncoding error:&error];
            if (!error) {
                // Filter through the array of devices and find your device
                for (NSDictionary *resultDictionary in response) {
                    if ([resultDictionary[@"id"] isEqualToString:deviceID]) {

                        // End the completion block by sending the device info
                        complete(resultDictionary);
                    }
                }
            }
            else
            {
                NSLog(@"JSON Serialization Error: %@", error);
            }
        }
        else
        {
            NSLog(@"%@", [connectionError localizedDescription]);
        }
    }];
}

+ (void)turnDeviceOnWithDeviceInfo:(NSDictionary *)deviceInfo authorizationAccessToken:(NSString *)authorization theContentType:(NSString *)contentType acceptFormat:(NSString *)accept bodyDictionary:(NSDictionary *)dictionary
{
    // URL for the device
    NSString *urlString = [NSString stringWithFormat:@"https://api-http.littlebitscloud.cc/v2/devices/%@/output", deviceInfo[@"id"]];
    NSURL *url = [NSURL URLWithString:urlString];

    // Setup a URL Request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:authorization forHTTPHeaderField:@"Authorization"];
    [request setValue:contentType forHTTPHeaderField:@"Content-Type"];
    [request setValue:accept forHTTPHeaderField:@"Accept"];

    NSData *finalJSONData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:nil];
    [request setHTTPBody:finalJSONData];

    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (!connectionError) {
            NSLog(@"The response was %@", response);
        }
        else
        {
            NSLog(@"%@", [connectionError localizedDescription]);
        }
    }];
}

@end
