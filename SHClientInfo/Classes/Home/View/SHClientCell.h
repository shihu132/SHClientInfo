//
//  SHClientCell.h
//  SHClientInfo
//
//  Created by joyshow on 2018/11/21.
//  Copyright © 2018年 石虎. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class SHInfoModel;
@interface SHClientCell : UITableViewCell
@property(nonatomic,strong)SHInfoModel *infoModel;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
