//
//  NetworkScreenViewController.h
//  Adoravatars
//
//  Created by Pawel Maczewski on 28/07/2017.
//  Copyright © 2017 Pawel Maczewski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetworkScreenProtocols.h"
#import "NetworkScreenPresenter.h"

@interface NetworkScreenViewController : UIViewController <NetworkScreenViewProtocol>

@property(nonatomic) NetworkScreenPresenter *presenter;

@end
