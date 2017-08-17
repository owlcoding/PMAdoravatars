//
// Created by Pawel Maczewski on 29.07.2017.
// Copyright (c) 2017 Pawel Maczewski. All rights reserved.
//

#import <DateTools/DateTools.h>
#import "AvatarDownloadStatusViewModel.h"
#import "AvatarDownloadModel.h"


@implementation AvatarDownloadStatusViewModel
+ (instancetype)viewModelWithAvatarDownloadModel:(AvatarDownloadModel *)downloadModel {
    AvatarDownloadStatusViewModel *model = [[self alloc] init];
    model.avatarName = downloadModel.avatarName;
    model.sinceTimestamp = [downloadModel.latestChangeOfStatus timeAgoSinceNow];
    model.downloadStatus = downloadModel.downloadStatus;
    switch (downloadModel.downloadStatus) {
        case AvatarDownloadStatusUnknown:
            model.statusText = @"Queued";
            break;
        case AvatarDownloadStatusDownloading:
            model.statusText = @"In Progress";
            break;
        case AvatarDownloadStatusSuccess:
            model.statusText = @"Done";
            break;
        case AvatarDownloadStatusError:
            model.statusText = @"Failed";
            break;
    }
    return model;
}

@end