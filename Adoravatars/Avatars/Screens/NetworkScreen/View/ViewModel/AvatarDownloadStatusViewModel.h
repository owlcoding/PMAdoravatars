//
// Created by Pawel Maczewski on 29.07.2017.
// Copyright (c) 2017 Pawel Maczewski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AvatarDownloadModel.h"

@class AvatarDownloadModel;


@interface AvatarDownloadStatusViewModel : NSObject

+ (instancetype)viewModelWithAvatarDownloadModel:(AvatarDownloadModel *)downloadModel;

@property(nonatomic, copy) NSString *avatarName;
@property(nonatomic, copy) NSString *sinceTimestamp;
@property(nonatomic, copy) NSString *statusText;
@property(nonatomic, assign) AvatarDownloadStatus downloadStatus;

@end