//
//  AvatarsListPresenter.h
//  Adoravatars
//
//  Created by Pawel Maczewski on 27/07/2017.
//  Copyright © 2017 Pawel Maczewski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AvatarsListProtocols.h"

@interface AvatarsListPresenter : NSObject <AvatarsListInteractorOutputProtocol, AvatarsListPresenterProtocol>

@property(nonatomic, weak) id <AvatarsListViewProtocol> view;
@property(nonatomic, strong) id <AvatarsListInteractorInputProtocol> interactor;
@property(nonatomic, strong) id <AvatarsListWireframeProtocol> router;

- (instancetype)initWithInterface:(id <AvatarsListViewProtocol>)interface
                       interactor:(id <AvatarsListInteractorInputProtocol>)interactor
                           router:(id <AvatarsListWireframeProtocol>)router;

@end
