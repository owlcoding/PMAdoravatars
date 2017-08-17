//
//  AvatarDownloadModel.m
//  Adoravatars
//
//  Created by Pawel Maczewski on 28/07/2017.
//  Copyright © 2017 Pawel Maczewski. All rights reserved.
//

#import "AvatarDownloadModel.h"

@implementation AvatarDownloadModel

+ (instancetype)modelWithName:(NSString *)avatarName {
    AvatarDownloadModel *model = [self new];
    model.avatarName = avatarName;
    model.downloadPercentage = 0;
    model.avatarImageRawData = nil;
    model.downloadTask = nil;
    [model statusWasUpdated];
    return model;
}

- (void)statusWasUpdated {
    _latestChangeOfStatus = [NSDate date];
}

- (NSError *)error {
    return _error != nil ? _error : self.downloadTask.error;
}

- (AvatarDownloadStatus)downloadStatus {
    if (self.avatarImageRawData) {
        return AvatarDownloadStatusSuccess;
    } else if (!self.downloadTask) {
        return AvatarDownloadStatusUnknown;
    } else if (self.error) {
        return AvatarDownloadStatusError;
    } else {
        return AvatarDownloadStatusDownloading;
    }
}

@end
