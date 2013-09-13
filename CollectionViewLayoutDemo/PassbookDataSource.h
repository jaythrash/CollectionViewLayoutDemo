//
//  PassbookDataSource.h
//  CollectionViewLayoutDemo
//
//  Created by Jay Thrash on 9/13/13.
//  Copyright (c) 2013 AirDrop Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CardState) {
    CardState_Normal,           // Display card stacked normally in the deck
    CardState_Selected,         // Display card on its own at top of CollectionView
    CardState_Collapsed         // Display card collapsed to bottom of CollectionView
};

@interface PassbookDataSource : NSObject<UICollectionViewDataSource>

- (CardState)cardStateAtIndexPath: (NSIndexPath *)indexPath;
- (void) selectCardAtIndexPath: (NSIndexPath *)indexPath;

@end
