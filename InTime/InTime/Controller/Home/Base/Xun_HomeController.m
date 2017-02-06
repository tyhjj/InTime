//
//  Xun_HomeController.m
//  InTime
//
//  Created by xunsmart on 2017/1/11.
//  Copyright © 2017年 Xunsmart. All rights reserved.
//

#import "Xun_HomeController.h"
#import "iCarousel.h"
#import "Xun_IncomeCell.h"
#import "Xun_NewExclusiveCell.h"
#import "Xun_FinacingCell.h"
#import "Xun_IncomeHeaderView.h"
#import "Xun_NewExclusiveHeaderView.h"
#import "Xun_FinacingHeaderView.h"
#import "Xun_AdvertiseModel.h"
#import "Xun_AdvertiseDetailController.h"
#import "Xun_InvestmentDetailController.h"

@interface Xun_HomeController () <UITableViewDelegate, UITableViewDataSource, iCarouselDataSource, iCarouselDelegate>
{
    NSMutableArray *adsArr_;
    NSMutableArray *proArr_;
    NSMutableArray *newArr_;
    
    NSTimer *advTimer_;
}

@property (weak, nonatomic) IBOutlet UITableView *contentTableView;
@property (nonatomic, strong) iCarousel *icarousel;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) Xun_IncomeModel *incomeModel;

@end

@implementation Xun_HomeController

#pragma mark -
#pragma mark Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"点时贷";
    self.tabBarItem.title = @"首页";
    
    [self setUp];
    
    adsArr_ = [NSMutableArray array];
    proArr_ = [NSMutableArray array];
    newArr_ = [NSMutableArray array];
    
    [self startHomePageRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark AboutUI
- (void)setUp
{
    self.contentTableView.tableHeaderView = self.icarousel;
//    self.contentTableView.sectionHeaderHeight = 35.0f;
    self.contentTableView.sectionFooterHeight = 10.0f;
    
    MJRefreshGifHeader *gifHeader = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        [self startHomePageRequest];
    }];
    [gifHeader setImages:@[[UIImage imageNamed:@"login_logo.png"]] forState:MJRefreshStateIdle];
    self.contentTableView.mj_header = gifHeader;
    
    [self.contentTableView registerNib:[UINib nibWithNibName:@"Xun_IncomeCell" bundle:nil] forCellReuseIdentifier:@"incomcell"];
    [self.contentTableView registerNib:[UINib nibWithNibName:@"Xun_NewExclusiveCell" bundle:nil] forCellReuseIdentifier:@"exclusiveCell"];
    [self.contentTableView registerNib:[UINib nibWithNibName:@"Xun_FinacingCell" bundle:nil] forCellReuseIdentifier:@"finacingCell"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        return 250.0f;
    }
    else if (indexPath.section == 0){
        return 140.0f;
    }
    else
    {
        return 120.0f;
    }
}

- (void)updateContentWithJson:(NSDictionary *)jsonDic
{
    NSArray *adsArray = jsonDic[@"ad"];
    
    if (adsArr_.count > 0)
    {
        [adsArr_ removeAllObjects];
    }
    
    if ([adsArray isKindOfClass:[NSArray class]] && adsArray.count > 0) {
        
        for (NSDictionary *dic in adsArray) {
            Xun_AdvertiseModel *model = [[Xun_AdvertiseModel alloc] initWithJsonDic:dic];
            [adsArr_ addObject:model];
        }
        
        self.pageControl.numberOfPages = adsArr_.count;
        [self startAdverAnimation];
        [self.icarousel reloadData];
    }
    
    NSArray *proArray = jsonDic[@"project"];
    

    if (proArr_.count > 0)
    {
        [proArr_ removeAllObjects];
    }
    
    if (newArr_.count > 0) {
        [newArr_ removeAllObjects];
    }
    
    if ([proArray isKindOfClass:[NSArray class]] && proArray.count > 0) {
        
        
        for (NSDictionary *dic in proArray) {
            Xun_FinacingProModel *model = [[Xun_FinacingProModel alloc] initWithJsonDic:dic];
            if ([model.is_new  isEqualToString:@"0"]) {
                [proArr_ addObject:model];
            }
            else
            {
                [newArr_ addObject:model];
            }
        }
        
    }
    
    if (self.incomeModel) {
        self.incomeModel = nil;
    }
    self.incomeModel = [[Xun_IncomeModel alloc] initWithJsonDic:jsonDic[@"tu"]];
    
    [self.contentTableView reloadData];
    
}

#pragma mark -
#pragma mark Property Getter && Setter
- (iCarousel *)icarousel
{
    if (_icarousel == nil) {
        _icarousel = [[iCarousel alloc] initWithFrame:CGRectMake(0, 0, kXunScreenWidth, kXunScreenWidth * 350 / 750)];
        _icarousel.delegate = self;
        _icarousel.dataSource = self;
        _icarousel.scrollSpeed = 0.8;
        self.pageControl.frame = CGRectMake(0, _icarousel.height - 10 - 10, 100, 10);
        self.pageControl.centerX = _icarousel.width / 2.0;
        self.pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        self.pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        [_icarousel addSubview:self.pageControl];
    }
    return _icarousel;
}

- (UIPageControl *)pageControl
{
    if (_pageControl == nil) {
        _pageControl = [[UIPageControl alloc] init];
    }
    return _pageControl;
}

#pragma mark -
#pragma mark Action 
- (void)showInvestmentDetailControllerWithProModel:(Xun_FinacingProModel *)model
{
    if ([Xun_Util isLogined]) {
        //进入详情
        Xun_InvestmentDetailController *detailVC = [[Xun_InvestmentDetailController alloc] init];
        detailVC.proModel = model;
        detailVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:detailVC animated:YES];
    }
    else
    {
        [self showLoginViewControllerNeedHideBottomBar:YES];
    }
}

#pragma mark -
#pragma mark UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    else if (section == 1)
    {
        return newArr_.count;
    }
    else
    {
        return proArr_.count;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        Xun_IncomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"incomcell"];
        
        cell.model = self.incomeModel;
        
        return cell;
    }
    else if (indexPath.section == 1)
    {
        Xun_NewExclusiveCell *cell = [tableView dequeueReusableCellWithIdentifier:@"exclusiveCell"];
        
        cell.model = newArr_[indexPath.row];
        
        cell.PurchaseBtnClickHandler = ^(Xun_NewExclusiveCell *cell) {
            [self showInvestmentDetailControllerWithProModel:cell.model];
        };
        
        return cell;
    }
    else
    {
        Xun_FinacingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"finacingCell"];
        
        cell.model = proArr_[indexPath.row];
        
        cell.PurchaseBtnClickHandler = ^(Xun_FinacingCell *cell) {
            [self showInvestmentDetailControllerWithProModel:cell.model];
        };
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1 && newArr_.count == 0) {
        return 0;
    }
    else{
        return 35.0f;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:@"Xun_IncomeHeaderView" owner:nil options:nil];
        Xun_IncomeHeaderView *headerView = [nibContents lastObject];
        headerView.frame = CGRectMake(0, 0, kXunScreenWidth, 35.0f);
        headerView.ShareCompletitonHandler = ^(){
            [Xun_Util shareFromController:nil];
        };
        return headerView;
    }
    else if (section == 1)
    {
        if (newArr_.count == 0) {
            return nil;
        }
        else
        {
             NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:@"Xun_NewExclusiveHeaderView" owner:nil options:nil];
             Xun_NewExclusiveHeaderView *headerView = [nibContents lastObject];
             headerView.frame = CGRectMake(0, 0, kXunScreenWidth, 35.0f);
             return headerView;
        }
    }
    else
    {
        NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:@"Xun_FinacingHeaderView" owner:nil options:nil];
        Xun_FinacingHeaderView *headerView = [nibContents lastObject];
        headerView.frame = CGRectMake(0, 0, kXunScreenWidth, 35.0f);
        return headerView;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kXunScreenWidth, 10.0f)];
    footerView.backgroundColor = [UIColor clearColor];
    return footerView;
}

#pragma mark -
#pragma mark AdvertisementAnimation
- (void)startAdverAnimation
{
    if (advTimer_ == nil) {
        advTimer_ = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(adverAnimation:) userInfo:nil repeats:YES];
    }
    [advTimer_ fire];
}

- (void)adverAnimation:(NSTimer *)timer
{
    NSInteger index = self.icarousel.currentItemIndex + 1;
    if (index == adsArr_.count ) {
        index = 0;
    }
    [self.icarousel scrollToItemAtIndex:index
                               duration:2.5];
}

#pragma mark -
#pragma mark iCarouselDataSource
- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return adsArr_.count;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    Xun_AdvertiseModel *model = adsArr_[index];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.icarousel.bounds];
//    imageView.image = [UIImage imageNamed:@"home_banner.png"];
    [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", model.imgurl]] placeholderImage:[UIImage imageNamed:@"home_banner.png"]];
    return imageView;
}

- (void)carouselDidEndScrollingAnimation:(iCarousel *)carousel
{
    self.pageControl.currentPage = carousel.currentItemIndex;
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
    Xun_AdvertiseModel *model = adsArr_[index];
    
    if (![Xun_Util strNilOrEmpty:model.url]) {
        Xun_AdvertiseDetailController *detailVC = [[Xun_AdvertiseDetailController alloc] init];
        detailVC.webUrl = model.url;
        detailVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:detailVC animated:YES];
    }
}

#pragma mark -
#pragma mark Request
- (void)startHomePageRequest
{
    [MBProgressHUD showMessage:@"正在加载" toView:self.tabBarController.view andHideAfterDelay:Xun_TimeOut];
    
    [Xun_Util POST:[Xun_Util getServerUrlWithSuffix:Xun_AppHomeUrl] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject, Xun_ResponseInfo *responseInfo) {
        
        [MBProgressHUD hideHUDForView:self.tabBarController.view];
        
        if ([responseInfo.status isEqualToString:Xun_RequestStatusSuccess]) {
            [self updateContentWithJson:responseObject];
        }
        else
        {
            [MBProgressHUD showError:responseInfo.msg];
        }
        
        [self.contentTableView.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [MBProgressHUD hideHUDForView:self.tabBarController.view];
        [MBProgressHUD showError:[error localizedDescription]];
         [self.contentTableView.mj_header endRefreshing];
    }];
}

@end
