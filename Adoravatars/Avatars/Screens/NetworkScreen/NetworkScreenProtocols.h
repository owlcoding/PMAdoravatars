//
//  NetworkScreenProtocols.h
//  Adoravatars
//
//  Created by Pawel Maczewski on 28/07/2017.
//  Copyright © 2017 Pawel Maczewski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AvatarDownloadModel.h"

@class AvatarDownloadStatusViewModel;

#pragma mark - PresenterProtocol

@protocol NetworkScreenPresenterProtocol <NSObject>

- (NSUInteger)numberOfAvatars;

- (AvatarDownloadStatusViewModel *)avatarViewModelAtIndex:(NSUInteger)index;

- (void)closeNetworkScreen;

- (void)didTapRetryButtonForModelAtIndex:(NSUInteger)index;

@end

#pragma mark - ViewProtocol

@protocol NetworkScreenViewProtocol <NSObject>

/* Presenter -> ViewController */
- (void)updateDisplayCellAtIndex:(NSUInteger)cellIndex withStatus:(AvatarDownloadStatus)status;

@end
