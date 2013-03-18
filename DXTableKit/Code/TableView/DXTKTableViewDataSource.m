//
//  HITableViewDataSource.m
//  HomeImprovements
//
//  Created by zen on 2/21/13.
//  Copyright (c) 2013 111Minutes. All rights reserved.
//

#import "DXTKTableViewDataSource.h"

@interface DXTKTableViewDataSource () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation DXTKTableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.dataProvider numberOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataProvider numberOfItemsInSection:section];
}

- (id)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self buildCellForIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self selectCellAtIndexPath:indexPath];
}

- (id)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    id sectionObject = [self.dataProvider sectionObjectForSection:section];
    id<DXTKHeaderFooterFilling> footer = [self.headerFooterMapping dequeueReusableHeaderFooterForTableView:tableView forSection:sectionObject type:@"Footer"];
    [footer fillWithObject:sectionObject];
    return footer;
}

- (id)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    id sectionObject = [self.dataProvider sectionObjectForSection:section];
    id<DXTKHeaderFooterFilling> header = [self.headerFooterMapping dequeueReusableHeaderFooterForTableView:tableView forSection:sectionObject type:@"Header"];
    [header fillWithObject:sectionObject];
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    id sectionObject = [self.dataProvider sectionObjectForSection:section];
    return [self.headerFooterMapping heightForHeaderFooterInSection:sectionObject type:@"Footer"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    id sectionObject = [self.dataProvider sectionObjectForSection:section];
    return [self.headerFooterMapping heightForHeaderFooterInSection:sectionObject type:@"Header"];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    if([self.dataProvider respondsToSelector:@selector(arrayOfIndexes)]){
        return [self.dataProvider arrayOfIndexes];
    }
    return nil;
}

@end
