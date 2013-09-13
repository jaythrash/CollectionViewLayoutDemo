//
//  PassbookLayout.m
//  CollectionViewLayoutDemo
//
//  Created by Jay Thrash on 9/13/13.
//  Copyright (c) 2013 AirDrop Apps. All rights reserved.
//

#import "PassbookLayout.h"
#import "PassbookDataSource.h"

static const NSUInteger BelowCellOffset = 45;
static const NSUInteger BelowCellHeight = 7;
static const CGFloat ScaleFactor = .015;


@implementation PassbookLayout

- (CGSize)collectionViewContentSize
{
    return self.collectionView.bounds.size;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *layoutAttributes = [NSMutableArray array];
    
    NSArray *visibleIndexPaths = [self indexPathsOfItemsInRect:rect];
    for (NSIndexPath *indexPath in visibleIndexPaths) {
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        [layoutAttributes addObject:attributes];
    }
    return layoutAttributes;
}

- (UICollectionViewLayoutAttributes *) layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *layoutAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    [self applyLayoutAttributes:layoutAttributes];
    return layoutAttributes;
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)attributes
{
    PassbookDataSource *dataSource = self.collectionView.dataSource;
    
    CardState cardState = [dataSource cardStateAtIndexPath:attributes.indexPath];
    
    switch (cardState) {
        case CardState_Normal:
            attributes.frame = [self frameForIndexPath:attributes.indexPath
                                            withOffset:attributes.indexPath.row
                                             andHeight:self.actualCellHeight];
            break;
        case CardState_Selected:
            attributes.frame = [self frameForIndexPath:attributes.indexPath
                                            withOffset:0
                                             andHeight:self.actualCellHeight];
            break;
        case CardState_Collapsed:
            [self applyCollapsedAttributes:attributes];
            break;
    }
    
    attributes.zIndex = attributes.indexPath.row;
}

- (void)applyCollapsedAttributes:(UICollectionViewLayoutAttributes *)attributes
{
    // Move cards to bottom of CollectionView, stack tightly and "shrink" cards
    //
    // Effect should look something like this
    //
    //     |----------|
    //    |------------|
    //   |--------------|
    //  |----------------|
    //
    NSIndexPath *indexPath = attributes.indexPath;
    NSUInteger rowCount = [self.collectionView.dataSource
                           collectionView:self.collectionView
                           numberOfItemsInSection:indexPath.section];
    
    attributes.frame = [self frameForIndexPath:indexPath
                                    withOffset:attributes.indexPath.row
                                     andHeight:50];
    
    // For rows in the collapsed section, we move them to the bottom of the CollectionView, then
    // apply a slight X scaling to simulate a stacked 3D effect
    //
    CATransform3D transform = attributes.transform3D;
    
    // Y translation to bottom of CollectionView
    CGFloat yTarget = CGRectGetHeight(self.collectionView.bounds) - BelowCellOffset  + (BelowCellHeight * indexPath.row);
    CGFloat yOffset =  yTarget - CGRectGetMinY(attributes.frame);
    transform = CATransform3DTranslate(transform, 0, yOffset, 0);
    
    // Scale width to simulate a stacked deck of cards
    transform = CATransform3DScale(transform,
                                   1 - ((rowCount - indexPath.row) * ScaleFactor),
                                   1,
                                   1);
    
    attributes.transform3D = transform;
}

// Compute Frame with Y offset
- (CGRect) frameForIndexPath:(NSIndexPath *)indexPath
                  withOffset:(NSUInteger) offset
                   andHeight:(CGFloat) height
{
    return CGRectMake(0,
                      self.visibleCellHeight * offset,
                      self.collectionView.bounds.size.width,
                      height);
}

- (NSArray *)indexPathsOfItemsInRect:(CGRect) rect
{
    // For the purposes of this CollectionView, all items are always visible.
    NSMutableArray *indexPaths = [NSMutableArray array];
    NSUInteger sections = [self.collectionView numberOfSections];
    
    for (NSUInteger section = 0; section < sections; section++) {
        for (NSInteger row = 0; row < [self.collectionView numberOfItemsInSection:section]; row++) {
            [indexPaths addObject:[NSIndexPath indexPathForItem:row inSection:section]];
        }
    }
    
    return indexPaths;
}



@end
