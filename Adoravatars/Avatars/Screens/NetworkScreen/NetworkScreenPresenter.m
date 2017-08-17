//
//  NetworkScreenPresenter.m
//  Adoravatars
//
//  Created by Pawel Maczewski on 28/07/2017.
//  Copyright © 2017 Pawel Maczewski. All rights reserved.
//

#import "NetworkScreenPresenter.h"
#import "AvatarDownloadStatusViewModel.h"
#import "AvatarsListInteractor.h"

@interface NetworkScreenPresenter ()
@property(nonatomic, strong) id <NSObject> notificationObserver;
@end

@implementation NetworkScreenPresenter

- (instancetype)initWithInterface:(id <NetworkScreenViewProtocol>)interface
                       interactor:(id <AvatarsListInteractorInputProtocol>)interactor
                           router:(id <AvatarsListWireframeProtocol>)router {
    if (self = [super init]) {
        self.view = interface;
        self.interactor = interactor;
        self.router = router;
        [self registerForInteractorNotifications];
    }

    return self;
}

- (void)registerForInteractorNotifications {
    void (^notificationHandler)(NSNotification *) = ^(NSNotification *notification) {
        NSUInteger index = (NSUInteger) [notification.userInfo[kNOTIF_DOWNLOAD_STATUS_CHANGED_USERINFO_AVATAR_INDEX] integerValue];
        [self.view updateDisplayCellAtIndex:index withStatus:[self.interactor avatarAtIndex:index].downloadStatus];
    };

    self.notificationObserver = [[NSNotificationCenter defaultCenter] addObserverForName:kNOTIF_DOWNLOAD_STATUS_CHANGED
                                                                                  object:nil
                                                                                   queue:[NSOperationQueue mainQueue]
                                                                              usingBlock:notificationHandler];
}

- (void)unregisterFromInteractorNotifications {
    [[NSNotificationCenter defaultCenter] removeObserver:self.notificationObserver];
    self.notificationObserver = nil;
}


- (NSUInteger)numberOfAvatars {
    return self.interactor.numberOfAvatars;
}

- (AvatarDownloadStatusViewModel *)avatarViewModelAtIndex:(NSUInteger)index {
    return [AvatarDownloadStatusViewModel viewModelWithAvatarDownloadModel:[self.interactor avatarAtIndex:index]];
}

- (void)closeNetworkScreen {
    [self unregisterFromInteractorNotifications];
    [self.router closeNetworkStatusInfoScreen];
}

- (void)didTapRetryButtonForModelAtIndex:(NSUInteger)index {
    [self.interactor fetchAvatarAtIndex:index];
}

@end
