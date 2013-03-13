//
//  HIBaseDataSource.m
//  Grid
//
//  Created by zen on 2/20/13.
//  Copyright (c) 2013 111min. All rights reserved.
//

#import "DXTKBaseDataSource.h"

@interface DXTKBaseDataSource ()

@property (nonatomic, strong) NSMutableArray *plugins;

@end

@implementation DXTKBaseDataSource

- (id)init
{
    self = [super init];
    if (self) {
        self.plugins = [NSMutableArray new];
        [self setup];
    }
    return self;
}

- (void)setup
{

}

- (void)attachPlugin:(id<DXTKDataSourcePlugin>)plugin
{
    [plugin attachToDataSource:self];
    [self.plugins addObject:plugin];
}

- (void)setContentView:(UIView *)contentView
{
    if (_contentView != contentView) {
        _contentView = contentView;
        [(id)(self.contentView) setDelegate:(id)self];
        [(id)(self.contentView) setDataSource:(id)self];
        [self reload];
    }
}

- (void)setDataProvider:(id<DXTKContentProvider>)dataProvider
{
    NSParameterAssert([dataProvider conformsToProtocol:@protocol(DXTKContentProvider)]);
    if (_dataProvider != dataProvider) {
        _dataProvider = dataProvider;
        _dataProvider.delegate = self;
        [self reload];
    }
}

- (void)setCellsMapping:(id<DXTKCellMapping>)cellsMapping
{
    NSParameterAssert([cellsMapping conformsToProtocol:@protocol(DXTKCellMapping)]);
    if (_cellsMapping != cellsMapping) {
        _cellsMapping = cellsMapping;
        [_cellsMapping setupMappingsForCollectionViewOrTable:self.contentView];
        [self reload];
    }
}

- (void)reload
{
    if (!self.cellsMapping) {
        self.cellsMapping = [DXTKBlockBasedCellMapping shared];
        return;
    }

    [self.plugins makeObjectsPerformSelector:@selector(reload)];
    
    [self.dataProvider reload];
}

- (void)reloadContentView
{
    [(id)(self.contentView) reloadData];
}

- (id<DXTKBaseCell>)buildCellForIndexPath:(NSIndexPath*)indexPath
{
    id domainObject = [self.dataProvider itemForIndexPath:indexPath];

    NSParameterAssert(domainObject != nil);
    
    id<DXTKBaseCell> cell = [self.cellsMapping dequeueReusableCellFromCollectionViewOrTable:self.contentView forDomainObject:domainObject indexPath:indexPath];

    NSParameterAssert(cell != nil);
    
    [cell fillWithObject:domainObject];
    
    return cell;
}

- (void)selectCellAtIndexPath:(NSIndexPath*)indexPath
{
    if ([self.delegate respondsToSelector:@selector(didSelectDomainObject:fromDataSource:)]) {
        [self.delegate didSelectDomainObject:[self.dataProvider itemForIndexPath:indexPath] fromDataSource:self];
    }
}

#pragma mark -
#pragma mark HIDataProviderDelegate

- (void)dataProvider:(id <DXTKContentProvider>)dataProvider didFinishLoadingWithError:(NSError *)error
{
    [self.plugins enumerateObjectsUsingBlock:^(id <DXTKDataSourcePlugin> plugin, NSUInteger idx, BOOL *stop) {
        [plugin dataProvider:dataProvider didFinishLoadingWithError:error];
    }];
}

- (void)dataProviderDidFinishLoading:(id <DXTKContentProvider>)dataProvider
{
    [self.plugins enumerateObjectsUsingBlock:^(id <DXTKDataSourcePlugin> plugin, NSUInteger idx, BOOL *stop) {
        [plugin dataProviderDidFinishLoading:dataProvider];
    }];
    
    [self reloadContentView];
}


@end
