//
//  AddressTableViewCell.m
//  Address
//
//  Created by Dai on 16/3/16.
//  Copyright © 2016年 daishang. All rights reserved.
//

#import "AddressTableViewCell.h"

@implementation AddressTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

-(void)getMessage:(NSMutableArray *)dataArr andWith:(NSIndexPath *)indexPath andWith:(BOOL)isSearchNow
{
    self.lineLab.frame           = CGRectMake(5, 48, self.frame.size.width - 5, 1);
    self.lineLab.backgroundColor = [UIColor colorWithRed:239/255.0 green:237/255.0 blue:237/255.0 alpha:1];
    self.nameLab.text            = (isSearchNow)?dataArr[indexPath.row]:dataArr[1][indexPath.section][indexPath.row];
    
}

@end
