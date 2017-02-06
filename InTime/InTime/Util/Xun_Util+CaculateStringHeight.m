//
//  Xun_Util+CaculateStringHeight.m
//  GlobalTourism
//
//  Created by xunsmart on 16/7/12.
//  Copyright © 2016年 XunSmart. All rights reserved.
//

#import "Xun_Util+CaculateStringHeight.h"

@implementation Xun_Util (CaculateStringHeight)

+ (CGFloat)getAttributeStringMaxHeightWithContent:(NSAttributedString *)content width:(CGFloat)width
{
    return [content boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                 options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                 context:nil].size.height;
}

+ (CGFloat)getNormalStringMaxHeightWithContent:(NSString *)content width:(CGFloat)width font:(UIFont *)font
{
    return [content boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                 options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                              attributes:@{NSFontAttributeName : font}
                                 context:nil].size.height;
}

@end
