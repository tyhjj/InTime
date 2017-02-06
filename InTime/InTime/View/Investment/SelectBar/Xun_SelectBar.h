//
//  Xun_SelectBar.h
//  InTime
//
//  Created by xunsmart on 2017/1/13.
//  Copyright © 2017年 Xunsmart. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol Xun_SelectBarDelegate <NSObject>

@optional
- (void)didSelectBarAtIndex:(NSInteger)buttonIndex;

@end

@interface Xun_SelectBar : UIView

@property (nonatomic, assign) id <Xun_SelectBarDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame Items:(NSArray *)items;

@end
