//
//  SHDeviceDataLibrery.h
//  SHClientInfo
//
//  Created by joyshow on 2018/11/20.
//  Copyright © 2018年 石虎. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHDeviceDataLibrery : NSObject

+ (instancetype)sharedLibrery;
/** 获取设备名称 */
- (const NSString *)getDiviceName;
/** 获取设备初始系统型号 */
- (const NSString *)getInitialVersion;
/** 获取设备支持的最高系统型号 */
- (const NSString *)getLatestVersion;
/** 获取设备电池容量，单位 mA 毫安 */
- (NSInteger)getBatteryCapacity;
/** 获取电池电压，单位 V 福特 */
- (CGFloat)getBatterVolocity;
/** 获取CPU处理器名称 */
- (const NSString *)getCPUProcessor;
@end

NS_ASSUME_NONNULL_END
