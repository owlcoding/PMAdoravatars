//
//  AvatarsListViewController.h
//  Adoravatars
//
//  Created by Pawel Maczewski on 27/07/2017.
//  Copyright © 2017 Pawel Maczewski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AvatarsListProtocols.h"
#import "../Presenter/AvatarsListPresenter.h"

@interface AvatarsListViewController : UIViewController <AvatarsListViewProtocol>

@property(nonatomic, strong) AvatarsListPresenter *presenter;

@end
