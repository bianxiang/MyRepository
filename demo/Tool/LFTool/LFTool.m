//
//  LFTool.m
//  zs
//
//  Created by administrator on 11/2/15.
//  Copyright © 2015 administrator. All rights reserved.
//

#import "LFTool.h"
#define LFUserDefaults [NSUserDefaults standardUserDefaults]

@implementation LFTool
+ (void)setObject:(id)obj forKey:(NSString *)key
{
    [LFUserDefaults setObject:obj forKey:key];
    [LFUserDefaults synchronize];
}

+ (void)setBool:(BOOL)b forKey:(NSString *)key
{
    [LFUserDefaults setBool:b forKey:key];
    [LFUserDefaults synchronize];
}

+ (id)objectForKey:(NSString *)key
{
    return [LFUserDefaults objectForKey:key];
}

+ (BOOL)boolForKey:(NSString *)key
{
    return [LFUserDefaults boolForKey:key];
}

+ (void)sendNetWorkWithUrl:(NSString *)url parameters:(NSDictionary *)dict success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock
{
    // 网络请求类
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    // 解析格式 : 不设置具体的解析格式,只需要拿到数据
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    /** 参数
     1，请求路径
     2，请求参数
     3，成功的block
     4，失败的block
     */
    [manager GET:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        successBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failureBlock(error);
    }];
    
    /** Post请求
     [manager POST:<#(NSString *)#> parameters:<#(id)#> success:^(AFHTTPRequestOperation *operation, id responseObject) {
     
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
     
     }] */
    
    /** Post请求和Get请求的区别
     1. Get请求的参数会明显的显示在地址栏上,Post请求的参数不会显示.在这一点上,Post请求的安全性比Get请求的安全性要高.
     
     2. Post请求多用于向服务器发送数据包,比如上传文件.而Get请求多用于简单地从服务器获取数据.在这个一点上,Post请求的安全性大大降低了。
     */
    
}

+ (NSString *)getImageCache
{
    NSString *cacheSizeStr;
    NSUInteger cacheSize = [[SDImageCache sharedImageCache] getSize];
    // 缓存的最小单位 B
    if (cacheSize < 1024) {
        cacheSizeStr = [NSString stringWithFormat:@"%u B", cacheSize];
    } else if (cacheSize >= 1024 && cacheSize < 1024 * 1024) {
        cacheSizeStr = [NSString stringWithFormat:@"%.2f KB", cacheSize / 1024.0];
    } else if (cacheSize >= 1024 * 1024 && cacheSize < 1024 * 1024 * 1024) {
        cacheSizeStr = [NSString stringWithFormat:@"%.2f MB", cacheSize / (1024 * 1024.0)];
    } else {
        cacheSizeStr = [NSString stringWithFormat:@"%.2f GB", cacheSize / (1024 * 1024 * 1024.0)];
    }
    
    return cacheSizeStr;
}

+ (CGFloat)getTextHeightWithText:(NSString *)text width:(CGFloat)width font:(UIFont *)font
{
    CGFloat height = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil].size.height;
    
    return height;
}

@end

