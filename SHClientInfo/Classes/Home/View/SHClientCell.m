//
//  SHClientCell.m
//  SHClientInfo
//
//  Created by joyshow on 2018/11/21.
//  Copyright © 2018年 石虎. All rights reserved.
//

#import "SHClientCell.h"
#import "SHInfoModel.h"

@implementation SHClientCell

- (void)awakeFromNib {
    [super awakeFromNib];
}
/**
 方式一:
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

    }
    return self;
}
 */

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *cellIdentifier = @"SHClientCell";
    SHClientCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[SHClientCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    return cell;
}

- (void)setInfoModel:(SHInfoModel *)infoModel{
    _infoModel = infoModel;
    self.textLabel.text = infoModel.infoKey;
    self.textLabel.textColor = [UIColor colorWithRed:26/255.0 green:0/255.0 blue:255/255.0 alpha:1];
    self.detailTextLabel.text = [NSString stringWithFormat:@"内容:===>%@", infoModel.infoValue];
    self.detailTextLabel.numberOfLines = 0;
    self.detailTextLabel.textColor = [UIColor colorWithRed:44/255.0 green:193/255.0 blue:78/255.0 alpha:1];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
