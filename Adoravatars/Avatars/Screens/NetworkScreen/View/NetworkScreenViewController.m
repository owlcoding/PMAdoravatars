//
//  NetworkScreenViewController.m
//  Adoravatars
//
//  Created by Pawel Maczewski on 28/07/2017.
//  Copyright © 2017 Pawel Maczewski. All rights reserved.
//

#import "NetworkScreenViewController.h"
#import "DownloadStatusCell.h"
#import "AvatarDownloadStatusViewModel.h"

@interface NetworkScreenViewController () <UITableViewDataSource, UITableViewDelegate>

@property(weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation NetworkScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 60;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DownloadStatusCell class])
                                               bundle:nil]
         forCellReuseIdentifier:NSStringFromClass([DownloadStatusCell class])];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                          target:self
                                                                                          action:@selector(doneButtonTapped)];
}

- (void)doneButtonTapped {
    [self.presenter closeNetworkScreen];
}

#pragma mark - Table View Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.presenter.numberOfAvatars;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // model
    AvatarDownloadStatusViewModel *model = [self.presenter avatarViewModelAtIndex:(NSUInteger) indexPath.row];
    DownloadStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([DownloadStatusCell class])
                                                               forIndexPath:indexPath];
    [cell configureWithItem:model];
    cell.retryButtonTapped = ^() {
        [self.presenter didTapRetryButtonForModelAtIndex:indexPath.row];
    };
    return cell;
}

#pragma mark - Protocol method

- (void)updateDisplayCellAtIndex:(NSUInteger)cellIndex withStatus:(AvatarDownloadStatus)status {
    NSLog(@"Updated cell at index %d", cellIndex);
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:cellIndex inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
}


@end
