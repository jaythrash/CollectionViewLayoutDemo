//
//  PassbookCell.m
//  CollectionViewLayoutDemo
//
//  Created by Jay Thrash on 9/13/13.
//  Copyright (c) 2013 AirDrop Apps. All rights reserved.
//

#import "PassbookCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation PassbookCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame))];
    if (self) {
        UIView *cardView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame))];
        cardView.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.f
                                                   green:arc4random_uniform(256)/255.f
                                                    blue:arc4random_uniform(256)/255.f
                                                   alpha:1];
        cardView.layer.cornerRadius = 10;
        cardView.layer.borderColor = [UIColor darkGrayColor].CGColor;
        cardView.layer.borderWidth = 2;
        cardView.clipsToBounds = YES;
        [self.contentView addSubview:cardView];
        
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(0, -2);
        self.layer.shadowOpacity = .75;
        self.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:10].CGPath;
        
        self.clipsToBounds = NO;
    }
    return self;
}

- (void)setLabel:(NSString *)label
{
    UILabel *cardLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 3, CGRectGetWidth(self.contentView.frame), 60)];
    cardLabel.textAlignment = NSTextAlignmentLeft;
    cardLabel.font = [UIFont fontWithName:@"Avenir-Medium" size:42];
    cardLabel.textColor = [UIColor whiteColor];
    cardLabel.backgroundColor = [UIColor clearColor];
    cardLabel.text = label;
    [self.contentView addSubview:cardLabel];
}

+ (NSString *)reuseId
{
    return @"PassbookCellId";
}

@end
