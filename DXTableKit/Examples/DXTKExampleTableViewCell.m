//
//  DXTKExampleTableViewCell.m
//  DXTableKit
//
//  Created by Sergey Zenchenko on 4/3/14.
//  Copyright (c) 2014 111min. All rights reserved.
//

#import "DXTKExampleTableViewCell.h"

@implementation DXTKExampleTableViewCell

- (void)fillWithObject:(NSNumber*)number
{
    self.textLabel.text = [number stringValue];
}

@end
