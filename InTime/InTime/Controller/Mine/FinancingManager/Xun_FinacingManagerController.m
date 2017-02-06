//
//  Xun_FinacingManagerController.m
//  InTime
//
//  Created by xunsmart on 2017/1/15.
//  Copyright © 2017年 Xunsmart. All rights reserved.
//

#import "Xun_FinacingManagerController.h"
#import "Xun_SelectBar.h"
#import "Xun_RepaymentController.h"
#import "Xun_SettleController.h"
#import "Xun_TenderController.h"
#import "Xun_TenderModel.h"
#import "Xun_RepaymentModel.h"
#import "Xun_SettletModel.h"

@interface Xun_FinacingManagerController () <Xun_SelectBarDelegate>
{
    NSMutableArray *repaymentArr_;
    NSMutableArray *settleArr_;
    NSMutableArray *tenderArr_;
    
    NSInteger lastButtonIndex_;
}

@property (nonatomic, strong) Xun_SelectBar *selectBar;
@property (nonatomic, strong) UIPageViewController *pageController;
@property (nonatomic, strong) Xun_RepaymentController *paymentController;
@property (nonatomic, strong) Xun_SettleController *settleController;
@property (nonatomic, strong) Xun_TenderController *tenderController;

@end

@implementation Xun_FinacingManagerController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavigation];
    
    repaymentArr_ = [NSMutableArray array];
    settleArr_ = [NSMutableArray array];
    tenderArr_ = [NSMutableArray array];
    
    [self setUp];
    
    [self startFinacingManagerRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark AboutUI
- (void)setNavigation
{
    self.title = @"理财管理";
    
    [self addLeftBarItem];
}

- (void)setUp
{
    self.selectBar = [[Xun_SelectBar alloc] initWithFrame:CGRectMake(0, 0, kXunScreenWidth, 40) Items:
                                    @[
                                       @"还款中",
                                       @"已结清",
                                       @"投标中"
                                        ]];
    self.selectBar.delegate = self;
    self.selectBar.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.selectBar];
    
    if (self.pageController == nil) {
        // 设置UIPageViewController的配置项
        NSDictionary *options =[NSDictionary
                                dictionaryWithObject:
                                [NSNumber
                                 numberWithInteger:
                                 UIPageViewControllerSpineLocationNone
                                 ]
                                forKey:
                                UIPageViewControllerOptionSpineLocationKey];
        
        // 实例化UIPageViewController对象，根据给定的属性
        self.pageController = [[UIPageViewController alloc]
                               initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                               navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                               options: options];
        
        // 定义“这本书”的尺寸
        _pageController.view.frame = CGRectMake(0, self.selectBar.bottom + 5, kXunScreenWidth, self.view.height - self.selectBar.height);
        
        // 让UIPageViewController对象，显示相应的页数据。
        // UIPageViewController对象要显示的页数据封装成为一个NSArray。
        // 因为我们定义UIPageViewController对象显示样式为显示一页（options参数指定）。
        // 如果要显示2页，NSArray中，应该有2个相应页数据。
        NSArray *viewControllers =[NSArray arrayWithObject:self.paymentController];
        [_pageController setViewControllers:viewControllers
                                  direction:UIPageViewControllerNavigationDirectionForward
                                   animated:NO
                                 completion:nil];
        
        // 在页面上，显示UIPageViewController对象的View
        [self addChildViewController:_pageController];
        [self.view addSubview:_pageController.view];
    }
}

#pragma mark -
#pragma mark Property Getter && Setter
- (Xun_RepaymentController *)paymentController
{
    if (_paymentController == nil) {
        _paymentController = [[Xun_RepaymentController alloc] init];
    }
    return _paymentController;
}

- (Xun_SettleController *)settleController
{
    if (_settleController == nil) {
        _settleController = [[Xun_SettleController alloc] init];
    }
    return _settleController;
}

- (Xun_TenderController *)tenderController
{
    if (_tenderController == nil) {
        _tenderController = [[Xun_TenderController alloc] init];
    }
    return _tenderController;
}

#pragma mark -
#pragma mark Xun_SelectBarDelegate
- (void)didSelectBarAtIndex:(NSInteger)buttonIndex
{
    if (lastButtonIndex_ == buttonIndex) {
        return;
    }
    
    if (buttonIndex == 0) {
        [self setCurrentPageController:self.paymentController direction:UIPageViewControllerNavigationDirectionReverse];
    }
    else if (buttonIndex == 2)
    {
        [self setCurrentPageController:self.tenderController direction:UIPageViewControllerNavigationDirectionForward];
    }
    else
    {
        UIPageViewControllerNavigationDirection direction = UIPageViewControllerNavigationDirectionForward;
        if (lastButtonIndex_ > buttonIndex) {
            direction = UIPageViewControllerNavigationDirectionReverse;
        }
        else
        {
            direction = UIPageViewControllerNavigationDirectionForward;
        }
        
        [self setCurrentPageController:self.settleController direction:direction];
    }
    
    lastButtonIndex_ = buttonIndex;
}

- (void)setCurrentPageController:(UIViewController *)controller direction:(UIPageViewControllerNavigationDirection)direction
{
    [_pageController setViewControllers:@[controller]
                              direction:direction
                               animated:YES
                             completion:nil];
}

#pragma mark -
#pragma mark Request
- (void)startFinacingManagerRequest
{
    NSDictionary *paramDic = @{
                               @"oauth_token" : [Xun_Share sharedInstance].session.oauth_token,
                               @"oauth_token_secret" : [Xun_Share sharedInstance].session.oauth_token_secret
                               };
    
    [MBProgressHUD showMessage:@"正在加载" andHideAfterDelay:Xun_TimeOut];
    
    [Xun_Util POST:[Xun_Util getServerUrlWithSuffix:Xun_AppFinacingManagerUrl] parameters:paramDic success:^(NSURLSessionDataTask *task, id responseObject, Xun_ResponseInfo *responseInfo) {
        
        [MBProgressHUD hideHUD];
        
        if ([responseInfo.status isEqualToString:Xun_RequestStatusSuccess]) {
            NSArray *repaymentArray = responseObject[@"incomePlan"];
            NSArray *settleArray = responseObject[@"yjq"];
            NSArray *tenderArray = responseObject[@"tbz"];
            
            if (repaymentArr_.count > 0) {
                [repaymentArr_ removeAllObjects];
            }
            if (settleArr_.count > 0) {
                [settleArr_ removeAllObjects];
            }
            if (tenderArr_.count > 0) {
                [tenderArr_ removeAllObjects];
            }
            
            if ([repaymentArray isKindOfClass:[NSArray class]] && repaymentArray.count > 0) {
                for (NSDictionary *dic in repaymentArray) {
                    Xun_RepaymentModel *model = [[Xun_RepaymentModel alloc] initWithJsonDic:dic];
                    [repaymentArr_ addObject:model];
                }
            }
            
            if ([settleArray isKindOfClass:[NSArray class]] && settleArray.count > 0) {
                for (NSDictionary *dic in settleArray) {
                    Xun_SettletModel *model = [[Xun_SettletModel alloc] initWithJsonDic:dic];
                    [settleArr_ addObject:model];
                }
            }
            
            if ([tenderArray isKindOfClass:[NSArray class]] && tenderArray.count > 0) {
                for (NSDictionary *dic in tenderArray) {
                    Xun_TenderModel *model = [[Xun_TenderModel alloc] initWithJsonDic:dic];
                    [tenderArr_ addObject:model];
                }
            }
            
            self.paymentController.dataArray = [NSArray arrayWithArray:repaymentArr_];
            self.settleController.dataArray = [NSArray arrayWithArray:settleArr_];
            self.tenderController.dataArray = [NSArray arrayWithArray:tenderArr_];
            
        }
        else if ([responseInfo.status isEqualToString:Xun_RequestStatusAutherror])
        {
            [self showLoginViewControllerNeedHideBottomBar:NO];
        }
        else if ([responseInfo.status isEqualToString:Xun_RequestStatusRNAuthNone])
        {
            [self showRNAuthenController];
        }
        else
        {
            [MBProgressHUD showError:responseInfo.msg];
        }
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:[error localizedDescription]];
    }];
}

@end
