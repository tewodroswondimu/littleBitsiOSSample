//
//  LittleBitsObject.h
//  littleBitsCloudBitSample
//
//  Created by Tewodros Wondimu on 2/21/15.
//  Copyright (c) 2015 Tewodros Wondimu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LittleBitsObject : NSObject

// Great thanks to the Idiots Guide to using littleBits CloudBit API (https://gist.github.com/daniellevass/67a13943be883e88df39), Danielle Vass

/**
 *  Retrieves device information as an NSDictionary
 *
 *  @param deviceID      Your Device ID. You can find it at control.littlebitscloud.cc, after you login, choose your cloudbit on the left and click settings from the tab bar, and copy the deviceID
 *  @param authorization The authorization is the string "Bearer XXXX" where XXXX is your accessToken
 *  @param contentType   The content type is the format you want it to be returned in (should be application/json)
 *  @param accept       (should be application/vnd.littlebits.v2+json)
 *  @param complete      returns a completion block with the device info (http://developer.littlebitscloud.cc/api-http#-devices-device-id-)
 */
+ (void)retrieveDeviceInfoWithDeviceID:(NSString *)deviceID authorizationAccessToken:(NSString *)authorization theContentType:(NSString *)contentType acceptFormat:(NSString *)accept withCompletionBlock:(void(^)(NSDictionary *deviceInfo))complete;

/**
 *  Turns device connected to the cloudbit on or off depending on the dictionary that was sent to the body
 *
 *  @param deviceInfo    The device info you get from the retrieveDeviceInfoWithDeviceID method
 *  @param authorization The authorization is the string "Bearer XXXX" where XXXX is your accessToken
 *  @param contentType   The content type is the format you want it to be returned in (should be application/json)
 *  @param accept        (should be application/vnd.littlebits.v2+json)
 *  @param dictionary    The body contains a dictionry with the percent and duration keys
 */
+ (void)turnDeviceOnWithDeviceInfo:(NSDictionary *)deviceInfo authorizationAccessToken:(NSString *)authorization theContentType:(NSString *)contentType acceptFormat:(NSString *)accept bodyDictionary:(NSDictionary *)dictionary;

@end
