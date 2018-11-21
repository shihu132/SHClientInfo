//
//  SHClientModel.h
//  SHClientInfo
//
//  Created by joyshow on 2018/11/21.
//  Copyright © 2018年 石虎. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHClientModel : NSObject

@property (nonatomic, strong) NSMutableArray *infoArray;

/**
 设备-硬件信息
 */
- (void)sh_setupHardwareInfo;

/**
 设备-电池信息
 */
- (void)sh_setupBatteryInfo;

/**
 设备-地址信息
 */
- (void)sh_setupAddressInfo;

/**
 设备- CPU 信息
 */
- (void)sh_setupCPUInfo;

/**
 设备-磁盘信息
 */
- (void)sh_setupDiskInfo;

@end

NS_ASSUME_NONNULL_END
