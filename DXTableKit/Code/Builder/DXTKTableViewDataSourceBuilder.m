//
// Created by Sergey Zenchenko on 4/2/14.
// Copyright (c) 2014 111min. All rights reserved.
//

#import "DXTKTableViewDataSourceBuilder.h"
#import "DXTKTableViewDataSource.h"
#import "DXTKBuilder+Private.h"

@implementation DXTKTableViewDataSourceBuilder

- (Class)dataSourceClass
{
    return [DXTKTableViewDataSource class];
}

- (void)registerCellClass:(Class)cellClass forDomainObjectClass:(Class)domainClass
{
    [self.contentView registerClass:cellClass forCellReuseIdentifier:NSStringFromClass(domainClass)];
}

- (void)registerNib:(UINib *)nib forDomainObjectClass:(Class)domainClass
{
    [self.contentView registerNib:nib forCellReuseIdentifier:NSStringFromClass(domainClass)];
}

@end