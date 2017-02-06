//
//  Xun_UserInfoController.m
//  InTime
//
//  Created by xunsmart on 2017/1/12.
//  Copyright © 2017年 Xunsmart. All rights reserved.
//

#import "Xun_UserInfoController.h"
#import "Xun_UserInfoIconCell.h"
#import "Xun_UserInfoModel.h"
#import "UIAlertController+XunUtil.h"
#import <AVFoundation/AVFoundation.h>
#import "Xun_EditNicknameController.h"
#import "Xun_EditSexController.h"
#import "Xun_RNAuthenticationController.h"

@interface Xun_UserInfoController () <UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    NSArray *itemArr_;
}

@property (weak, nonatomic) IBOutlet UITableView *infoTableView;
@property (nonatomic, strong) Xun_UserInfoModel *userInfoModel;

@property (nonatomic, strong) UIImagePickerController *imagePickerVC;

@end

@implementation Xun_UserInfoController

#pragma mark -
#pragma mark Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setNavigation];
    
    [self setUp];
    
    [self startUserInfoRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark AboutUI
- (void)setNavigation
{
    self.title = @"个人资料";
    
    [self addLeftBarItem];
}

- (void)setUp
{
    [self.infoTableView registerNib:[UINib nibWithNibName:@"Xun_UserInfoIconCell" bundle:nil] forCellReuseIdentifier:@"avatarCell"];
}

#pragma mark -
#pragma mark Property Getter && Setter
- (UIImagePickerController *)imagePickerVC
{
    if (_imagePickerVC == nil) {
        
        _imagePickerVC = [[UIImagePickerController alloc] init];
        _imagePickerVC.delegate = self;
        //在这里设置imagePickerVc的外观
        _imagePickerVC.navigationBar.barTintColor = Xun_ColorRGB(252, 252, 252);
        _imagePickerVC.navigationBar.tintColor = Xun_BaseBlueColor;
        _imagePickerVC.view.backgroundColor = Xun_ColorRGB(246, 246, 246);
        NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
        attrs[NSForegroundColorAttributeName] = Xun_ColorFromHex(0x333333);
        attrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:18];
        [_imagePickerVC.navigationBar setTitleTextAttributes:attrs];
    }
    return _imagePickerVC;
}

#pragma mark -
#pragma mark UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1) {
        return 4;
    }
    else
    {
        return 1;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        Xun_UserInfoIconCell *cell = [tableView dequeueReusableCellWithIdentifier:@"avatarCell"];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (![Xun_Util strNilOrEmpty:self.userInfoModel.avatar]) {
            [cell.avatarImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", self.userInfoModel.avatar]] placeholderImage:[UIImage imageNamed:@"mine_defaultAvatar.png"]];
        }
        
        return cell;
    }
    else
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"deqCell"];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"deqCell"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            if (indexPath.section == 2) {
                UILabel *label = [UILabel new];
                label.frame = CGRectMake(0, 0, 100, 40);
                label.centerX = kXunScreenWidth / 2.0;
                label.centerY = cell.contentView.height / 2.0;
                label.textColor = Xun_ColorFromHex(0x333333);
                label.text = @"退出登录";
                
                [cell.contentView addSubview:label];
                
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
        }
        
        if (indexPath.section == 1) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            if (indexPath.row == 0) {
                cell.textLabel.text = @"昵称";
                cell.detailTextLabel.text = [Xun_Util strNilOrEmpty:self.userInfoModel.nick_name] ? @"未设置" : self.userInfoModel.nick_name;
            }
            else if (indexPath.row == 1)
            {
                cell.textLabel.text = @"性别";
                if ([self.userInfoModel.sex isEqualToString:@"1"]) {
                    cell.detailTextLabel.text = @"男";
                }
                else if ([self.userInfoModel.sex isEqualToString:@"2"]) {
                    cell.detailTextLabel.text = @"女";
                }
                else
                {
                    cell.detailTextLabel.text = @"未知";
                }
            }
            else if (indexPath.row == 2)
            {
                cell.textLabel.text = @"手机号";
                if ([Xun_Util strNilOrEmpty:self.userInfoModel.mobile]) {
                    cell.detailTextLabel.text = @"未绑定";
                }
                else
                {
                    cell.detailTextLabel.text = self.userInfoModel.mobile;
                    cell.accessoryType = UITableViewCellAccessoryNone;
                }
            }
            else if (indexPath.row == 3)
            {
                cell.textLabel.text = @"实名认证";
                if ([self.userInfoModel.authorize isEqualToString:@"1"]) {
                    cell.detailTextLabel.text = @"已认证";
                    cell.accessoryType = UITableViewCellAccessoryNone;
                }
                else
                {
                    cell.detailTextLabel.text = @"未认证";
                }
            }
            /*
            else if (indexPath.row == 4)
            {
                cell.textLabel.text = @"提现银行卡";
                
                if ([self.userInfoModel.mbank isEqualToString:@"1"]) {
                    cell.detailTextLabel.text = @"已绑定";
                    cell.accessoryType = UITableViewCellAccessoryNone;
                }
                else
                {
                    cell.detailTextLabel.text = @"未绑定";
                }
            }
             */
        }
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 60;
    }
    else
    {
        return 44.0f;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 10.0f;
    }
    else
    {
        return 40.0f;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [UIView new];
    footerView.frame = CGRectMake(0, 0, kXunScreenWidth, 10);
    
    if (section == 1) {
        footerView.height = 40;
    }
    
    return footerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否要退出?" preferredStyle:UIAlertControllerStyleAlert cancelButtonTitle:@"否" destructiveButtonTitle:nil otherButtonTitles:@"是", nil];
        alertController.AlertControllerActionHandler = ^(UIAlertAction *action) {
            if (action.buttonIndex == 0) {
                [self startLogoutRequest];
            }
        };
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else if (indexPath.section == 0)
    {
        //上传头像
        UIAlertController *actionController = [UIAlertController alertControllerWithTitle:@"选择照片" message:@"" preferredStyle:UIAlertControllerStyleActionSheet cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从相册选取", nil];
        actionController.AlertControllerActionHandler = ^(UIAlertAction *action){
            if (action.buttonIndex == 0) {
                //拍照
                [self takePhoto];
            }
            else if (action.buttonIndex == 1)
            {
                //从相册选择
                [self pushImagePickerController];
            }
        };
        [self presentViewController:actionController animated:YES completion:nil];
    }
    else
    {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        if (indexPath.row == 0) {
            Xun_EditNicknameController *eNicknameVC = [[Xun_EditNicknameController alloc] init];
            if ([Xun_Util strNilOrEmpty:self.userInfoModel.nick_name] || ![self.userInfoModel.nick_name isEqualToString:@"未设置"]) {
                eNicknameVC.originalName = self.userInfoModel.nick_name;
            }
            eNicknameVC.EditSuccessHandler = ^(NSString *chagedNickname) {
                cell.detailTextLabel.text = chagedNickname;
            };
            [self.navigationController pushViewController:eNicknameVC animated:YES];
        }
        else if (indexPath.row == 1)
        {
            Xun_EditSexController *eSexVC = [[Xun_EditSexController alloc] init];
            eSexVC.selectSex = [self.userInfoModel.sex integerValue];
            eSexVC.EditSuccessHandler = ^(NSNumber *changedSex) {
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", ([changedSex integerValue] == 1) ? @"男" : @"女"];
            };
            
            [self.navigationController pushViewController:eSexVC animated:YES];
        }
        else if (indexPath.row == 3)
        {
            if ([self.userInfoModel.authorize isEqualToString:@"0"]) {
                Xun_RNAuthenticationController *rnAuthVC = [[Xun_RNAuthenticationController alloc] init];
                [self.navigationController pushViewController:rnAuthVC animated:YES];
            }
        }
    }
}

#pragma mark -
#pragma mark Photo
- (void)pushImagePickerController {
    self.imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:self.imagePickerVC animated:YES completion:nil];
}

- (void)takePhoto {
    float isiOS8Later = [[UIDevice currentDevice].systemVersion floatValue] >= 8.0f;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if ((authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied) && isiOS8Later) {
        // 无权限 做一个友好的提示
        [MBProgressHUD showError:@"请在iPhone的""设置-隐私-相机""中允许访问相机"];
    } else { // 调用相机
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
            
            self.imagePickerVC.sourceType = sourceType;
            if(isiOS8Later) {
                self.imagePickerVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            }
            [self presentViewController:self.imagePickerVC animated:YES completion:nil];
        } else {
            Xun_DebugLog(@"模拟器中无法打开照相机,请在真机中使用");
        }
    }
}

#pragma mark -
#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    if ([type isEqualToString:@"public.image"]) {
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        
        if (image) {
            Xun_UserInfoIconCell *cell = [self.infoTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            cell.avatarImage.image = image;
            //上传照片
            [self startUploadAvatarRequestWithImage:image];
        }
    }
}

#pragma mark -
#pragma mark Request
- (void)startUserInfoRequest
{
    NSDictionary *paramDic = @{
                               @"oauth_token" : [Xun_Share sharedInstance].session.oauth_token,
                               @"oauth_token_secret" : [Xun_Share sharedInstance].session.oauth_token_secret
                               };
    
    [MBProgressHUD showMessage:@"正在获取" andHideAfterDelay:Xun_TimeOut];
    
    [Xun_Util POST:[Xun_Util getServerUrlWithSuffix:Xun_AppUserInfoUrl] parameters:paramDic success:^(NSURLSessionDataTask *task, id responseObject, Xun_ResponseInfo *responseInfo) {
        
        [MBProgressHUD hideHUD];
        
        if ([responseInfo.status isEqualToString:Xun_RequestStatusSuccess]) {
            self.userInfoModel = [[Xun_UserInfoModel alloc] initWithJsonDic:responseObject];
            [self.infoTableView reloadData];
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

- (void)startLogoutRequest
{
    NSDictionary *paramDic = @{
                               @"oauth_token" : [Xun_Share sharedInstance].session.oauth_token,
                               @"oauth_token_secret" : [Xun_Share sharedInstance].session.oauth_token_secret
                               };
    
    [MBProgressHUD showMessage:@"正在退出" andHideAfterDelay:Xun_TimeOut];
    
    [Xun_Util POST:[Xun_Util getServerUrlWithSuffix:Xun_AppLogoutUrl] parameters:paramDic success:^(NSURLSessionDataTask *task, id responseObject, Xun_ResponseInfo *responseInfo) {
        
        [MBProgressHUD hideHUD];
        
        if ([responseInfo.status isEqualToString:Xun_RequestStatusSuccess]) {
            [MBProgressHUD showSuccess:responseInfo.msg];
            
            [Xun_Share sharedInstance].session = nil;
            [Xun_Util removeUserSession];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:Xun_LogoutNotification object:nil];
            [self.navigationController popToRootViewControllerAnimated:YES];
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

- (void)startUploadAvatarRequestWithImage:(UIImage *)image
{
    NSDictionary *paramDic = @{
                               @"oauth_token" : [Xun_Share sharedInstance].session.oauth_token,
                               @"oauth_token_secret" : [Xun_Share sharedInstance].session.oauth_token_secret
                               };
    
    [MBProgressHUD showMessage:@"正在上传" andHideAfterDelay:Xun_TimeOut];
    AFHTTPSessionManager *httpManager = [AFHTTPSessionManager manager];
    [httpManager POST:[Xun_Util getServerUrlWithSuffix:Xun_AppUploadAvatarUrl] parameters:paramDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSData *imageData = UIImageJPEGRepresentation(image, 0.001);
        
        [formData appendPartWithFileData:imageData name:@"upfile" fileName:@"avatar.png" mimeType:@"image/png"];
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [MBProgressHUD hideHUD];
        
        NSDictionary *resultDic = responseObject;
        
        if (!resultDic) return ;
        
        NSString *status = [resultDic objectForKey:@"status"];
        NSString *msg = [resultDic objectForKey:@"msg"];
        
        if ([status isEqualToString:Xun_RequestStatusSuccess]) {
            [MBProgressHUD showSuccess:msg];
        }
        else
        {
            [MBProgressHUD showError:msg];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:[error localizedDescription]];
    }];
}

@end
