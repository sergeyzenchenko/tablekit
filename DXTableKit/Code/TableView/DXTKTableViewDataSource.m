//
//  HITableViewDataSource.m
//  HomeImprovements
//
//  Created by zen on 2/21/13.
//  Copyright (c) 2013 111Minutes. All rights reserved.
//

#import "DXTKTableViewDataSource.h"

@implementation DXTKTableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.contentProvider numberOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.contentProvider numberOfItemsInSection:section];
}

- (id)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self buildCellForIndexPath:indexPath];
}

- (id<DXTKCell>)buildCellForDomainObject:(id)domainObject indexPath:(NSIndexPath*)indexPath
{
    return [self.contentView dequeueReusableCellWithIdentifier:NSStringFromClass([domainObject class])
                                                  forIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self selectCellAtIndexPath:indexPath];
}

@end
