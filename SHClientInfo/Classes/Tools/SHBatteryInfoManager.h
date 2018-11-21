//
//  SHBatteryInfoManager.h
//  SHClientInfo
//
//  Created by joyshow on 2018/11/20.
//  Copyright © 2018年 石虎. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol SHBatteryInfoDelegate
- (void)batteryStatusUpdated;
@end
NS_ASSUME_NONNULL_BEGIN

@interface SHBatteryInfoManager : NSObject
@property (nonatomic, weak) id<SHBatteryInfoDelegate> delegate;

@property (nonatomic, assign) NSUInteger capacity;
@property (nonatomic, assign) CGFloat voltage;

@property (nonatomic, assign) NSUInteger levelPercent;
@property (nonatomic, assign) NSUInteger levelMAH;
@property (nonatomic, copy)   NSString *status;

+ (instancetype)sharedManager;
/** 开始监测电池电量 */
- (void)startBatteryMonitoring;
/** 停止监测电池电量 */
- (void)stopBatteryMonitoring;
@end

NS_ASSUME_NONNULL_END
