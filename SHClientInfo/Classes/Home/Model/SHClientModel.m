//
//  SHClientModel.m
//  SHClientInfo
//
//  Created by joyshow on 2018/11/21.
//  Copyright © 2018年 石虎. All rights reserved.
//

#import "SHClientModel.h"
#import "SHInfoModel.h"
#import "SHDeviceInfoManager.h"
#import "SHNetWorkInfoManager.h"
#import "SHBatteryInfoManager.h"

@interface SHClientModel ()<SHBatteryInfoDelegate>

@end

@implementation SHClientModel

#pragma mark ---------------------------------------private Method

- (void)sh_setupHardwareInfo {
    
    [self sh_addInfoWithKey:@"/------------- Hardware Info -------------/" infoValue:@""];
    const NSString *deviceName = [[SHDeviceInfoManager sharedManager] getDeviceName];
    [self sh_addInfoWithKey:@"设备型号" infoValue:[deviceName copy]];
    
    NSString *iPhoneName = [UIDevice currentDevice].name;
    [self sh_addInfoWithKey:@"设备名称" infoValue:iPhoneName];
    
    NSString *deviceColor = [[SHDeviceInfoManager sharedManager] getDeviceColor];
    [self sh_addInfoWithKey:@"设备颜色(Private API)" infoValue:deviceColor];
    
    NSString *deviceEnclosureColor = [[SHDeviceInfoManager sharedManager] getDeviceEnclosureColor];
    [self sh_addInfoWithKey:@"设备外壳颜色(Private API)" infoValue:deviceEnclosureColor];
    
    NSString *appVerion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [self sh_addInfoWithKey:@"app版本号" infoValue:appVerion];
    
    NSString *device_model = [[SHDeviceInfoManager sharedManager] getDeviceModel];
    [self sh_addInfoWithKey:@"device_model" infoValue:device_model];
    
    NSString *localizedModel = [UIDevice currentDevice].localizedModel;
    [self sh_addInfoWithKey:@"localizedModel" infoValue:localizedModel];
    
    NSString *systemName = [UIDevice currentDevice].systemName;
    [self sh_addInfoWithKey:@"当前系统名称" infoValue:systemName];
    
    NSString *systemVersion = [UIDevice currentDevice].systemVersion;
    [self sh_addInfoWithKey:@"当前系统版本号" infoValue:systemVersion];
    
    const NSString *initialFirmware = [[SHDeviceInfoManager sharedManager] getInitialFirmware];
    [self sh_addInfoWithKey:@"设备支持最低系统版本" infoValue:[initialFirmware copy]];
    
    const NSString *latestFirmware = [[SHDeviceInfoManager sharedManager] getLatestFirmware];
    [self sh_addInfoWithKey:@"设备支持的最高系统版本" infoValue:[latestFirmware copy]];
    
    BOOL canMakePhoneCall = [SHDeviceInfoManager sharedManager].canMakePhoneCall;
    [self sh_addInfoWithKey:@"能否打电话" infoValue:@(canMakePhoneCall)];
    
    NSDate *systemUptime = [[SHDeviceInfoManager sharedManager] getSystemUptime];
    [self sh_addInfoWithKey:@"设备上次重启的时间" infoValue:systemUptime];
    
    NSUInteger busFrequency = [[SHDeviceInfoManager sharedManager] getBusFrequency];
    [self sh_addInfoWithKey:@"当前设备的总线频率Bus Frequency" infoValue:@(busFrequency)];
    
    NSUInteger ramSize = [[SHDeviceInfoManager sharedManager] getRamSize];
    [self sh_addInfoWithKey:@"当前设备的主存大小(随机存取存储器（Random Access Memory)）" infoValue:@(ramSize)];
}

- (void)sh_setupBatteryInfo {
    [self sh_addInfoWithKey:@"/------------- Battery Info -------------/" infoValue:@""];
    SHBatteryInfoManager *batteryManager = [SHBatteryInfoManager sharedManager];
    batteryManager.delegate = self;
    [batteryManager startBatteryMonitoring];
    
    CGFloat batteryLevel = [[UIDevice currentDevice] batteryLevel];
    NSString *levelValue = [NSString stringWithFormat:@"%.2f", batteryLevel];
    [self sh_addInfoWithKey:@"电池电量" infoValue:levelValue];
    
    NSInteger batteryCapacity = batteryManager.capacity;
    NSString *capacityValue = [NSString stringWithFormat:@"%ld mA", batteryCapacity];
    [self sh_addInfoWithKey:@"电池容量" infoValue:capacityValue];
    
    CGFloat batteryMAH = batteryCapacity * batteryLevel;
    NSString *mahValue = [NSString stringWithFormat:@"%.2f mA", batteryMAH];
    [self sh_addInfoWithKey:@"当前电池剩余电量" infoValue:mahValue];
    
    CGFloat batteryVoltage = batteryManager.voltage;
    NSString *voltageValue = [NSString stringWithFormat:@"%.2f V", batteryVoltage];
    [self sh_addInfoWithKey:@"电池电压" infoValue:voltageValue];
    
    NSString *batterStatus = batteryManager.status ? : @"unkonwn";
    [self sh_addInfoWithKey:@"电池状态" infoValue:batterStatus];
}

- (void)sh_setupAddressInfo {
    [self sh_addInfoWithKey:@"/------------- IP && Address -------------/" infoValue:@""];
    // 广告位标识符：在同一个设备上的所有App都会取到相同的值，是苹果专门给各广告提供商用来追踪用户而设的，用户可以在 设置|隐私|广告追踪里重置此id的值，或限制此id的使用，故此id有可能会取不到值，但好在Apple默认是允许追踪的，而且一般用户都不知道有这么个设置，所以基本上用来监测推广效果，是戳戳有余了
    NSString *idfa = [[SHDeviceInfoManager sharedManager] getIDFA];
    [self sh_addInfoWithKey:@"广告位标识符idfa" infoValue:idfa];
    
    //  UUID是Universally Unique Identifier的缩写，中文意思是通用唯一识别码。它是让分布式系统中的所有元素，都能有唯一的辨识资讯，而不需要透过中央控制端来做辨识资讯的指 定。这样，每个人都可以建立不与其它人冲突的 UUID。在此情况下，就不需考虑数据库建立时的名称重复问题。苹果公司建议使用UUID为应用生成唯一标识字符串。
    NSString *uuid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    [self sh_addInfoWithKey:@"唯一识别码uuid" infoValue:uuid];
    
    NSString *device_token_crc32 = [[NSUserDefaults standardUserDefaults] objectForKey:@"device_token_crc32"] ? : @"";
    [self sh_addInfoWithKey:@"device_token_crc32真机测试才会显示" infoValue:device_token_crc32];
    
    NSString *macAddress = [[SHDeviceInfoManager sharedManager] getMacAddress];
    [self sh_addInfoWithKey:@"macAddress" infoValue:macAddress];
    
    NSString *deviceIP = [[SHNetWorkInfoManager sharedManager] getDeviceIPAddresses];
    [self sh_addInfoWithKey:@"deviceIP" infoValue:deviceIP];
    
    NSString *cellIP = [[SHNetWorkInfoManager sharedManager] getIpAddressCell];
    [self sh_addInfoWithKey:@"蜂窝地址" infoValue:cellIP];
    
    NSString *wifiIP = [[SHNetWorkInfoManager sharedManager] getIpAddressWIFI];
    [self sh_addInfoWithKey:@"WIFI IP地址" infoValue:wifiIP];
}

- (void)sh_setupCPUInfo {
    [self sh_addInfoWithKey:@"/------------- CPU Info -------------/" infoValue:@""];
    NSString *cpuName = [[SHDeviceInfoManager sharedManager] getCPUProcessor];
    [self sh_addInfoWithKey:@"CPU 处理器名称" infoValue:cpuName];
    
    NSUInteger cpuCount = [[SHDeviceInfoManager sharedManager] getCPUCount];
    [self sh_addInfoWithKey:@"CPU总数目" infoValue:@(cpuCount)];
    
    CGFloat cpuUsage = [[SHDeviceInfoManager sharedManager] getCPUUsage];
    [self sh_addInfoWithKey:@"CPU使用的总比例" infoValue:@(cpuUsage)];
    
    NSUInteger cpuFrequency = [[SHDeviceInfoManager sharedManager] getCPUFrequency];
    [self sh_addInfoWithKey:@"CPU 频率" infoValue:@(cpuFrequency)];
    
    NSArray *perCPUArr = [[SHDeviceInfoManager sharedManager] getPerCPUUsage];
    NSMutableString *perCPUUsage = [NSMutableString string];
    for (NSNumber *per in perCPUArr) {
        
        [perCPUUsage appendFormat:@"%.2f<-->", per.floatValue];
    }
    [self sh_addInfoWithKey:@"单个CPU使用比例" infoValue:perCPUUsage];
}

- (void)sh_setupDiskInfo {
    [self sh_addInfoWithKey:@"/------------- Disk && Memory -------------/" infoValue:@""];
    NSString *applicationSize = [[SHDeviceInfoManager sharedManager] getApplicationSize];
    [self sh_addInfoWithKey:@"当前 App 所占内存空间" infoValue:applicationSize];
    
    int64_t totalDisk = [[SHDeviceInfoManager sharedManager] getTotalDiskSpace];
    NSString *totalDiskInfo = [NSString stringWithFormat:@"== %.2f MB == %.2f GB", totalDisk/1024/1024.0, totalDisk/1024/1024/1024.0];
    [self sh_addInfoWithKey:@"磁盘总空间" infoValue:totalDiskInfo];
    
    int64_t usedDisk = [[SHDeviceInfoManager sharedManager] getUsedDiskSpace];
    NSString *usedDiskInfo = [NSString stringWithFormat:@" == %.2f MB == %.2f GB", usedDisk/1024/1024.0, usedDisk/1024/1024/1024.0];
    [self sh_addInfoWithKey:@"磁盘 已使用空间" infoValue:usedDiskInfo];
    
    int64_t freeDisk = [[SHDeviceInfoManager sharedManager] getFreeDiskSpace];
    NSString *freeDiskInfo = [NSString stringWithFormat:@" %.2f MB == %.2f GB", freeDisk/1024/1024.0, freeDisk/1024/1024/1024.0];
    
    [self sh_addInfoWithKey:@"磁盘空闲空间" infoValue:freeDiskInfo];
    
    int64_t totalMemory = [[SHDeviceInfoManager sharedManager] getTotalMemory];
    NSString *totalMemoryInfo = [NSString stringWithFormat:@" %.2f MB == %.2f GB", totalMemory/1024/1024.0, totalMemory/1024/1024/1024.0];
    [self sh_addInfoWithKey:@"系统总内存空间" infoValue:totalMemoryInfo];
    
    int64_t freeMemory = [[SHDeviceInfoManager sharedManager] getFreeMemory];
    NSString *freeMemoryInfo = [NSString stringWithFormat:@" %.2f MB == %.2f GB", freeMemory/1024/1024.0, freeMemory/1024/1024/1024.0];
    [self sh_addInfoWithKey:@"空闲的内存空间" infoValue:freeMemoryInfo];
    
    int64_t usedMemory = [[SHDeviceInfoManager sharedManager] getFreeDiskSpace];
    NSString *usedMemoryInfo = [NSString stringWithFormat:@" %.2f MB == %.2f GB", usedMemory/1024/1024.0, usedMemory/1024/1024/1024.0];
    [self sh_addInfoWithKey:@"已使用的内存空间" infoValue:usedMemoryInfo];
    
    int64_t activeMemory = [[SHDeviceInfoManager sharedManager] getActiveMemory];
    NSString *activeMemoryInfo = [NSString stringWithFormat:@"正在使用或者很短时间内被使用过 %.2f MB == %.2f GB", activeMemory/1024/1024.0, activeMemory/1024/1024/1024.0];
    [self sh_addInfoWithKey:@"活跃的内存" infoValue:activeMemoryInfo];
    
    int64_t inActiveMemory = [[SHDeviceInfoManager sharedManager] getInActiveMemory];
    NSString *inActiveMemoryInfo = [NSString stringWithFormat:@"但是目前处于不活跃状态的内存 %.2f MB == %.2f GB", inActiveMemory/1024/1024.0, inActiveMemory/1024/1024/1024.0];
    [self sh_addInfoWithKey:@"最近使用过" infoValue:inActiveMemoryInfo];
    
    int64_t wiredMemory = [[SHDeviceInfoManager sharedManager] getWiredMemory];
    NSString *wiredMemoryInfo = [NSString stringWithFormat:@"framework、用户级别的应用无法分配 %.2f MB == %.2f GB", wiredMemory/1024/1024.0, wiredMemory/1024/1024/1024.0];
    [self sh_addInfoWithKey:@"用来存放内核和数据结构的内存" infoValue:wiredMemoryInfo];
    
    int64_t purgableMemory = [[SHDeviceInfoManager sharedManager] getPurgableMemory];
    NSString *purgableMemoryInfo = [NSString stringWithFormat:@"大对象存放所需的大块内存空间 %.2f MB == %.2f GB", purgableMemory/1024/1024.0, purgableMemory/1024/1024/1024.0];
    [self sh_addInfoWithKey:@"可释放的内存空间：内存吃紧自动释放" infoValue:purgableMemoryInfo];
}

#pragma mark----------------------------------private method

- (void)sh_addInfoWithKey:(NSString *)infoKey infoValue:(NSObject *)infoValue {
    
    SHInfoModel *infoModel = [[SHInfoModel alloc] init];
    infoModel.infoKey = infoKey;
    infoModel.infoValue = infoValue;
    NSLog(@"[]== %@---%@", infoKey, infoValue);
    [self.infoArray addObject:infoModel];
}

#pragma mark----------------------------------getter and setter

- (NSMutableArray *)infoArray {
    if (!_infoArray) {
        _infoArray = [NSMutableArray array];
    }
    return _infoArray;
}

#pragma mark----------------------------------BatteryInfoDelegate
- (void)batteryStatusUpdated {
#warning 当电池状态改变时，会调用该方法，应该在此处reload对应的cell，进行更新UI操作
}

#pragma mark----------------------------------event response
/**
 事件响应
 */

@end
