//
//  SingletonObject.m
//  Learn Obj lv
//
//  Created by Rahardyan Bisma Setya Putra on 26/09/18.
//  Copyright © 2018 amsibsam. All rights reserved.
//

#import "SingletonObject.h"

@implementation SingletonObject
+ (instancetype) sharedInstance {
    static id sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}
@end
