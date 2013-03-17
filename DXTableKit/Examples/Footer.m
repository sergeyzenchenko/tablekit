//
//  Footer.m
//  DXTableKit
//
//  Created by Vlad Korzun on 17.03.13.
//  Copyright (c) 2013 111min. All rights reserved.
//

#import "Footer.h"

@implementation Footer

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor blueColor];
        self.frame = CGRectMake(0, 0, 320, 100);
    }
    return self;
}

-(void)fillWithObject:(id)object
{
    self.textLabel.text = @"ololo";
}

+(CGFloat)heightForHeaderFooter
{
    return 70;
}

@end
