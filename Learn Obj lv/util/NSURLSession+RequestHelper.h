//
//  NSURLSession+RequestHelper.h
//  Learn Obj lv
//
//  Created by Rahardyan Bisma on 24/09/18.
//  Copyright © 2018 amsibsam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURLSession (RequestHelper)

- (void)request:(NSString*) url withMethod:(NSString*)httpMethod andParams:(NSDictionary*) params timeout:(double) timeout completionHandler:(void (^)(NSData *data, NSURLResponse *response, NSError *error)) completion;

- (void)request:(NSString*) url withMethod:(NSString*)httpMethod completionHandler:(void (^)(NSData *data, NSURLResponse *response, NSError *error)) completion;

@end
