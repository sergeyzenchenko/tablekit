//
//  DXTKCollectionViewDataSource.m
//  DXTableKit
//
//  Created by Vladimir Shevchenko on 5/21/14.
//  Copyright (c) 2014 111min. All rights reserved.
//

#import "DXTKCollectionViewDataSource.h"

@interface DXTKIndexPathPair : NSObject

@property (nonatomic, strong) NSIndexPath *sourceIndexPath, *destinationIndexPath;

@end

@implementation DXTKIndexPathPair
@end

@interface DXTKCollectionViewDataSource ()

@property (nonatomic, strong) NSMutableArray *indexPathsToInsert, *indexPathsToUpdate, *indexPathsToDelete;
@property (nonatomic, strong) NSMutableArray *indexPathPairsToMove;
@property (nonatomic, strong) NSIndexSet *sectionsIndexSetToInsert, *sectionsIndexSetToDelete;

@end

@implementation DXTKCollectionViewDataSource

#pragma mark -
#pragma mark - DXTKContentProviderDelegate protocol implementation
#pragma mark -

- (void)contentProviderWillBeginUpdates:(id<DXTKContentProvider>)contentProvider
{
    self.sectionsIndexSetToInsert = nil;
    self.sectionsIndexSetToDelete = nil;
    
    self.indexPathsToInsert = [NSMutableArray new];
    self.indexPathsToUpdate = [NSMutableArray new];
    self.indexPathsToDelete = [NSMutableArray new];
    
    self.indexPathPairsToMove = [NSMutableArray new];
}

- (void)contentProviderDidEndUpdates:(id<DXTKContentProvider>)contentProvider
{
    UICollectionView *collectionView = (UICollectionView *)self.contentView;
    [collectionView performBatchUpdates:^{
        
        if (self.sectionsIndexSetToInsert) {
            [collectionView insertSections:self.sectionsIndexSetToInsert];
        }
        
        if (self.sectionsIndexSetToDelete) {
            [collectionView deleteSections:self.sectionsIndexSetToDelete];
        }
        
        if (self.indexPathsToInsert) {
            [collectionView insertItemsAtIndexPaths:self.indexPathsToInsert];
        }
        
        if (self.indexPathsToUpdate) {
            [collectionView reloadItemsAtIndexPaths:self.indexPathsToUpdate];
        }
        
        if (self.indexPathsToDelete) {
            [collectionView deleteItemsAtIndexPaths:self.indexPathsToDelete];
        }
        
        if (self.indexPathPairsToMove) {
            for (DXTKIndexPathPair *pair in self.indexPathPairsToMove) {
                [collectionView moveItemAtIndexPath:pair.sourceIndexPath toIndexPath:pair.destinationIndexPath];
            }
        }
        
    } completion:^(BOOL finished) {
        
    }];
}

- (void)contentProvider:(id<DXTKContentProvider>)contentProvider didInsertSection:(NSUInteger)section
{
    self.sectionsIndexSetToInsert = [NSIndexSet indexSetWithIndex:section];
}

- (void)contentProvider:(id<DXTKContentProvider>)contentProvider didRemoveSection:(NSUInteger)section
{
    self.sectionsIndexSetToDelete = [NSIndexSet indexSetWithIndex:section];
}

- (void)contentProvider:(id<DXTKContentProvider>)contentProvider didInsertCellAtIndexPath:(NSIndexPath*)indexPath
{
    [self.indexPathsToInsert addObject:indexPath];
}

- (void)contentProvider:(id<DXTKContentProvider>)contentProvider
 didMoveCellAtIntexPath:(NSIndexPath *)indexPath
            toIndexPath:(NSIndexPath *)newIndexPath
{
    DXTKIndexPathPair *pair = [DXTKIndexPathPair new];
    pair.sourceIndexPath = indexPath;
    pair.destinationIndexPath = newIndexPath;
    [self.indexPathPairsToMove addObject:pair];
}

- (void)contentProvider:(id<DXTKContentProvider>)contentProvider didUpdateCellAtIndexPath:(NSIndexPath *)indexPath
{
    [self.indexPathsToUpdate  addObject:indexPath];
}
- (void)contentProvider:(id<DXTKContentProvider>)contentProvider didRemoveCellAtIndexPath:(NSIndexPath*)indexPath
{
    [self.indexPathsToDelete addObject:indexPath];
}


@end
