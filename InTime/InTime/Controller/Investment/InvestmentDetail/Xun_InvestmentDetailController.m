//
//  Xun_InvestmentDetailController.m
//  InTime
//
//  Created by xunsmart on 2017/1/13.
//  Copyright © 2017年 Xunsmart. All rights reserved.
//

#import "Xun_InvestmentDetailController.h"
#import "Xun_SelectBar.h"
#import "Xun_ProductInfoController.h"
#import "Xun_RiskControlController.h"
#import "Xun_PaymentScheduleController.h"
#import "Xun_InvRecordsController.h"
#import "Xun_ProDetailModel.h"
#import "Xun_PaymentScheduleModel.h"
#import "Xun_InvRecordModel.h"
#import "Xun_CalculatorView.h"
#import "Xun_ActionSheet.h"
#import "Xun_RechargeController.h"
//#import "IQKeyboardManager.h"

@interface Xun_InvestmentDetailController () <Xun_SelectBarDelegate, UITextFieldDelegate>
{
    NSInteger lastButtonIndex_;
    
    NSMutableArray *planModelArr_;
    NSMutableArray *purchaseModelArr_;
    
    Xun_ActionSheet *actionSheet_;
}

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UILabel *rateLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UILabel *progressLabel;
@property (weak, nonatomic) IBOutlet UILabel *fromInvLabel;
@property (weak, nonatomic) IBOutlet UILabel *unInvLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UITextField *invTextField;
@property (weak, nonatomic) IBOutlet UILabel *balanceLabel;


@property (nonatomic, strong) Xun_SelectBar *selectBar;

@property (nonatomic, strong) UIPageViewController *pageController;
@property (nonatomic, strong) Xun_ProductInfoController *proInfoController;
@property (nonatomic, strong) Xun_RiskControlController *riskCController;
@property (nonatomic, strong) Xun_PaymentScheduleController *scheduleController;
@property (nonatomic, strong) Xun_InvRecordsController *invRecordsController;
@property (nonatomic, strong) Xun_ProDetailModel *detailModel;
@property (nonatomic, copy) NSString *myMoney;

@end

@implementation Xun_InvestmentDetailController

#pragma mark -
#pragma mark Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setNavigation];
    
    lastButtonIndex_ = 0;
    
    [self startInvestDetailRequest];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
//    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
    [self setUp];
}

#pragma mark -
#pragma mark Property Getter && Setter
- (Xun_ProductInfoController *)proInfoController
{
    if (_proInfoController == nil) {
        _proInfoController = [[Xun_ProductInfoController alloc] init];
    }
    return _proInfoController;
}

- (Xun_RiskControlController *)riskCController
{
    if (_riskCController == nil) {
        _riskCController = [[Xun_RiskControlController alloc] init];
    }
    return _riskCController;
}

- (Xun_PaymentScheduleController *)scheduleController
{
    if (_scheduleController == nil) {
        _scheduleController = [[Xun_PaymentScheduleController alloc] init];
    }
    return _scheduleController;
}

- (Xun_InvRecordsController *)invRecordsController
{
    if (_invRecordsController == nil) {
        _invRecordsController = [[Xun_InvRecordsController alloc] init];
    }
    return _invRecordsController;
}

#pragma mark -
#pragma mark AboutUI
- (void)setNavigation
{
    self.title = @"投资详情";
    
    [self addLeftBarItem];
}

- (void)setUp
{
    if (self.selectBar == nil) {
        self.selectBar = [[Xun_SelectBar alloc] initWithFrame:CGRectMake(0, self.view.height, kXunScreenWidth, 40) Items:@[
                                                                                                                           @"项目信息",
                                                                                                                           @"贷前风控",
                                                                                                                           @"回款进度",
                                                                                                                           @"投资记录"
                                                                                                                           ]];
        self.selectBar.backgroundColor = [UIColor whiteColor];
        self.selectBar.delegate = self;
        [self.containerView addSubview:self.selectBar];
    }
    
    self.invTextField.inputView = [UIView new];
    self.invTextField.delegate = self;
    
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
        _pageController.view.frame = CGRectMake(0, self.selectBar.bottom + 5, kXunScreenWidth, self.view.height - self.selectBar.height - 5 - 49);
        
        // 让UIPageViewController对象，显示相应的页数据。
        // UIPageViewController对象要显示的页数据封装成为一个NSArray。
        // 因为我们定义UIPageViewController对象显示样式为显示一页（options参数指定）。
        // 如果要显示2页，NSArray中，应该有2个相应页数据。
        NSArray *viewControllers =[NSArray arrayWithObject:self.proInfoController];
        [_pageController setViewControllers:viewControllers
                                  direction:UIPageViewControllerNavigationDirectionForward
                                   animated:NO
                                 completion:nil];
        
        // 在页面上，显示UIPageViewController对象的View
        [self addChildViewController:_pageController];
        [self.containerView addSubview:_pageController.view];
    }
}

- (void)updateContent
{
    self.rateLabel.text = [NSString stringWithFormat:@"%.2f%%", [self.detailModel.rate floatValue]];
    float progress = [self.detailModel.amount floatValue] / [self.detailModel.money floatValue];
    self.progressView.progress = progress;
    self.progressLabel.text = [NSString stringWithFormat:@"%.2f%%", progress * 100];
    self.fromInvLabel.text = [NSString stringWithFormat:@"%.2f", [self.detailModel.unit floatValue]];
    self.unInvLabel.text = [NSString stringWithFormat:@"%.2f", [self.detailModel.money floatValue] - [self.detailModel.amount floatValue]];
    self.typeLabel.text = [self payTypeWithType:self.detailModel.interest_paytype];
    self.invTextField.placeholder = [NSString stringWithFormat:@"%@元起，需为%@元的整数倍", self.detailModel.unit, self.detailModel.unit];
    self.balanceLabel.text = [NSString stringWithFormat:@"%.2f", [self.myMoney floatValue]];
}

- (NSString *)payTypeWithType:(NSString *)type
{
    if ([type isEqualToString:@"1"]) {
        return @"等额本息";
    }
    else if ([type isEqualToString:@"2"])
    {
        return @"每月付息到期还本";
    }
    else
    {
        return @"本息到期一次付清";
    }
}

#pragma mark -
#pragma mark Action
- (IBAction)showCalculatorAction:(id)sender {
    [self showCalculatorView];
}

- (IBAction)investmentAction:(id)sender {
    if ([self.myMoney integerValue] < [self.invTextField.text integerValue]) {
        [MBProgressHUD showError:@"余额不足，请充值!"];
    }
    else
    {
        [self startInvestProductRequest];
    }
}

- (IBAction)rechargeAction:(id)sender {
    Xun_RechargeController *rechargeVC = [[Xun_RechargeController alloc] init];
    rechargeVC.balance = self.myMoney;
    [self.navigationController pushViewController:rechargeVC animated:YES];
}

- (void)showCalculatorView
{
    if (self.detailModel == nil) {
        [MBProgressHUD showError:@"未能获取详情信息，请稍后重试!"];
        return ;
    }
    
    actionSheet_ = [[Xun_ActionSheet alloc] init];
    
    NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:@"Xun_CalculatorView" owner:nil options:nil];
    Xun_CalculatorView *calView = [nibContents lastObject];
    calView.detailModel = self.detailModel;
    calView.closeBtnClickHandler = ^() {
        [actionSheet_ dismissModalView];
    };
    calView.InvestmentBtnClickHandler = ^(NSInteger investMoney) {
        if (investMoney % [self.detailModel.unit integerValue] == 0) {
            //可以投资
            self.invTextField.text = [NSString stringWithFormat:@"%ld", investMoney];
        }
        else
        {
            [MBProgressHUD showError:@"必须为起投金额的整数倍!"];
        }
        
        [actionSheet_ dismissModalView];
    };
    calView.frame = CGRectMake(0, 0, kXunScreenWidth, 390);
    
    [actionSheet_ addView:calView];
    
    [actionSheet_ show];
}

#pragma mark -
#pragma mark UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == self.invTextField) {
        [self showCalculatorView];
        [self.invTextField resignFirstResponder];
    }
}

#pragma mark -
#pragma mark Xun_SelectBarDelegate
- (void)didSelectBarAtIndex:(NSInteger)buttonIndex
{
    if (lastButtonIndex_ == buttonIndex) {
        return;
    }
    
    if (buttonIndex == 0) {
        [self setCurrentPageController:self.proInfoController direction:UIPageViewControllerNavigationDirectionReverse];
    }
    else if (buttonIndex == 3)
    {
        [self setCurrentPageController:self.invRecordsController direction:UIPageViewControllerNavigationDirectionForward];
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
        
        if (buttonIndex == 1) {
            [self setCurrentPageController:self.riskCController direction:direction];
        }
        else if (buttonIndex == 2)
        {
            [self setCurrentPageController:self.scheduleController direction:direction];
        }
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
- (void)startInvestDetailRequest
{
    NSDictionary *paramDic = @{
                               @"oauth_token" : [Xun_Share sharedInstance].session.oauth_token,
                               @"oauth_token_secret" : [Xun_Share sharedInstance].session.oauth_token_secret,
                               @"id" : self.proModel.itemID
                               };
    
    [MBProgressHUD showMessage:@"正在加载" andHideAfterDelay:Xun_TimeOut];
    
    [Xun_Util POST:[Xun_Util getServerUrlWithSuffix:Xun_AppInvestmentDetailUrl] parameters:paramDic success:^(NSURLSessionDataTask *task, id responseObject, Xun_ResponseInfo *responseInfo) {
        
        [MBProgressHUD hideHUD];
        
        if ([responseInfo.status isEqualToString:Xun_RequestStatusSuccess]) {
            
            self.detailModel = [[Xun_ProDetailModel alloc] initWithJsonDic:responseObject[@"detail"]];
            self.proInfoController.htmlStr = self.detailModel.detail;
            self.riskCController.htmlStr = self.detailModel.guarantee;
            
            self.myMoney = [NSString stringWithFormat:@"%@", responseObject[@"mymoney"]];
            
            NSArray *planArray = responseObject[@"plan"];
            if (planModelArr_ == nil) {
                planModelArr_ = [NSMutableArray array];
            }
            else if (planModelArr_.count > 0)
            {
                [planModelArr_ removeAllObjects];
            }
            
            if ([planArray isKindOfClass:[NSArray class]] && planArray.count > 0) {
                for (NSDictionary *dic in planArray) {
                    Xun_PaymentScheduleModel *model = [[Xun_PaymentScheduleModel alloc] initWithJsonDic:dic];
                    [planModelArr_ addObject:model];
                }
                
                self.scheduleController.dataArray = [NSArray arrayWithArray:planModelArr_];
            }
            
            NSArray *purchaseArray = responseObject[@"purchase"];
            if (purchaseModelArr_ == nil) {
                purchaseModelArr_ = [NSMutableArray array];
            }
            else if (purchaseModelArr_.count > 0)
            {
                [purchaseModelArr_ removeAllObjects];
            }
            
            if ([purchaseArray isKindOfClass:[NSArray class]] && purchaseArray.count > 0) {
                for (NSDictionary *dic in purchaseArray) {
                    Xun_InvRecordModel *model = [[Xun_InvRecordModel alloc] initWithJsonDic:dic];
                    [purchaseModelArr_ addObject:model];
                }
                
                self.invRecordsController.dataArray = [NSArray arrayWithArray:purchaseModelArr_];
            }
            
            [self updateContent];
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

- (void)startInvestProductRequest
{
    NSDictionary *paramDic = @{
                               @"oauth_token" : [Xun_Share sharedInstance].session.oauth_token,
                               @"oauth_token_secret" : [Xun_Share sharedInstance].session.oauth_token_secret,
                               @"pid" : self.detailModel.itemID,
                               @"money" : @([self.invTextField.text integerValue])
                               };
    
    [MBProgressHUD showMessage:@"正在提交" andHideAfterDelay:Xun_TimeOut];
    
    [Xun_Util POST:[Xun_Util getServerUrlWithSuffix:Xun_AppInvestProductUrl] parameters:paramDic success:^(NSURLSessionDataTask *task, id responseObject, Xun_ResponseInfo *responseInfo) {
        
        if ([responseInfo.status isEqualToString:Xun_RequestStatusSuccess]) {
            [MBProgressHUD showSuccess:responseInfo.msg];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        else if ([responseInfo.status isEqualToString:Xun_RequestStatusAutherror])
        {
            [self showLoginViewControllerNeedHideBottomBar:NO];
        }
        else if ([responseInfo.status isEqualToString:Xun_RequestStatusRNAuthNone])
        {
            [self showRNAuthenController];
        }
        else{
            [MBProgressHUD showError:responseInfo.msg];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:[error localizedDescription]];
    }];
}

@end
