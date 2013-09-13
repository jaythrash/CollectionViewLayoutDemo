//
//  BookShelfDataSource.m
//  CollectionViewLayoutDemo
//
//  Created by Jay Thrash on 9/13/13.
//  Copyright (c) 2013 AirDrop Apps. All rights reserved.
//

#import "BookShelfDataSource.h"
#import "BookCell.h"
#import "BookShelfHeaderView.h"

@interface BookShelfDataSource()
{
    NSArray *_books;
}

@end


@implementation BookShelfDataSource

- (id)init
{
    if (!(self = [super init])) return nil;
    [self generateBooks];
    return self;
}

- (void)generateBooks
{
    // just some simple sample data indicating the number of books in each section 
    _books = @[ @7, @1, @7, @2, @4, @3];
}

#pragma mark UICollectionViewDataSource 

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [_books count];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return [_books[section] integerValue];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BookCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[BookCell reuseId]
                                                               forIndexPath:indexPath];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath
{
    BookShelfHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                               withReuseIdentifier:[BookShelfHeaderView reuseId]
                                                                      forIndexPath:indexPath];
    header.shelfName = [NSString stringWithFormat:@"Section %d", indexPath.section];
    header.shelfCount = [_books[indexPath.section] intValue];
    return header;
}

@end
