//
//  AvatarsListViewController.m
//  Adoravatars
//
//  Created by Pawel Maczewski on 27/07/2017.
//  Copyright © 2017 Pawel Maczewski. All rights reserved.
//

#import "AvatarsListViewController.h"
#import "AvatarCell.h"

static NSString *cellId = @"AvatarCell";

@interface AvatarsListViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property(weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property(nonatomic, strong) NSMutableSet *displayedCells;

@end

@implementation AvatarsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Avatars list";
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Network"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(networkButtonWasPressed)];
    [self.collectionView registerNib:[UINib nibWithNibName:@"AvatarCell"
                                                    bundle:nil]
          forCellWithReuseIdentifier:cellId];
    self.displayedCells = [NSMutableSet set];
    [self.presenter viewDidLoad];
}

- (void)networkButtonWasPressed {
    [self.presenter showNetworkStatusInfo];
}

#pragma mark - Collection View Data Source

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.presenter.numberOfAvatars;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    AvatarCell *avatarCell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId
                                                                       forIndexPath:indexPath];
    [avatarCell configureWithItem:[self.presenter avatarAtIndex:(NSUInteger) indexPath.item]];
    return avatarCell;
}

#pragma mark Collection View Layout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(120, 120);
}

#pragma mark Collection View Delegate

- (void)collectionView:(UICollectionView *)collectionView
       willDisplayCell:(UICollectionViewCell *)cell
    forItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.displayedCells addObject:cell];
    [self.presenter fetchAvatarAtIndex:(NSUInteger) indexPath.item];
}

- (void)collectionView:(UICollectionView *)collectionView
  didEndDisplayingCell:(UICollectionViewCell *)cell
    forItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.displayedCells removeObject:cell];
    [self.presenter stopFetchingAvatarAtIndex:(NSUInteger) indexPath.item];
}

#pragma mark - View Protocol Implementation

- (void)updateDisplayCellAtIndex:(NSUInteger)cellIndex withStatus:(AvatarDownloadStatus)status {
    dispatch_async(dispatch_get_main_queue(), ^{
        AvatarCell *cell = (AvatarCell *) [self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:cellIndex
                                                                                                          inSection:0]];
        if ([self.displayedCells containsObject:cell]) {
            [cell configureWithItem:[self.presenter avatarAtIndex:cellIndex]];
            [cell setNeedsDisplay];
        }
    });
}


@end
