//
//  GridDataSource.m
//  Grid
//
//  Created by zen on 2/18/13.
//  Copyright (c) 2013 111min. All rights reserved.
//

#import "DXTKCollectionViewDataSource.h"
#import <PSTCollectionView/PSTCollectionView.h>

@interface DXTKCollectionViewDataSource () 

@end

@implementation DXTKCollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(PSTCollectionView *)collectionView
{
    return [self.dataProvider numberOfSections];
}

- (NSInteger)collectionView:(PSUICollectionView *)view numberOfItemsInSection:(NSInteger)section;
{
    return [self.dataProvider numberOfItemsInSection:section];
}

- (id)collectionView:(PSUICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    return [self buildCellForIndexPath:indexPath];
}

- (void)collectionView:(PSTCollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self selectCellAtIndexPath:indexPath];
}

@end
