//
//  BookShelfHeaderView.m
//  CollectionViewLayoutDemo
//
//  Created by Jay Thrash on 9/13/13.
//  Copyright (c) 2013 AirDrop Apps. All rights reserved.
//

#import "BookShelfHeaderView.h"
@interface BookShelfHeaderView()
{
    UILabel *_shelfNameLabel;
    UILabel *_shelfCountLabel;
}
@end

@implementation BookShelfHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _shelfNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,
                                                                6,
                                                                CGRectGetWidth(frame),
                                                                CGRectGetHeight(frame))];
        _shelfNameLabel.textAlignment = NSTextAlignmentLeft;
        _shelfNameLabel.font = [UIFont fontWithName:@"Avenir-Medium" size:24];
        _shelfNameLabel.textColor = [UIColor blackColor];
        _shelfNameLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:_shelfNameLabel];
        
        _shelfCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 6, CGRectGetWidth(frame)-20, CGRectGetHeight(frame))];
        _shelfCountLabel.textAlignment = NSTextAlignmentRight;
        _shelfCountLabel.font = [UIFont fontWithName:@"Avenir-Medium" size:20];
        _shelfCountLabel.textColor = [UIColor blackColor];
        _shelfCountLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:_shelfCountLabel];

    }
    return self;
}

- (void) setShelfName:(NSString *)shelfName
{
    _shelfName = shelfName;
    _shelfNameLabel.text = _shelfName;
}

- (void)setShelfCount:(int)shelfCount
{
    _shelfCount = shelfCount;
    _shelfCountLabel.text = [NSString stringWithFormat:@"%d Books", _shelfCount ];
}

+ (NSString *)kind
{
    return UICollectionElementKindSectionHeader;
}

+ (NSString *)reuseId
{
    return @"BookShelfHeaderViewId";
}

@end
