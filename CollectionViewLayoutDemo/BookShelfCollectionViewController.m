//
//  ViewController.m
//  CollectionViewLayoutDemo
//
//  Created by Jay Thrash on 9/13/13.
//  Copyright (c) 2013 AirDrop Apps. All rights reserved.
//

#import "BookShelfCollectionViewController.h"
#import "BookShelfDataSource.h"
#import "BookCell.h"
#import "BookShelfHeaderView.h"
#import "BookShelfLayout.h"

@interface BookShelfCollectionViewController ()
{
    BookShelfDataSource *_dataSource;
}
@end

@implementation BookShelfCollectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _dataSource = [[BookShelfDataSource alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                             collectionViewLayout:[[BookShelfLayout alloc] init]];
    self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.collectionView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"white-tweed"]];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = _dataSource;
    
    // register class for cells
    [self.collectionView registerClass:[BookCell class]
            forCellWithReuseIdentifier:[BookCell reuseId]];
    
    // register class for supplimentary views
    [self.collectionView registerClass:[BookShelfHeaderView class]
            forSupplementaryViewOfKind:[BookShelfHeaderView kind]
                   withReuseIdentifier:[BookShelfHeaderView reuseId]];
    
}

@end
