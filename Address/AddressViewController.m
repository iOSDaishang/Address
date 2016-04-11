//
//  AddressViewController.m
//  Address
//
//  Created by Dai on 16/3/15.
//  Copyright © 2016年 daishang. All rights reserved.
//

#import "AddressViewController.h"
#import "AddressTableViewCell.h"
#import "NSString+PinYin.h"

#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define WIDTH [UIScreen mainScreen].bounds.size.width
@interface AddressViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>

/**
 *  显示点击滑竿的字母label
 */
@property (strong, nonatomic) UILabel *sectionLab;

@end

@implementation AddressViewController

-(id)init
{
    self = [super init];
    if (self)
    {
        //注册监听
        [self addNotification];
    }
    return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    //数据初始化
    [self dataAlloc];
    //数据请求
    [self doWithRequestData];
    //创建视图
    [self createView];
    
    
}

//屏幕刚显示的时候更新数据
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    if ([AddressViewController getWhetherNeed].isNeedReload)
    {
        //移除原有数据
        [self.dataArr removeAllObjects];
        
        //数据库判断有值则显示  没值则做网络请求
//        if ()
//        {
//            //1.做网络请求  2.存入数据库  3.从数据库取数据 4.数据处理
//        }
//        else
//        {
//            //1.从数据库拿到数据  2.数据处理

//        }
        [self.addressTable reloadData];
    }
}

#pragma mark - 初始化数据
-(void)dataAlloc
{
    self.isSearchNow  = NO;
    self.searchArr    = [[NSArray alloc] init];
    self.dataArr      = [[NSMutableArray alloc] init];
    self.partName     = [[NSMutableArray alloc] init];
    
    //滑竿字母数据处理
    self.sectionArr   = [[NSMutableArray alloc] init];
    for (int i = 'A'; i<= 'Z'; i++)
    {
        NSString *str = [NSString stringWithUTF8String:(const char *)&i];
        [self.sectionArr addObject:str];
    }
    [self.sectionArr addObject:@"#"];
}

#pragma mark - 创建视图
-(void)createView
{
    //添加头部子视图
    [self addHeaderSubView];
    //创建显示滑竿点击字母的label
    [self createSectionLab];
    
    //设置tableView
    self.addressTable.tableHeaderView = self.searchView;
    self.addressTable.separatorStyle  = UITableViewCellSeparatorStyleNone;
    self.searchBar.backgroundImage    = [UIImage imageNamed:@"Address_SearchBarLowView@2x"];
//    self.searchBar.barStyle = UIBarStyleBlack;
    self.searchBar.backgroundColor    = [UIColor whiteColor];
}
//头部子视图
-(void)addHeaderSubView
{
    //头部右侧按钮
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame      = CGRectMake(WIDTH - 30, 35, 18, 20);
    
    [rightBtn setImage:[UIImage imageNamed:@"Address_UploadTicketIcon@2x"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnPress) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:rightBtn];
    
    //头部标题
    UILabel *lab      = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH/2-20, rightBtn.frame.origin.y, 40, rightBtn.frame.size.height)];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.text          = @"XXX";
    lab.textColor     = [UIColor whiteColor];
    lab.font          = [UIFont systemFontOfSize:16];
    [self.headerView addSubview:lab];
}

-(void)createSectionLab
{
    self.sectionLab                 = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH/2-75, HEIGHT/2-75, 150, 150)];
    self.sectionLab.backgroundColor = [UIColor colorWithRed:36/255.0 green:123/255.0 blue:255/255.0 alpha:0.4];
    self.sectionLab.textAlignment   = NSTextAlignmentCenter;
    self.sectionLab.textColor       = [UIColor whiteColor];
    self.sectionLab.font            = [UIFont boldSystemFontOfSize:100];
    [self.view addSubview:self.sectionLab];
    
    self.sectionLab.hidden = YES;
}

#pragma mark - 数据请求
-(void)doWithRequestData
{
    self.partName = [NSMutableArray arrayWithObjects:@"姜悦",@"葉子",@"阿凯,拽屌丝",@"菠萝酱",@"鸽子",@"博士牛",@"Blake",@"陈世美",@"李春林",@"很久？",@"avatar911",@"1530773065",@"李合营",@"刚！岚",@"猫了个咪",@"承德月嫂",@"陈阳",@"旧时光",@"不合群＇??",@"别吵静静在午休",@"�也黄鷌 ??",@"张保",@"五彩斑斓的章鱼哥",@"陈艺尹",@"千溶",@"阿飞",@"贻梅",@"酷儿/tp",@"木头",@"小张",@"就忘记我",@"dive3452",@"宋怡雪",@"d",@"Interval",@"你好啊你hh",@"itcast",@"叶子??",@"I want……",@"weilei",@"MrSilent", nil];
    //对数据进行排序
    NSArray *arr = [self.partName arrayWithPinYinFirstLetterFormat];
    
    NSMutableArray *firstLetterArr = [[NSMutableArray alloc] init];
    NSMutableArray *contentArr     = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in arr)
    {
        NSString *str1 = [dic objectForKey:@"firstLetter"];
        [firstLetterArr addObject:str1];
        NSArray *arr1  = [dic objectForKey:@"content"];
        [contentArr addObject:arr1];
    }
    
    self.dataArr = [NSMutableArray arrayWithObjects:firstLetterArr,contentArr, nil];
}

#pragma mark - 判断数据是否需要更新
//用单例设置是否需要更新
+(AddressViewController *)getWhetherNeed
{
    static AddressViewController *currentUser;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        currentUser = [[AddressViewController alloc] init];
    });
    
    return currentUser;
}

#pragma mark - 注册监听
-(void)addNotification
{
    //键盘监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}
-(void)keyboardWillShow:(NSNotification *)aNotification
{
    
}

-(void)keyboardWillHide:(NSNotification *)aNotification
{
    
}

#pragma mark - 键盘设置
-(UIToolbar *)setKeyboard
{
    UIToolbar *topView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 40)];
    [topView setBarStyle:UIBarStyleDefault];
    //左空白
    UIBarButtonItem *spaceBtn1    = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    //右边完成按钮
    UIBarButtonItem *completeBtn1 = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(pressDone)];
    
    NSArray *buttonsArray         = [NSArray arrayWithObjects:spaceBtn1,completeBtn1,nil];
    [topView setItems:buttonsArray];
    
    return topView;
}

#pragma mark - 点击事件
//顶部视图右侧点击按钮事件
-(void)rightBtnPress
{
    
}
//点击键盘完成按钮
-(void)pressDone
{
    //隐藏键盘
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

#pragma mark - tableView代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return (self.isSearchNow)?1:[[self.dataArr firstObject] count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.isSearchNow)
    {
        return self.searchArr.count;
    }
    return [self.dataArr[1][section] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId    = @"AddressViewCellId";
    AddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"AddressTableViewCell" owner:self options:nil] lastObject];
    }
    //分组中的最后一条分割线删除
    if (indexPath.row == [self.dataArr[1][indexPath.section] count]-1)
    {
        cell.lineLab.hidden = YES;
    }
    //根据是否是搜索状态传输不同的数据
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    if (self.isSearchNow)
    {
        [arr addObject:self.searchArr];
    }
    else
    {
        [arr addObject:self.dataArr];
    }
    [cell getMessage:arr[0] andWith:indexPath andWith:self.isSearchNow];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view         = [[UIView alloc] init];
    view.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 40, 10)];
    lab.text     = [self.dataArr firstObject][section];
    lab.font     = [UIFont systemFontOfSize:15];
    [view addSubview:lab];
    
    return (self.isSearchNow)?nil:view;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - 滑动删除
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
//   1.如果数据是从服务器获取的，那就直接调用接口，重新获取数据源再[tableView reloadData]就行
//
    
//    2.如果只想修改本地数据
//    if (editingStyle == UITableViewCellEditingStyleDelete)
//    {
//        [self.dataArr[1][indexPath.section] removeObjectAtIndex:[indexPath row]];
//        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationTop];
//        
//        if ([self.dataArr[1][indexPath.section] count] == 0)
//        {
//            [self.dataArr[0] removeObjectAtIndex:indexPath.section];
//            [self.dataArr[1] removeObjectAtIndex:indexPath.section];
//            
//        }
//        [self.addressTable reloadData];
//    }
    
}

#pragma mark - scrollView 代理
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

#pragma mark - searchBar代理
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    searchBar.inputAccessoryView = [self setKeyboard];
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    self.isSearchNow = YES;
    if (searchText.length == 0)
    {
        self.isSearchNow = NO;
        [self.addressTable reloadData];
    }
    else
    {
//        self.isSearchNow = YES;
        self.searchArr   = [[NSArray alloc] init];
        
        NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"self contains[cd] %@",searchText];
        self.searchArr =  [self.partName filteredArrayUsingPredicate:resultPredicate];
        NSLog(@"arr ===== %@",self.searchArr);
        
        [self.addressTable reloadData];
        
        for(int i=0; i< [self.searchBar.text length];i++)
        {
            int a = [self.searchBar.text characterAtIndex:0];
            //输入为汉字
            if( a > 0x4e00 && a < 0x9fff)
            {
                
            }
            //输入数字
            else if (a < 58 && a > 47)
            {
                
            }
            //输入字母
            else
            {
                
            }
        }

    }
}

#pragma mark - 添加滑竿
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    //滑竿背景设置成透明
    self.addressTable.sectionIndexBackgroundColor = [UIColor clearColor];
    
    return self.sectionArr;
}
//点击滑竿
-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    NSInteger count    = 0;
    NSString *titleStr = self.sectionArr[index];
    
    [self tableViewSectionIndex:title];
    
    for (int i = 0; i<[self.dataArr[0] count]; i++)
    {
        for (int j = 0; j<[self.dataArr[0] count]; j++)
        {
            if (![titleStr isEqualToString:self.dataArr[0][j]])
            {
                
            }
            else
            {
                for (NSString *sectionStr in self.dataArr[0])
                {
                    if ([titleStr isEqualToString:sectionStr])
                    {
                        return count;
                    }
                    count++;
                }
            }
        }
        //点击最后一个@“#”
        if (i == [self.dataArr[0] count]-1 || index == self.sectionArr.count-1)
        {
            return [self.dataArr[0] count];
        }
        else
        {
            titleStr = self.sectionArr[index +i+1];
        }
    }
    
    return 0;
}
//点击滑竿上的字母后屏幕中间创建一个view显示出来
-(void)tableViewSectionIndex:(NSString *)title
{
    self.sectionLab.text   = title;
    self.sectionLab.hidden = NO;
    dispatch_time_t time   = dispatch_time(DISPATCH_TIME_NOW, 2*NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        self.sectionLab.hidden = YES;
    });
    
}

#pragma mark - 移除通知
-(void)dealloc
{
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
