//
//  AvatarsListPresenter.m
//  Adoravatars
//
//  Created by Pawel Maczewski on 27/07/2017.
//  Copyright © 2017 Pawel Maczewski. All rights reserved.
//

#import "AvatarsListPresenter.h"
#import "AvatarDownloadModel.h"
#import "BlocksKit.h"
#import "AvatarsListInteractor.h"

@interface AvatarsListPresenter ()

@property(nonatomic, strong) id <NSObject> notificationObserver;

@end

@implementation AvatarsListPresenter

- (instancetype)initWithInterface:(id <AvatarsListViewProtocol>)interface
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

- (void)dealloc {
    [self unregisterFromInteractorNotifications];
}

- (void)registerForInteractorNotifications {
    void (^notificationHandler)(NSNotification *) = ^(NSNotification *notification) {
        NSUInteger index = (NSUInteger) [notification.userInfo[kNOTIF_DOWNLOAD_STATUS_CHANGED_USERINFO_AVATAR_INDEX] integerValue];
        [self.view updateDisplayCellAtIndex:index
                                 withStatus:[self avatarAtIndex:index].downloadStatus];
    };

    self.notificationObserver = [[NSNotificationCenter defaultCenter] addObserverForName:kNOTIF_DOWNLOAD_STATUS_CHANGED
                                                                                  object:nil
                                                                                   queue:[NSOperationQueue mainQueue]
                                                                              usingBlock:notificationHandler];
}

- (void)unregisterFromInteractorNotifications {
    [[NSNotificationCenter defaultCenter] removeObserver:self.notificationObserver];
}

- (void)showNetworkStatusInfo {
    [self.router showNetworkStatusInfoScreen];
}

#pragma mark - AvatarsListInteractorOutputProtocol

- (void)viewDidLoad {
}

- (void)fetchAvatarAtIndex:(NSUInteger)index {
    [self.interactor fetchAvatarAtIndex:index];
}

- (void)stopFetchingAvatarAtIndex:(NSUInteger)index {
    [self.interactor stopFetchingAvatarAtIndex:index];
}

- (NSUInteger)numberOfAvatars {
    return self.interactor.numberOfAvatars;
}

- (AvatarDownloadModel *)avatarAtIndex:(NSUInteger)index {
    return [self.interactor avatarAtIndex:index];
}


@end
