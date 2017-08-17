//
//  AvatarsListInteractor.h
//  Adoravatars
//
//  Created by Pawel Maczewski on 27/07/2017.
//  Copyright © 2017 Pawel Maczewski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AvatarsListProtocols.h"

extern NSString *const kNOTIF_DOWNLOAD_STATUS_CHANGED;
extern NSString *const kNOTIF_DOWNLOAD_STATUS_CHANGED_USERINFO_AVATAR_INDEX;

@interface AvatarsListInteractor : NSObject <AvatarsListInteractorInputProtocol>

@property(nonatomic, strong) NSURLSession *urlSession;

- (instancetype)initWithNamesList:(NSArray<NSString *> *)names;
- (instancetype)initWithStarWarsNames;

@end
