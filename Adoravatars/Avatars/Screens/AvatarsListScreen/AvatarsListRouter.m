//
//  AvatarsListRouter.m
//  Adoravatars
//
//  Created by Pawel Maczewski on 27/07/2017.
//  Copyright © 2017 Pawel Maczewski. All rights reserved.
//

#import "AvatarsListRouter.h"
#import "AvatarsListViewController.h"
#import "AvatarsListInteractor.h"
#import "AvatarsListPresenter.h"
#import "NetworkScreenPresenter.h"
#import "NetworkScreenViewController.h"

@interface AvatarsListRouter ()

@property(nonatomic, weak) AvatarsListViewController *avatarsListViewController;

@end

@implementation AvatarsListRouter

+ (UINavigationController *)navigationControllerWithRoot:(UIViewController *)viewController {
    return [[UINavigationController alloc] initWithRootViewController:viewController];
}

+ (UINavigationController *)createModule {
    NSString *viewName = NSStringFromClass([AvatarsListViewController class]);
    AvatarsListViewController *viewController = [[AvatarsListViewController alloc] initWithNibName:viewName bundle:nil];
    AvatarsListInteractor *interactor = [[AvatarsListInteractor alloc] initWithStarWarsNames];
    AvatarsListRouter *router = [[AvatarsListRouter alloc] init];
    AvatarsListPresenter *presenter = [[AvatarsListPresenter alloc] initWithInterface:viewController interactor:interactor router:router];
    viewController.presenter = presenter;
    router.viewController = [self navigationControllerWithRoot:viewController];
    router.avatarsListViewController = viewController;
    return router.viewController;
}

- (UIViewController *)networkDetailsViewController {
    NSString *viewName = NSStringFromClass([NetworkScreenViewController class]);
    NetworkScreenViewController *viewController = [[NetworkScreenViewController alloc] initWithNibName:viewName
                                                                                                bundle:nil];
    NetworkScreenPresenter *presenter = [[NetworkScreenPresenter alloc] initWithInterface:viewController
                                                                               interactor:self.avatarsListViewController.presenter.interactor
                                                                                   router:self];
    viewController.presenter = presenter;
    return viewController;
}

- (void)showNetworkStatusInfoScreen {
    UINavigationController *navigationController = [AvatarsListRouter navigationControllerWithRoot:[self networkDetailsViewController]];
    [self.viewController presentViewController:navigationController
                                      animated:YES
                                    completion:nil];
}

- (void)closeNetworkStatusInfoScreen {
    [self.viewController dismissViewControllerAnimated:YES
                                            completion:nil];
}

@end
