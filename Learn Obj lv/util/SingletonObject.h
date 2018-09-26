//
//  SingletonObject.h
//  Learn Obj lv
//
//  Created by Rahardyan Bisma Setya Putra on 26/09/18.
//  Copyright © 2018 amsibsam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SingletonObject : NSObject
@property (copy, nonatomic) NSString *value;

+ (instancetype) sharedInstance;
@end
