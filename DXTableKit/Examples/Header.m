//
//  DXTKHeader.m
//  DXTableKit
//
//  Created by Vlad Korzun on 17.03.13.
//  Copyright (c) 2013 111min. All rights reserved.
//

#import "Header.h"

@implementation Header

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor orangeColor];
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
