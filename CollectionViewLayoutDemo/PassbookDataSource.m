//
//  PassbookDataSource.m
//  CollectionViewLayoutDemo
//
//  Created by Jay Thrash on 9/13/13.
//  Copyright (c) 2013 AirDrop Apps. All rights reserved.
//

#import "PassbookDataSource.h"
#import "PassbookCell.h"

@interface PassbookDataSource()
{
    NSMutableArray *_cards;
}

@end

@implementation PassbookDataSource

- (id)init
{
    if (!(self = [super init])) return nil;
    [self resetCards];
    return self;
}

- (void)resetCards
{
    // just some simple sample data indicating the number of books in each section
    _cards = [[NSMutableArray alloc] initWithArray:
                 @[ [NSNumber numberWithInt:CardState_Normal],
                    [NSNumber numberWithInt:CardState_Normal],
                    [NSNumber numberWithInt:CardState_Normal],
                    [NSNumber numberWithInt:CardState_Normal],
                    [NSNumber numberWithInt:CardState_Normal],
                    [NSNumber numberWithInt:CardState_Normal]]];
}

- (CardState)cardStateAtIndexPath:(NSIndexPath *)indexPath
{
    NSNumber *cardState = _cards[indexPath.row];
    return [cardState intValue];
}

- (void)selectCardAtIndexPath:(NSIndexPath *)indexPath
{
    CardState cardState = [self cardStateAtIndexPath:indexPath];
    
    switch (cardState) {
        case CardState_Normal:
            [self collapseRows:indexPath.row];
            break;
            
        case CardState_Selected:
        case CardState_Collapsed:
            [self expandRows];
        default:
            break;
    }
    
}

- (void) expandRows
{
    // set all cards back to Normal state
    [self resetCards];
}

- (void) collapseRows: (NSUInteger)selectedRow
{
    for (NSUInteger index=0; index < [_cards count]; index++) {
        if (index == selectedRow) {
            _cards[index] = [NSNumber numberWithInt:CardState_Selected];
        }
        else {
            _cards[index] = [NSNumber numberWithInt:CardState_Collapsed];
        }
    }
}



-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PassbookCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[PassbookCell reuseId]
                                                               forIndexPath:indexPath];
    
    [cell setLabel:[NSString stringWithFormat:@"Card %d", indexPath.row]];
    
    return cell;
}

@end
