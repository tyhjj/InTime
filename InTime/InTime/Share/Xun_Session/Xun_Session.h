//
//  Xun_Session.h
//  GlobalTourism
//
//  Created by xunsmart on 16/7/11.
//  Copyright © 2016年 XunSmart. All rights reserved.
//

#import "Xun_BaseModel.h"

@interface Xun_Session : Xun_BaseModel

@property (nonatomic, copy) NSString *oauth_token;
@property (nonatomic, copy) NSString *oauth_token_secret;
@property (nonatomic, copy) NSString *mid;

@end
