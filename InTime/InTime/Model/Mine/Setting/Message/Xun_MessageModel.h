//
//  Xun_MessageModel.h
//  InTime
//
//  Created by xunsmart on 2017/1/15.
//  Copyright © 2017年 Xunsmart. All rights reserved.
//

#import "Xun_BaseModel.h"

@interface Xun_MessageModel : Xun_BaseModel

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *read;
@property (nonatomic, copy) NSString *itemID;
@property (nonatomic, copy) NSString *comment;

@end
