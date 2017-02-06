//
//  Xun_ActionSheet.h
//  niuManager
//
//  Created by 王志鹏 on 16/2/25.
//  Copyright © 2016年 XunSmart. All rights reserved.
//
//  系统名称：公共类
//  功能描述：定制PickerView承载视图
//  修改记录
//  王志鹏 2016-2-25   创建该单元

#import <UIKit/UIKit.h>

@interface Xun_ActionSheet : UIView

/*!
 *  @brief  是否已经显示
 */
@property (nonatomic) BOOL visible;
/*!
 *  @brief  增加view
 *
 *  @param subview 增加的subView
 */
-(void) addView:(UIView *) subview;
/*!
 *  @brief  初始化
 *
 *  @param subview 显示的view
 *
 *  @return 实例
 */
-(instancetype)initWithSubview:(UIView *)subview;
/*!
 *  @brief  显示view
 */
- (void)show;
/*!
 *  @brief  隐藏view
 */
- (void)dismissModalView;

@end
