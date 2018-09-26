//
//  NSURLSession+RequestHelper.m
//  Learn Obj lv
//
//  Created by Rahardyan Bisma on 24/09/18.
//  Copyright © 2018 amsibsam. All rights reserved.
//

#import "NSURLSession+RequestHelper.h"

@implementation NSURLSession (RequestHelper)

- (void)request:(NSString*)url withMethod:(NSString*)httpMethod andParams:(NSDictionary*)params timeout:(double)timeout completionHandler:(void (^)(NSData* _Nullable data, NSURLResponse* _Nullable response, NSError* _Nullable error))completion {
    NSURL *urlRequest = [[NSURL alloc] initWithString:url];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:urlRequest];
    [request setHTTPMethod:[NSString stringWithFormat:@"%@", httpMethod]];
    [request setHTTPBody:[self httpBodyForParameters:params]];
    [request setTimeoutInterval:timeout];
    
    __weak NSURLSession *weakSelf = self;
    NSURLSessionDataTask *task = [self dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(data, response, error) ;
        });
        
//        [weakSelf invalidateAndCancel];
    }];
    
    [task resume];
}

- (NSData*)httpBodyForParameters:(NSDictionary*)parameters {
    NSMutableArray *parameterArray = [NSMutableArray array];
    
    [parameters enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *obj, BOOL *stop) {
        NSString *param = [NSString stringWithFormat:@"%@=%@", [self percentEscapeString:key], [self percentEscapeString:obj]];
        [parameterArray addObject:param];
    }];
    
    
    NSString *string = [parameterArray componentsJoinedByString:@"&"];
    
    return [string dataUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)percentEscapeString:(NSString *)string {
    NSCharacterSet *allowed = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-._~"];
    return [string stringByAddingPercentEncodingWithAllowedCharacters:allowed];
}
@end
