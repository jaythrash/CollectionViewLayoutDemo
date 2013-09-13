//
//  BookShelfHeaderView.h
//  CollectionViewLayoutDemo
//
//  Created by Jay Thrash on 9/13/13.
//  Copyright (c) 2013 AirDrop Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookShelfHeaderView : UICollectionReusableView

+ (NSString *)kind;
+ (NSString *)reuseId;

@property (nonatomic, copy) NSString *shelfName;
@property (nonatomic, assign) int shelfCount;
@end
