//
// Created by Sergey Zenchenko on 4/2/14.
// Copyright (c) 2014 111min. All rights reserved.
//

#import "DXTKCollectionViewDataSourceBuilder.h"
#import "DXTKCollectionViewDataSource.h"
#import "DXTKBuilder+Private.h"

@implementation DXTKCollectionViewDataSourceBuilder

- (void)registerCellClass:(Class)cellClass forDomainObjectClass:(Class)domainClass
{
    [self.contentView registerClass:cellClass forCellWithReuseIdentifier:NSStringFromClass(domainClass)];
}

- (void)registerNib:(UINib *)nib forDomainObjectClass:(Class)domainClass
{
    [self.contentView registerNib:nib forCellWithReuseIdentifier:NSStringFromClass(domainClass)];
}

- (Class)dataSourceClass
{
    return [DXTKCollectionViewDataSource class];
}

@end