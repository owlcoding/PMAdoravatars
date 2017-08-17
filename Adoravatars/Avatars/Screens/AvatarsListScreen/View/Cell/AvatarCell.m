//
//  AvatarCell.m
//  Adoravatars
//
//  Created by Pawel Maczewski on 28/07/2017.
//  Copyright © 2017 Pawel Maczewski. All rights reserved.
//

#import "AvatarCell.h"
#import "AvatarDownloadModel.h"
#import "UIColor+Utilities.h"

@interface AvatarCell ()

@property(weak, nonatomic) IBOutlet UILabel *avatarName;
@property(weak, nonatomic) IBOutlet UIImageView *avatarImage;
@property(weak, nonatomic) IBOutlet UIView *errorView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorView;
@end

@implementation AvatarCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.translatesAutoresizingMaskIntoConstraints = NO;
    self.errorView.backgroundColor = [UIColor statusErrorColor];
    self.avatarImage.layer.cornerRadius = self.avatarImage.bounds.size.height/2.0f;
    self.avatarImage.layer.masksToBounds = YES;
    self.errorView.layer.masksToBounds = YES;
    self.errorView.layer.cornerRadius = self.errorView.bounds.size.height/2.0f;
    self.activityIndicatorView.hidesWhenStopped = YES;
}

- (void)configureWithItem:(NSObject *)item {
    AvatarDownloadModel *model = (AvatarDownloadModel *) item;
    self.avatarName.text = model.avatarName;
    self.errorView.hidden = YES;
    
    if (model.downloadStatus == AvatarDownloadStatusDownloading) {
        [self.activityIndicatorView startAnimating];
    } else {
        [self.activityIndicatorView stopAnimating];
    }
    
    if (model.avatarImageRawData) {
        self.avatarImage.image = [UIImage imageWithData:model.avatarImageRawData];
    } else {
        self.avatarImage.image = nil;
        if (model.downloadStatus == AvatarDownloadStatusError) {
            self.errorView.hidden = NO;
        }
    }
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)prepareForReuse {
    self.avatarImage.image = nil;
    self.avatarName.text = nil;
}

@end
