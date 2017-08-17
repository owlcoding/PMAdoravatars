//
//  DownloadStatusCell.h
//  Adoravatars
//
//  Created by Pawel Maczewski on 28/07/2017.
//  Copyright © 2017 Pawel Maczewski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigurableItem.h"

@class AvatarDownloadStatusViewModel;

@interface DownloadStatusCell : UITableViewCell <ConfigurableItem>

@property(nonatomic, copy) void(^retryButtonTapped)();

@end
