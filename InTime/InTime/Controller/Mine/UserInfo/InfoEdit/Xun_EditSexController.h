//
//  Xun_EditSexController.h
//  InTime
//
//  Created by xunsmart on 2017/1/12.
//  Copyright © 2017年 Xunsmart. All rights reserved.
//

#import "Xun_BaseViewController.h"

@interface Xun_EditSexController : Xun_BaseViewController

@property (nonatomic, assign) NSInteger selectSex;
@property (nonatomic, copy) void (^EditSuccessHandler)(NSNumber *changedSex);

@end
