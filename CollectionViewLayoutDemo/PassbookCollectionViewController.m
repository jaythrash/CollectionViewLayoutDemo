//
//  PassbookCollectionViewController.m
//  CollectionViewLayoutDemo
//
//  Created by Jay Thrash on 9/13/13.
//  Copyright (c) 2013 AirDrop Apps. All rights reserved.
//

#import "PassbookCollectionViewController.h"
#import "PassbookDataSource.h"
#import "PassbookLayout.h"
#import "PassbookCell.h"

static NSUInteger DefaultVisibleCellHeight = 60;

@interface PassbookCollectionViewController ()
{
    PassbookDataSource *_dataSource;
    PassbookLayout *_layout;
}
@end

@implementation PassbookCollectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _dataSource = [[PassbookDataSource alloc] init];
    
    _layout = [[PassbookLayout alloc] init];
    _layout.actualCellHeight = CGRectGetHeight(self.view.frame) - 120;
    _layout.visibleCellHeight = DefaultVisibleCellHeight;

    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                             collectionViewLayout:_layout];
    self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = _dataSource;
    
    // register class for cells
    [self.collectionView registerClass:[PassbookCell class]
            forCellWithReuseIdentifier:[PassbookCell reuseId]];
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.collectionView performBatchUpdates:^{
        [_dataSource selectCardAtIndexPath:indexPath];
    } completion:nil];
    
    [_layout invalidateLayout];
}


@end
