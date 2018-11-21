//
//  SHNetWorkInfoManager.h
//  SHClientInfo
//
//  Created by joyshow on 2018/11/20.
//  Copyright © 2018年 石虎. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHNetWorkInfoManager : NSObject

+ (instancetype)sharedManager;

/** 获取ip */
- (NSString *)getDeviceIPAddresses;

- (NSString *)getIpAddressWIFI;
- (NSString *)getIpAddressCell;
@end

NS_ASSUME_NONNULL_END
