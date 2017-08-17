//
//  AvatarDownloadModel.h
//  Adoravatars
//
//  Created by Pawel Maczewski on 28/07/2017.
//  Copyright © 2017 Pawel Maczewski. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, AvatarDownloadStatus) {
    AvatarDownloadStatusUnknown,
    AvatarDownloadStatusDownloading,
    AvatarDownloadStatusSuccess,
    AvatarDownloadStatusError,
};

@interface AvatarDownloadModel : NSObject

+ (instancetype)modelWithName:(NSString *)avatarName;

@property(nonatomic, copy) NSString *avatarName;
@property(nonatomic, copy) NSData *avatarImageRawData;

@property(nonatomic, assign) double downloadPercentage;

@property(nonatomic, strong) NSURLSessionTask *downloadTask;

@property(nonatomic, readonly) NSDate *latestChangeOfStatus;

@property(nonatomic, readonly) AvatarDownloadStatus downloadStatus;

@property(nonatomic, strong) NSError *error;

- (void)statusWasUpdated;

@end
