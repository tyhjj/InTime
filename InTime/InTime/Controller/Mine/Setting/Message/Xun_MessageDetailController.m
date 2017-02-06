//
//  Xun_MessageDetailController.m
//  InTime
//
//  Created by xunsmart on 2017/1/16.
//  Copyright © 2017年 Xunsmart. All rights reserved.
//

#import "Xun_MessageDetailController.h"

@interface Xun_MessageDetailController ()
{
    UILabel *titleLabel_;
    UILabel *contentLabel_;
}

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) Xun_MessageModel *detailModel;

@end

@implementation Xun_MessageDetailController

#pragma mark -
#pragma mark Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavigation];
    
    [self setUp];
    
    [self startMessageDetailRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark AboutUI
- (void)setNavigation
{
    self.title = @"消息详情";
    
    [self addLeftBarItem];
}

- (void)setUp
{
    titleLabel_ = [UILabel new];
    titleLabel_.frame = CGRectMake(0, 20, kXunScreenWidth - 80, 20);
    titleLabel_.centerX = self.view.width / 2.0;
    titleLabel_.font = [UIFont systemFontOfSize:22.0f];
    titleLabel_.textColor = Xun_ColorFromHex(0x333333);
    titleLabel_.textAlignment = NSTextAlignmentCenter;
    titleLabel_.text = self.model.title;
    [self.view addSubview:titleLabel_];
    
    self.scrollView.frame = CGRectMake(25, titleLabel_.bottom + 15, self.view.width - 25 * 2, self.view.height - 25 - titleLabel_.bottom - 64 - 20);
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.contentSize = self.scrollView.frame.size;
    self.scrollView.layer.cornerRadius = 5.0f;
    self.scrollView.clipsToBounds = YES;
    self.scrollView.layer.borderWidth = 1.0;
    self.scrollView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.view addSubview:self.scrollView];
    
    contentLabel_ = [UILabel new];
    contentLabel_.frame = CGRectMake(10, 5, self.scrollView.width - 10, self.scrollView.height - 10);
    contentLabel_.numberOfLines = 0;
    [self.scrollView addSubview:contentLabel_];
}

#pragma mark -
#pragma mark Property Getter && Setter
- (UIScrollView *)scrollView
{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.showsVerticalScrollIndicator = NO;
    }
    return _scrollView;
}

- (void)updateContent
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.detailModel.comment];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:5];//调整行间距
    CGFloat emptylen = contentLabel_.font.pointSize * 2;
    paragraphStyle.firstLineHeadIndent = emptylen;
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.detailModel.comment length])];
    [attributedString addAttribute:NSForegroundColorAttributeName value:Xun_ColorFromHex(0x666666) range:NSMakeRange(0, [self.detailModel.comment length])];
    contentLabel_.attributedText = attributedString;
    
    CGFloat height = [Xun_Util getAttributeStringMaxHeightWithContent:attributedString width:contentLabel_.width];
    
    contentLabel_.height = height;
    
    if (contentLabel_.bottom + 10 > self.scrollView.contentSize.height) {
        self.scrollView.contentSize = CGSizeMake(self.scrollView.contentSize.width, contentLabel_.bottom + 10);
    }
}

#pragma mark -
#pragma mark Request
- (void)startMessageDetailRequest
{
    NSDictionary *paramDic = @{
                               @"oauth_token" : [Xun_Share sharedInstance].session.oauth_token,
                               @"oauth_token_secret" : [Xun_Share sharedInstance].session.oauth_token_secret,
                               @"aid" : self.model.itemID
                               };
    
    [MBProgressHUD showMessage:@"正在加载" andHideAfterDelay:Xun_TimeOut];
    
    [Xun_Util POST:[Xun_Util getServerUrlWithSuffix:Xun_AppUserMessageDetailUrl] parameters:paramDic success:^(NSURLSessionDataTask *task, id responseObject, Xun_ResponseInfo *responseInfo) {
        
        [MBProgressHUD hideHUD];
        
        if ([responseInfo.status isEqualToString:Xun_RequestStatusSuccess]) {
        
            self.detailModel = [[Xun_MessageModel alloc] initWithJsonDic:[responseObject firstObject]];
            [self updateContent];
        }
        else if ([responseInfo.status isEqualToString:Xun_RequestStatusAutherror])
        {
            [self showLoginViewControllerNeedHideBottomBar:NO];
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
