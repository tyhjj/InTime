//
//  Xun_ResponseInfo.h
//  CTCClient
//
//  Created by xunsmart on 16/9/7.
//  Copyright © 2016年 XunSmart. All rights reserved.
//

#import "Xun_BaseModel.h"

@interface Xun_ResponseInfo : Xun_BaseModel

@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *msg;

@end
