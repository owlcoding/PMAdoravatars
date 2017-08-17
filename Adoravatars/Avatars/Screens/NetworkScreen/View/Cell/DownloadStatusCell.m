//
//  DownloadStatusCell.m
//  Adoravatars
//
//  Created by Pawel Maczewski on 28/07/2017.
//  Copyright © 2017 Pawel Maczewski. All rights reserved.
//

#import "DownloadStatusCell.h"
#import "AvatarDownloadModel.h"
#import "DateTools.h"
#import "UIColor+Utilities.h"
#import "AvatarDownloadStatusViewModel.h"

@interface DownloadStatusCell ()
@property(weak, nonatomic) IBOutlet UILabel *avatarNameLabel;
@property(weak, nonatomic) IBOutlet UILabel *statusLabel;
@property(weak, nonatomic) IBOutlet UILabel *timestampLabel;
@property(weak, nonatomic) IBOutlet UIButton *retryButton;
@property(nonatomic, strong) AvatarDownloadStatusViewModel *viewModel;
@end

@implementation DownloadStatusCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureWithItem:(NSObject *)item {
    AvatarDownloadStatusViewModel *model = (AvatarDownloadStatusViewModel *) item;
    self.viewModel = model;
    self.timestampLabel.text = model.sinceTimestamp;
    self.statusLabel.text = model.statusText;
    self.avatarNameLabel.text = model.avatarName;
    
    self.retryButton.hidden = YES;
    
    UIColor *textColor = [UIColor blackColor];
    switch (model.downloadStatus) {
        case AvatarDownloadStatusUnknown:
            textColor = [UIColor statusUnknownColor];
            self.retryButton.hidden = NO;
      break;
        case AvatarDownloadStatusDownloading:
            textColor = [UIColor statusInProgressColor];
            break;
        case AvatarDownloadStatusSuccess:
            textColor = [UIColor statusOkColor];
            break;
        case AvatarDownloadStatusError:
            textColor = [UIColor statusErrorColor];
            self.retryButton.hidden = NO;
            break;
    }
    self.timestampLabel.textColor = textColor;
    self.statusLabel.textColor = textColor;
    self.avatarNameLabel.textColor = textColor;
}

- (IBAction)retryAction:(UIButton *)sender {
    if (self.retryButtonTapped) {
        self.retryButtonTapped();
    }
}

@end
