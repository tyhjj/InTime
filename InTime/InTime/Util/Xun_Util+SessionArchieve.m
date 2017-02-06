//
//  Xun_Util+SessionArchieve.m
//  GlobalTourism
//
//  Created by 王志鹏 on 16/7/11.
//  Copyright © 2016年 XunSmart. All rights reserved.
//
//  系统名称：全域旅游
//  功能描述：Session归档工具类
//  修改记录
//  王志鹏 2016-7-11   创建该单元

#import "Xun_Util+SessionArchieve.h"
#import "Xun_FileManager.h"

@implementation Xun_Util (SessionArchieve)

+ (void)archieveUserSession:(Xun_Session *)session
{
    NSMutableData *mulData = [[NSMutableData alloc] init];
    
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:mulData];
    [archiver encodeObject:session forKey:@"kXunLoginSessionKey"];
    
    [archiver finishEncoding];
    
    [mulData writeToFile:[self getUserSessionPath] atomically:YES];
}

+ (Xun_Session *)unarchieveUserSession
{
    NSMutableData *data = [[NSMutableData alloc] initWithContentsOfFile:[self getUserSessionPath]];
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    Xun_Session *session = [unarchiver decodeObjectForKey:@"kXunLoginSessionKey"];
    return session;
}

+ (NSString *)getUserSessionPath
{
    NSString *sessionPath = [[@"kXunSessionPath" md5] uppercaseString];
    NSString *fileDir = [Xun_FileManager fileDocDir:sessionPath];
    return fileDir;
}

+ (void)removeUserSession
{
    [Xun_FileManager fileDel:[self getUserSessionPath]];
}

@end
