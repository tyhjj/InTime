//
//  Xun_AgreementController.h
//  InTime
//
//  Created by xunsmart on 2017/1/17.
//  Copyright © 2017年 Xunsmart. All rights reserved.
//

#import "Xun_BaseViewController.h"

@interface Xun_AgreementController : Xun_BaseViewController

@property (nonatomic, copy) void (^IsReadAgreementHandler)(BOOL isAgree);

@end
