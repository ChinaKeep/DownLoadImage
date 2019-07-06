//
//  ImageDownloadManager.h
//  BaiduNavigation
//
//  Created by 随风流年 on 2019/5/23.
//  Copyright © 2019 随风流年. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ImageDownloadManager : NSObject

+ (NSArray *)createDownloadResultArray:(NSDictionary *)dict count:(NSInteger)count ;

+ (void)downloadImages:(NSArray<NSString *> *)imgsArray completion:(void(^)(NSArray *resultArray))completionBlock;

@end

NS_ASSUME_NONNULL_END
