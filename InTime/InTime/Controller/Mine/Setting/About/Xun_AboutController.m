//
//  Xun_AboutController.m
//  InTime
//
//  Created by xunsmart on 2017/1/11.
//  Copyright © 2017年 Xunsmart. All rights reserved.
//

#import "Xun_AboutController.h"

@interface Xun_AboutController ()
@property (weak, nonatomic) IBOutlet UILabel *appVersionLabel;

@end

@implementation Xun_AboutController

#pragma mark -
#pragma mark Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setNavigation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
    self.appVersionLabel.text = [NSString stringWithFormat:@"当前版本：V%@", [Xun_Util getAppVersion]];
}

#pragma mark -
#pragma mark AboutUI
- (void)setNavigation
{
    self.title = @"关于我们";
    
    [self addLeftBarItem];
}


@end
