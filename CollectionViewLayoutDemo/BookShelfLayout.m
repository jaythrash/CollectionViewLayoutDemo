//
//  BookShelfLayout.m
//  CollectionViewLayoutDemo
//
//  Created by Jay Thrash on 9/13/13.
//  Copyright (c) 2013 AirDrop Apps. All rights reserved.
//

#import "BookShelfLayout.h"
#import "BookShelfDecorationView.h"
#import "BookShelfHeaderView.h"

@interface BookShelfLayout()
{
    NSDictionary *_shelfFrames;
}

@end


@implementation BookShelfLayout

- (id)init
{
    if (!(self = [super init])) return nil;
    
    // Specify Flow Layout properties
    self.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.minimumInteritemSpacing = 20.0f;
    self.minimumLineSpacing = 50;
    self.itemSize = (CGSize){75, 100};
    self.headerReferenceSize = (CGSize){43,43};
    
    //Register Decoration View Class
    [self registerClass:[BookShelfDecorationView class]
          forDecorationViewOfKind:[BookShelfDecorationView kind]];

    return self;
}

#pragma mark Layout Setup 

- (void)prepareLayout
{
    [super prepareLayout];
    [self prepareShelfFrameLayouts];
}

- (void) prepareShelfFrameLayouts
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    int sectionCount = [self.collectionView numberOfSections];
    
    CGFloat y = 0;
    CGFloat availableWidth = self.collectionViewContentSize.width - (self.sectionInset.left + self.sectionInset.right);
    int itemsAcross = floorf((availableWidth + self.minimumInteritemSpacing) / (self.itemSize.width + self.minimumInteritemSpacing));
    
    // Iterate through the sections to see how many shelves are needed for each
    for (int section = 0; section < sectionCount; section++)
    {
        // for each shelf, compute its Y offset which is determined by:
        //  header height
        //  section top inset height
        //  cell item height (minus small offset to position "behind" the cells)
        //
        y += self.headerReferenceSize.height;
        y += self.sectionInset.top;
        
        int itemCount = [self.collectionView numberOfItemsInSection:section];
        int rows = ceilf(itemCount/(float)itemsAcross);
        for (int row = 0; row < rows; row++)
        {
            y += self.itemSize.height;
            dictionary[[NSIndexPath indexPathForItem:row inSection:section]] = [NSValue valueWithCGRect:CGRectMake(0, y-10, self.collectionViewContentSize.width, 32)];
            
            if (row < rows - 1)
                y += self.minimumLineSpacing;
        }
        
        // End of section. Increment Y offset by the sizes of:
        //   footer reference size
        //   section bottom inset height
        y += self.sectionInset.bottom;
        y += self.footerReferenceSize.height;
    }
    
    _shelfFrames = [NSDictionary dictionaryWithDictionary:dictionary];

}

#pragma mark Runtime Layout Calculations
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    // call super so flow layout can return default attributes for all cells, headers, and footers
    // NOTE: Flow layout has already taken care of the Cell view layout attributes! :)
    NSArray *array = [super layoutAttributesForElementsInRect:rect];

    // create a mutable copy so we can add layout attributes for any shelfs that
    // have frames that intersect the rect the CollectionView is interested in
    NSMutableArray *newArray = [array mutableCopy];
    
    // Add any decoration views (shelves) who's rect intersects with the
    // CGRect passed to the layout by the CollectionView
    
    [_shelfFrames enumerateKeysAndObjectsUsingBlock:^(id key, id shelfRect, BOOL *stop) {
        if (CGRectIntersectsRect([shelfRect CGRectValue], rect))
        {
            UICollectionViewLayoutAttributes *shelfAttributes =
            [self layoutAttributesForDecorationViewOfKind:[BookShelfDecorationView kind]
                                              atIndexPath:key];
            [newArray addObject:shelfAttributes];
        }
    }];
    
    return [newArray copy];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString *)decorationViewKind atIndexPath:(NSIndexPath *)indexPath
{
    id shelfRect = _shelfFrames[indexPath];
    
    // this should never happen, but just in case...
    if (!shelfRect)
        return nil;
    
    UICollectionViewLayoutAttributes *attributes =
    [UICollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:decorationViewKind
                                                                withIndexPath:indexPath];
    attributes.frame = [shelfRect CGRectValue];
    attributes.zIndex = -1; // shelves go behind other views
    
    return attributes;
}

@end
