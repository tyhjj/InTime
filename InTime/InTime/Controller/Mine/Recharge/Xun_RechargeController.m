//
//  Xun_RechargeController.m
//  InTime
//
//  Created by xunsmart on 2017/1/15.
//  Copyright © 2017年 Xunsmart. All rights reserved.
//

#import "Xun_RechargeController.h"
#import "APay.h"
#import "PaaCreater.h"
#import "Xun_OrderModel.h"

@interface Xun_RechargeController () <APayDelegate>
@property (weak, nonatomic) IBOutlet UITextField *rechargeTextField;
@property (weak, nonatomic) IBOutlet UILabel *balanceLabel;

@end

@implementation Xun_RechargeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if ([Xun_Util strNilOrEmpty:self.balance]) {
        self.balanceLabel.text = @"暂时无法获取";
    }
    else
    {
        self.balanceLabel.text = [NSString stringWithFormat:@"%.2f元", [self.balance floatValue]];
    }
    
    [self setNavigation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark AboutUI
- (void)setNavigation
{
    self.title = @"账户充值";
    
    [self addLeftBarItem];
}

#pragma mark -
#pragma mark Action
- (IBAction)rechargeAction:(id)sender {
    if ([Xun_Util strNilOrEmpty:self.rechargeTextField.text]) {
        [MBProgressHUD showError:@"请输入充值金额!"];
    }
    else if ([self.rechargeTextField.text integerValue] > 50000)
    {
        [MBProgressHUD showError:@"单笔限额5万元!"];
    }
    else
    {
        [self startRechargeRequest];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark -
#pragma mark APayDelegate
- (void)APayResult:(NSString *)result
{
    NSArray *parts = [result componentsSeparatedByString:@"="];
    NSError *error;
    NSData *data = [[parts lastObject] dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    NSInteger payResult = [dic[@"payResult"] integerValue];
//    NSString *format_string = @"支付结果::支付%@";
    if (payResult == APayResultSuccess) {
        [MBProgressHUD showSuccess:@"充值成功"];
        [self.navigationController popToRootViewControllerAnimated:YES];
    } else if (payResult == APayResultFail) {
        [MBProgressHUD showSuccess:@"充值失败"];
    } else if (payResult == APayResultCancel) {
        [MBProgressHUD showSuccess:@"充值取消"];
    }
}

#pragma mark -
#pragma mark Request
- (void)startRechargeRequest
{
    NSDictionary *paramDic = @{
                               @"oauth_token" : [Xun_Share sharedInstance].session.oauth_token,
                               @"oauth_token_secret" : [Xun_Share sharedInstance].session.oauth_token_secret,
                               @"money" : [Xun_Util strTrim:self.rechargeTextField.text]
                               };
    
    [MBProgressHUD showMessage:@"正在提交充值请求" andHideAfterDelay:Xun_TimeOut];
    
    [Xun_Util POST:[Xun_Util getServerUrlWithSuffix:Xun_AppRechargeUrl] parameters:paramDic success:^(NSURLSessionDataTask *task, id responseObject, Xun_ResponseInfo *responseInfo) {
        
        [MBProgressHUD hideHUD];
        
        if ([responseInfo.status isEqualToString:Xun_RequestStatusSuccess]) {
            /*
            NSString *formatterStr = [PaaCreater randomPaa];
            [APay startPay:formatterStr viewController:self delegate:self mode:@"01"];
             */
            
            
            Xun_OrderModel *orderModel = [[Xun_OrderModel alloc] initWithJsonDic:[responseObject mj_JSONObject]];
            
            NSArray *signSrc = @[
                                 orderModel.inputCharset, @"inputCharset" ,
                                 orderModel.receiveUrl, @"receiveUrl" ,
                                 orderModel.version, @"version" ,
                                 orderModel.language, @"language" ,
                                 orderModel.signType, @"signType" ,
                                 orderModel.merchantId, @"merchantId",
                                 orderModel.orderNo, @"orderNo" ,
                                 orderModel.orderAmount, @"orderAmount" ,
                                 orderModel.orderCurrency, @"orderCurrency" ,
                                 orderModel.orderDatetime, @"orderDatetime" ,
                                 orderModel.productName, @"productName" ,
                                 orderModel.ext1, @"ext1",
                                 orderModel.payType, @"payType" ,
                                 orderModel.issuerId, @"issuerId" ,
                                 @"1234567890" , @"key"
                                 ];
            
            
            NSString *resultStr = [self formatPaa:signSrc];
            
            [APay startPay:resultStr viewController:self delegate:self mode:@"00"];
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

#pragma mark -
#pragma mark Private
//计算字符串对应的md5值
- (NSString *)md5:(NSString *)string {
    
    if (string == nil) { return nil; }
    
    const char *str = [string cStringUsingEncoding:NSUTF8StringEncoding];
    CC_LONG strLen = (CC_LONG)[string lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    unsigned char *result = calloc(CC_MD5_DIGEST_LENGTH, sizeof(unsigned char));
    CC_MD5(str, strLen, result);
    
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; ++i) {
        [hash appendFormat:@"%02x", result[i]];
    }
    
    free(result);
    
    return hash;
}

- (NSString *)formatPaa:(NSArray *)array {
    
    NSMutableDictionary *mdic = [NSMutableDictionary dictionary];
    
    NSMutableString *paaStr = [[NSMutableString alloc] init];
    for (int i = 0; i < array.count; i++) {
        [paaStr appendFormat:@"%@=%@&", array[i+1], array[i]];
        mdic[array[i+1]] = array[i];
        i++;
    }
    
//    NSString *signMsg = [self md5:[paaStr substringToIndex:paaStr.length - 1]];
    NSString *signMsg = [self md5:[paaStr substringToIndex:paaStr.length - 1]];
    mdic[@"signMsg"] = signMsg.uppercaseString;
    
    //############################  卡号回显请参考以下部分  ##############################################//
    
    //卡号回显需要在订单信息中传入该字段
    //该字段不参与订单信息的签名计算
    //若不需要卡号回显的功能该字段可不传入
    //    NSString *cardNo = @"4391880000000004";//测试用信用卡
    //                       @"6225882120759623";//测试用借记卡
    //    mdic[@"cardNo"] = cardNo;
    
    //##################################################################################################//
    
    //############################  外卡支付订单添加扩展信息字段  ###########################################//
    
    //    [mdic addEntriesFromDictionary:[self extPart]];
    
    //##################################################################################################//
    
    if (mdic[@"key"]) {//商户私有签名密钥 通联后台持有不传入插件
        [mdic removeObjectForKey:@"key"];
    }
    
    NSError *error;
    NSData *data = [NSJSONSerialization dataWithJSONObject:mdic options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonStr = [[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding:NSUTF8StringEncoding];
    
    [paaStr setString:jsonStr];
    
    return paaStr;
}

@end
