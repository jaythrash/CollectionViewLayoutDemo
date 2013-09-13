//
//  PassbookCell.h
//  CollectionViewLayoutDemo
//
//  Created by Jay Thrash on 9/13/13.
//  Copyright (c) 2013 AirDrop Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PassbookCell : UICollectionViewCell

- (void)setLabel:(NSString *)label;

+ (NSString *)reuseId;

@end

