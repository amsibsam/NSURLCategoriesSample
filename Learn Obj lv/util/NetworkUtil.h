//
//  NSObject+NetworkUtil.h
//  Learn ObcjC
//
//  Created by MTMAC16 on 21/09/18.
//  Copyright © 2018 bism. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NetworkDelegate
@required
- (void)successGetData:(NSString*)data;
@end

@interface NetworkUtil: NSObject
@property (weak, nonatomic) id<NetworkDelegate> delegate;
- (void)doNetworkRequest;
@end
