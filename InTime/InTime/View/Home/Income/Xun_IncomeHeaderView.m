//
//  Xun_IncomeHeaderView.m
//  InTime
//
//  Created by xunsmart on 2017/1/14.
//  Copyright © 2017年 Xunsmart. All rights reserved.
//

#import "Xun_IncomeHeaderView.h"

@interface Xun_IncomeHeaderView ()

@end

@implementation Xun_IncomeHeaderView


- (IBAction)shareAction:(id)sender {
    if (self.ShareCompletitonHandler) {
        self.ShareCompletitonHandler();
    }
}

@end
