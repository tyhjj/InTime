//
//  Xun_FileManager.m
//  niuManager
//
//  Created by xunsmart on 16/3/21.
//  Copyright © 2016年 wenpeifang. All rights reserved.
//

#import "Xun_FileManager.h"

@implementation Xun_FileManager

+ (NSString *)fileHomeDir{
    NSString *path = NSHomeDirectory();
    return path;
}

+ (NSString *)fileResourceDir{
    NSString *path = [[NSBundle mainBundle] resourcePath];
    return path;
}

+ (NSString *)fileResourceDir:(NSString *)path{
    NSString *resPath = [[NSBundle mainBundle] resourcePath];
    NSString *filePath = [resPath stringByAppendingPathComponent:path];
    return filePath;
}

+ (NSString *)fileDocDir {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    return docDir;
}

+ (NSString *)fileDocDir:(NSString *)path {
    NSString *docDir = [self fileDocDir];
    NSString *filePath = [docDir stringByAppendingPathComponent:path];
    return filePath;
}

+ (NSString *)fileCacheDir{
    NSArray *cache = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [cache objectAtIndex:0];
    return cachePath;
}

+ (NSString *)fileCacheDir:(NSString *)path{
    NSString *cacheDir = [self fileCacheDir];
    NSString *filePath = [cacheDir stringByAppendingPathComponent:path];
    return filePath;
}

+ (NSString *)fileTempDir {
    return NSTemporaryDirectory();
}

+ (NSString *)fileTempDir:(NSString *)path {
    NSString *tempDir = [self fileTempDir];
    NSString *filePath = [tempDir stringByAppendingPathComponent:path];
    return filePath;
}

+ (BOOL)fileCreateDir:(NSString *)path {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    BOOL success = [fileManager createDirectoryAtPath:path withIntermediateDirectories:NO attributes:nil error:&error];
    return success;
}

+ (BOOL)fileExistAtPath:(NSString *)path {
    NSFileManager *filemanager = [NSFileManager defaultManager];
    return [filemanager fileExistsAtPath:path];
}

+ (BOOL)fileWriteAtPath:(NSString *)path data:(NSData *)data {
    return [data writeToFile:path atomically:NO];
}

+ (BOOL)fileDel:(NSString *)path {
    NSFileManager *filemanager = [NSFileManager defaultManager];
    NSError *error;
    BOOL success = [filemanager removeItemAtPath:path error:&error];
    return success;
}

+ (NSArray *)fileSubFileNames:(NSString *)path{
    NSFileManager *filemanager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *names = [filemanager contentsOfDirectoryAtPath:path error:&error];
    return names;
}

+ (BOOL)fileCopy:(NSString *)fromPath toPath:(NSString *)toPath{
    NSFileManager *filemanager = [NSFileManager defaultManager];
    NSError *error;
    BOOL success = [filemanager copyItemAtPath:fromPath toPath:toPath error:&error];
    return success;
}

@end
