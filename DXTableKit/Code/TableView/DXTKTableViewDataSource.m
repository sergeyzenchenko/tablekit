//
//  HITableViewDataSource.m
//  HomeImprovements
//
//  Created by zen on 2/21/13.
//  Copyright (c) 2013 111Minutes. All rights reserved.
//

#import "DXTKTableViewDataSource.h"
#import "DXTKContentSection.h"

@interface DXTKTableViewDataSource ()

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
    if(self.shouldAutoDeselectCells){
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    
    [self selectCellAtIndexPath:indexPath];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    if([self.dataProvider respondsToSelector:@selector(arrayOfIndexes)]){
        return [self.dataProvider arrayOfIndexes];
    }
    return nil;
}

@end
