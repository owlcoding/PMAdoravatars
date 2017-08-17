//
//  NetworkScreenPresenter.h
//  Adoravatars
//
//  Created by Pawel Maczewski on 28/07/2017.
//  Copyright © 2017 Pawel Maczewski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetworkScreenProtocols.h"
#import "AvatarsListProtocols.h"

@protocol AvatarsListWireframeProtocol;

@interface NetworkScreenPresenter : NSObject <AvatarsListInteractorOutputProtocol, NetworkScreenPresenterProtocol>

@property(nonatomic, weak) id <NetworkScreenViewProtocol> view;
@property(nonatomic, strong) id <AvatarsListInteractorInputProtocol> interactor;
@property(nonatomic, weak) id <AvatarsListWireframeProtocol> router;

- (instancetype)initWithInterface:(id <NetworkScreenViewProtocol>)interface
                       interactor:(id <AvatarsListInteractorInputProtocol>)interactor
                           router:(id <AvatarsListWireframeProtocol>)router;

@end
