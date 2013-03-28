//
//  IOS5Header.m
//  DXTableKit
//
//  Created by Vlad Korzun on 28.03.13.
//  Copyright (c) 2013 111min. All rights reserved.
//

#import "IOS5Header.h"

@implementation IOS5Header

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.textLabel = [[UILabel alloc] initWithFrame:self.frame];
        [self addSubview:self.textLabel];
        self.textLabel.backgroundColor = [UIColor orangeColor];
    }
    return self;
}

-(void)fillWithObject:(id)object
{
    self.textLabel.text = (NSString *)object;
}

+(CGFloat)heightForHeaderFooter
{
    return 50;
}

@end
