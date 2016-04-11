//
//  AddressViewController.h
//  Address
//
//  Created by Dai on 16/3/15.
//  Copyright © 2016年 daishang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddressViewController : UIViewController

/**
 *  顶部视图
 */
@property (weak, nonatomic) IBOutlet UIView *headerView;
/**
 *  搜索背景视图，tableView的头部视图
 */
@property (weak, nonatomic) IBOutlet UIView *searchView;
/**
 *  搜索框
 */
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
/**
 *  显示好友列表的tableView
 */
@property (weak, nonatomic) IBOutlet UITableView *addressTable;

/**
 *  存储数据的数组
 */
@property (nonatomic, strong) NSMutableArray *dataArr;
/**
 *  存储搜索好友时候的数组
 */
@property (nonatomic, strong) NSArray *searchArr;
/**
 *  滑竿数组
 */
@property (nonatomic, strong) NSMutableArray *sectionArr;
/**
 *  判断是否处于搜索状态
 */
@property (nonatomic, assign) BOOL isSearchNow;
/**
 *  判断数据是否需要更新
 */
@property (nonatomic, assign) BOOL isNeedReload;
/**
 *  装载名字的数组
 */
@property (nonatomic, strong) NSMutableArray *partName;
+(AddressViewController *)getWhetherNeed;


@end
