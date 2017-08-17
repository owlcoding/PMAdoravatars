//
//  AvatarsListProtocols.h
//  Adoravatars
//
//  Created by Pawel Maczewski on 27/07/2017.
//  Copyright © 2017 Pawel Maczewski. All rights reserved.
//

@class AvatarDownloadModel;
@class UIImage;

#import <Foundation/Foundation.h>
#import "AvatarDownloadModel.h"

#pragma mark - WireFrameProtocol

@protocol AvatarsListWireframeProtocol <NSObject>

- (void)showNetworkStatusInfoScreen;

- (void)closeNetworkStatusInfoScreen;

@end

#pragma mark - PresenterProtocol

@protocol AvatarsListPresenterProtocol <NSObject>

- (void)showNetworkStatusInfo;

- (void)viewDidLoad;

- (void)fetchAvatarAtIndex:(NSUInteger)index;

- (void)stopFetchingAvatarAtIndex:(NSUInteger)index;

- (NSUInteger)numberOfAvatars;

- (AvatarDownloadModel *)avatarAtIndex:(NSUInteger)index;

@end

#pragma mark - InteractorProtocol

@protocol AvatarsListInteractorOutputProtocol <NSObject>

/* Interactor -> Presenter */

// Not needed - since we're using notifications
//- (void)didChangeDownloadStatusForAvatarIndex:(NSUInteger)index;

@end

@protocol AvatarsListInteractorInputProtocol <NSObject>

/* Presenter -> Interactor */

- (void)fetchAvatarAtIndex:(NSUInteger)index;

- (void)stopFetchingAvatarAtIndex:(NSUInteger)index;

- (NSUInteger)numberOfAvatars;

- (AvatarDownloadModel *)avatarAtIndex:(NSUInteger)index;

- (NSArray <AvatarDownloadModel *> *)avatarDownloads;

@end

#pragma mark - ViewProtocol

@protocol AvatarsListViewProtocol <NSObject>

/* Presenter -> ViewController */
- (void)updateDisplayCellAtIndex:(NSUInteger)cellIndex withStatus:(AvatarDownloadStatus)status;

@end
