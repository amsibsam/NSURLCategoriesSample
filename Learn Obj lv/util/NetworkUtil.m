//
//  NSObject+NetworkUtil.m
//  Learn ObcjC
//
//  Created by MTMAC16 on 21/09/18.
//  Copyright © 2018 bism. All rights reserved.
//

#import "NetworkUtil.h"

@implementation NetworkUtil
- (void)doNetworkRequest {
    [self.delegate successGetData:@"success"];
}
@end
