//
//  HITableViewDataSource.m
//  HomeImprovements
//
//  Created by zen on 2/21/13.
//  Copyright (c) 2013 111Minutes. All rights reserved.
//

#import "DXTKTableViewDataSource.h"
#import "DXTKContentProvider.h"

@interface DXTKTableViewDataSource ()

@end

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

#pragma mark -
#pragma mark -
#pragma mark -

- (UITableView *)tableView
{
    return (UITableView *)self.contentView;
}

#pragma mark - 
#pragma mark - DXTKContentProviderDelegate protocol implementation
#pragma mark -

- (void)contentProviderWillBeginUpdates:(id<DXTKContentProvider>)contentProvider
{
    [self.tableView beginUpdates];
}

- (void)contentProviderDidEndUpdates:(id<DXTKContentProvider>)contentProvider
{
    [self.tableView endUpdates];
}

- (void)contentProvider:(id<DXTKContentProvider>)contentProvider didInsertSection:(NSUInteger)section
{
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:section];
    [self.tableView insertSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
}

- (void)contentProvider:(id<DXTKContentProvider>)contentProvider didRemoveSection:(NSUInteger)section
{
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:section];
    [self.tableView deleteSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
}

- (void)contentProvider:(id<DXTKContentProvider>)contentProvider didInsertCellAtIndexPath:(NSIndexPath*)indexPath
{
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

- (void)contentProvider:(id<DXTKContentProvider>)contentProvider
 didMoveCellAtIntexPath:(NSIndexPath *)indexPath
            toIndexPath:(NSIndexPath *)newIndexPath
{
    [self.tableView moveRowAtIndexPath:indexPath toIndexPath:newIndexPath];
}

- (void)contentProvider:(id<DXTKContentProvider>)contentProvider didUpdateCellAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}
- (void)contentProvider:(id<DXTKContentProvider>)contentProvider didRemoveCellAtIndexPath:(NSIndexPath*)indexPath
{
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}


@end
