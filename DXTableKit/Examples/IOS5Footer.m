//
//  IOS5Footer.m
//  DXTableKit
//
//  Created by Vlad Korzun on 28.03.13.
//  Copyright (c) 2013 111min. All rights reserved.
//

#import "IOS5Footer.h"

@implementation IOS5Footer

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.textLabel = [[UILabel alloc] initWithFrame:self.frame];
        [self addSubview:self.textLabel];
        self.textLabel.backgroundColor = [UIColor blueColor];
    }
    return self;
}

-(void)fillWithObject:(id)object
{
    self.textLabel.text = @"Footer Label";
}

+(CGFloat)heightForHeaderFooter
{
    return 70;
}
@end
