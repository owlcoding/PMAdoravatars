//
//  AvatarsListRouter.h
//  Adoravatars
//
//  Created by Pawel Maczewski on 27/07/2017.
//  Copyright © 2017 Pawel Maczewski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AvatarsListProtocols.h"
#import "View/AvatarsListViewController.h"

@interface AvatarsListRouter : NSObject <AvatarsListWireframeProtocol>

@property(nonatomic, strong) UINavigationController *viewController;

+ (UINavigationController *)createModule;

@end
