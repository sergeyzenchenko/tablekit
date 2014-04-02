//
//  DXTKTableViewCellBuilder.m
//  DXTableKit
//
//  Created by Sergey Zenchenko on 4/1/14.
//  Copyright (c) 2014 111min. All rights reserved.
//

#import "DXTKTableViewCellBuilder.h"

@implementation DXTKTableViewCellBuilder

- (Class)contentViewClass
{
    return [UITableView class];
}

- (void)setupNib:(UINib*)nib forKey:(NSString*)key
{
    [self.contentView registerNib:nib forCellReuseIdentifier:key];
}

- (void)setupCellClass:(Class)class forKey:(NSString*)key
{
    [self.contentView registerClass:class forCellReuseIdentifier:key];
}

- (id<DXTKCell>)buildCellForDomainObject:(id)domainObject indexPath:(NSIndexPath*)indexPath
{
    return [self.contentView dequeueReusableCellWithIdentifier:NSStringFromClass([domainObject class])
                                                  forIndexPath:indexPath];
}

@end
