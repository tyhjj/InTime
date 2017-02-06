//
//  Xun_EditNicknameController.h
//  InTime
//
//  Created by xunsmart on 2017/1/12.
//  Copyright © 2017年 Xunsmart. All rights reserved.
//

#import "Xun_BaseViewController.h"

@interface Xun_EditNicknameController : Xun_BaseViewController

@property (nonatomic, copy) NSString *originalName;
@property (nonatomic, copy) void (^EditSuccessHandler) (NSString *changedNickName);

@end
