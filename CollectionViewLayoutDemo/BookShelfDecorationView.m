//
//  BookShelfDecorationView.m
//  CollectionViewLayoutDemo
//
//  Created by Jay Thrash on 9/13/13.
//  Copyright (c) 2013 AirDrop Apps. All rights reserved.
//

#import "BookShelfDecorationView.h"

@interface BookShelfDecorationView()
{
    UIImageView *shelfTexture;
}
@end

@implementation BookShelfDecorationView

+ (NSString *)kind
{
    return @"BookShelfDecorationView";
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImage *background = [[UIImage imageNamed:@"shelf"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 20, 0, 20)];
        
        shelfTexture = [[UIImageView alloc] initWithFrame:CGRectMake(0,
                                                                     0,
                                                                     CGRectGetWidth(frame),
                                                                     CGRectGetHeight(frame))];
        shelfTexture.image = background;
        [self addSubview:shelfTexture];
    }
    return self;
}

@end
