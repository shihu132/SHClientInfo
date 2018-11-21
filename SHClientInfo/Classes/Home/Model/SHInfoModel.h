//
//  SHInfoModel.h
//  SHClientInfo
//
//  Created by joyshow on 2018/11/20.
//  Copyright © 2018年 石虎. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHInfoModel : NSObject
@property (nonatomic, copy)   NSString *infoKey;
@property (nonatomic, strong) NSObject *infoValue;

@end

NS_ASSUME_NONNULL_END
