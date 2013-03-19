//
//  HITableViewDataSource.m
//  HomeImprovements
//
//  Created by zen on 2/21/13.
//  Copyright (c) 2013 111Minutes. All rights reserved.
//

#import "DXTKTableViewDataSource.h"
#import "DXTKContentSection.h"

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
    DXTKContentSection * sectionEntity = [self.dataProvider sectionObjectForSection:section];
    id<DXTKHeaderFooterFilling> footer = [self.headerFooterMapping dequeueReusableHeaderFooterForTableView:tableView forSection:sectionEntity.sectionObject type:DXTKTableViewFooter];
    [footer fillWithObject:sectionEntity.sectionObject];
    return footer;
}

- (id)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    DXTKContentSection * sectionEntity = [self.dataProvider sectionObjectForSection:section];
    id<DXTKHeaderFooterFilling> header = [self.headerFooterMapping dequeueReusableHeaderFooterForTableView:tableView forSection:sectionEntity.sectionObject type:DXTKTableViewHeader];
    [header fillWithObject:sectionEntity.sectionObject];
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    DXTKContentSection * sectionEntity = [self.dataProvider sectionObjectForSection:section];
    return [self.headerFooterMapping heightForHeaderFooterInSection:sectionEntity.sectionObject type:DXTKTableViewFooter];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    DXTKContentSection * sectionObject = [self.dataProvider sectionObjectForSection:section];
    return [self.headerFooterMapping heightForHeaderFooterInSection:sectionObject.sectionObject type:DXTKTableViewHeader];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    if([self.dataProvider respondsToSelector:@selector(arrayOfIndexes)]){
        return [self.dataProvider arrayOfIndexes];
    }
    return nil;
}

- (void)setCellsMapping:(id<DXTKCellMapping>)cellsMapping
{

    if(!self.headerFooterMapping){
        self.headerFooterMapping = [DXTKBlockBasedHeaderFooterMapping new];
    }
    [super setCellsMapping:cellsMapping];
}

-(void)setHeaderFooterMapping:(id<DXTKHeaderFooterMapping>)headerFooterMapping
{
    _headerFooterMapping = headerFooterMapping;
    [self.headerFooterMapping setupMappingsTable:(UITableView *)self.contentView];
}

@end
