//
//  AddressTableViewCell.h
//  Address
//
//  Created by Dai on 16/3/16.
//  Copyright © 2016年 daishang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddressTableViewCell : UITableViewCell
/**
 *  好友头像
 */
@property (weak, nonatomic) IBOutlet UIImageView *userImgView;
/**
 *  好友名称
 */
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
/**
 *  好友电话
 */
@property (weak, nonatomic) IBOutlet UILabel *phoneNumLab;
/**
 *  分割线
 */
@property (weak, nonatomic) IBOutlet UILabel *lineLab;

/**
 *  接收数据方法
 */
-(void)getMessage:(NSMutableArray *)dataArr andWith:(NSIndexPath *)indexPath andWith:(BOOL)isSearchNow;

@end
