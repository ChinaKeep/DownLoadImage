//
//  ImageDownloadManager.m
//  BaiduNavigation
//
//  Created by 随风流年 on 2019/5/23.
//  Copyright © 2019 随风流年. All rights reserved.
//

#import "ImageDownloadManager.h"
#import "SDWebImageDownloader.h"

@implementation ImageDownloadManager

/**
 
 */

+ (void)downloadImages:(NSArray<NSString *> *)imgsArray completion:(void(^)(NSArray *resultArray))completionBlock {
    SDWebImageDownloader *manager = [SDWebImageDownloader sharedDownloader];
//    manager.downloadTimeout = 20;
    __block NSMutableDictionary *resultDict = [NSMutableDictionary new];
    for(int i=0;i<imgsArray.count;i++) {
        NSString *imgUrl = [imgsArray objectAtIndex:i];
        [manager downloadImageWithURL:[NSURL URLWithString:imgUrl]
                              options:SDWebImageDownloaderUseNSURLCache|SDWebImageDownloaderScaleDownLargeImages
                             progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
                                 
                             } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
                                 if(finished){
                                     if(error){
                                         //在对应的位置放一个error对象
                                         [resultDict setObject:error forKey:@(i)];
                                     }else{
                                         [resultDict setObject:image forKey:@(i)];
                                     }
                                     if(resultDict.count == imgsArray.count) {
                                         //全部下载完成
                                         NSArray *resultArray = [ImageDownloadManager createDownloadResultArray:resultDict count:imgsArray.count];
                                         if(completionBlock){
                                             completionBlock(resultArray);
                                         }
                                     }
                                 }
                                 
                             }];
    }
}

+ (NSArray *)createDownloadResultArray:(NSDictionary *)dict count:(NSInteger)count {
    NSMutableArray *resultArray = [NSMutableArray new];
    for(int i=0;i<count;i++) {
        NSObject *obj = [dict objectForKey:@(i)];
        [resultArray addObject:obj];
    }
    return resultArray;
}

@end
