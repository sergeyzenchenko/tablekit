//
//  DXTKBaseHeader.m
//  DXTableKit
//
//  Created by Vlad Korzun on 18.03.13.
//  Copyright (c) 2013 111min. All rights reserved.
//

#import "DXTKBaseHeader.h"

@implementation DXTKBaseHeader

+ (CGFloat)heightForHeaderFooter
{
    return 30;
}

- (void)fillWithObject:(id)object
{
    self.textLabel.text = (NSString *)object;
}

@end
