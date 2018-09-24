//
//  NSURLSession+RequestHelper.m
//  Learn Obj lv
//
//  Created by Rahardyan Bisma on 24/09/18.
//  Copyright © 2018 amsibsam. All rights reserved.
//

#import "NSURLSession+RequestHelper.h"

@implementation NSURLSession (RequestHelper)
- (void)request:(NSString *)url withMethod:(NSString *)httpMethod completionHandler:(void (^)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))completion {
    NSURL *urlRequest = [[NSURL alloc] initWithString:url];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:urlRequest];
    [request setHTTPMethod:[NSString stringWithFormat:@"%@", httpMethod]];
    
    [[[NSURLSession sessionWithConfiguration:NSURLSessionConfiguration.defaultSessionConfiguration] dataTaskWithRequest:request completionHandler:completion] resume];
}

- (void)request:(NSString *)url withMethod:(NSString*) httpMethod andParams:(NSDictionary *)params timeout:(NSTimeInterval *)timeout completionHandler:(void (^)(NSData*, NSURLResponse*, NSError*))completion {
    NSURL *urlRequest = [[NSURL alloc] initWithString:url];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:urlRequest];
    [request setHTTPMethod:[NSString stringWithFormat:@"%@", httpMethod]];
    [request setHTTPBody:[self httpBodyForParameters:params]];

}

- (NSData *)httpBodyForParameters:(NSDictionary *)parameters {
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
