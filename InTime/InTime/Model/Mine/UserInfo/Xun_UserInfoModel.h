//
//  Xun_UserInfoModel.h
//  InTime
//
//  Created by xunsmart on 2017/1/12.
//  Copyright © 2017年 Xunsmart. All rights reserved.
//

#import "Xun_BaseModel.h"

@interface Xun_UserInfoModel : Xun_BaseModel

@property (nonatomic, copy) NSString *nick_name;    //昵称
@property (nonatomic, copy) NSString *avatar;   //头像
@property (nonatomic, copy) NSString *sex;  //性别 1男 2 女 0 未知
@property (nonatomic, copy) NSString *mobile;   //手机号
@property (nonatomic, copy) NSString *authorize;    //是否实名认证 1是 0 否
@property (nonatomic, copy) NSString *mbank;    //是否绑定银行卡 1是 0 否


@end
