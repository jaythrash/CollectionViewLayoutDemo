//
//  BookCell.m
//  CollectionViewLayoutDemo
//
//  Created by Jay Thrash on 9/13/13.
//  Copyright (c) 2013 AirDrop Apps. All rights reserved.
//

#import "BookCell.h"

@implementation BookCell


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame))];
    if (self) {
        self.backgroundView = [[UIView alloc] initWithFrame:self.frame];
        self.backgroundView.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.f
                                                              green:arc4random_uniform(256)/255.f
                                                               blue:arc4random_uniform(256)/255.f
                                                              alpha:1];

    }
    return self;
}

+ (NSString *)reuseId
{
    return @"BookCellId";
}
@end
