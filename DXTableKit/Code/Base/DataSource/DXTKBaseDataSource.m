//
//  HIBaseDataSource.m
//  Grid
//
//  Created by zen on 2/20/13.
//  Copyright (c) 2013 111min. All rights reserved.
//

#import "DXTKBaseDataSource.h"
#import "DXTKDataSourcePlugin.h"
#import "DXTKDataSource.h"
#import "DXTKDataSourceDelegate.h"
#import "DXTKDelegateProxyPlugin.h"

@interface DXTKBaseDataSource () <DXTKContentProviderDelegate>

@property (nonatomic, strong) NSMutableArray *plugins;
@property (nonatomic, strong) id<DXTKContentProvider> contentProvider;
@property (nonatomic, strong) id<DXTKCellBuilder> cellBuilder;
@property (nonatomic, weak) id contentView;

@end

@implementation DXTKBaseDataSource

- (id)initWithContentView:(id)contentView
          contentProvider:(id<DXTKContentProvider>)contentProvider
                 delegate:(id<DXTKDataSourceDelegate>)delegate

{
    self = [super init];
    if (self) {
        self.plugins = [NSMutableArray new];

        self.contentView = contentView;
        self.contentProvider = contentProvider;
        
        [self attachPlugin:[[DXTKDelegateProxyPlugin alloc] initWithDelegate:delegate]];
    }

    return self;
}

- (void)attachPlugin:(id <DXTKDataSourcePlugin>)plugin
{
    [plugin attachToDataSource:self];
    [self.plugins addObject:plugin];
}

- (void)reload
{
    [self.plugins makeObjectsPerformSelector:@selector(reload)];
    [self.contentProvider reload];
}

- (void)reloadContentView
{
    [(id) (self.contentView) reloadData];
}

- (id <DXTKCell>)buildCellForIndexPath:(NSIndexPath *)indexPath
{
    id domainObject = [self.contentProvider itemForIndexPath:indexPath];

    id <DXTKCell> cell = [self.cellBuilder buildCellForDomainObject:domainObject
                                                          indexPath:indexPath];
    [cell fillWithObject:domainObject];

    return cell;
}

#pragma mark - Plugins callbacks forwarding

- (void)selectCellAtIndexPath:(NSIndexPath *)indexPath
{
    id domainObject = [self.contentProvider itemForIndexPath:indexPath];

    [self.plugins enumerateObjectsUsingBlock:^(id <DXTKDataSourcePlugin> plugin, NSUInteger idx, BOOL *stop) {
        [plugin didSelectDomainObject:domainObject
                          atIndexPath:indexPath
                       fromDataSource:self];
    }];
}

- (void)contentProviderDidStartLoading:(id <DXTKContentProvider>)contentProvider
{
    [self.plugins enumerateObjectsUsingBlock:^(id <DXTKDataSourcePlugin> plugin, NSUInteger idx, BOOL *stop) {
        [plugin contentProviderDidStartLoading:contentProvider];
    }];
}

- (void)contentProvider:(id <DXTKContentProvider>)contentProvider didFinishLoadingWithError:(NSError *)error
{
    [self.plugins enumerateObjectsUsingBlock:^(id <DXTKDataSourcePlugin> plugin, NSUInteger idx, BOOL *stop) {
        [plugin contentProvider:contentProvider didFinishLoadingWithError:error];
    }];
}

- (void)contentProviderDidFinishLoading:(id <DXTKContentProvider>)contentProvider
{
    [self.plugins enumerateObjectsUsingBlock:^(id <DXTKDataSourcePlugin> plugin, NSUInteger idx, BOOL *stop) {
        [plugin contentProviderDidFinishLoading:contentProvider];
    }];
}

- (void)contentProviderWillChangeState:(id <DXTKContentProvider>)contentProvider
{
    [self.plugins enumerateObjectsUsingBlock:^(id <DXTKDataSourcePlugin> plugin, NSUInteger idx, BOOL *stop) {
        [plugin contentProviderWillChangeState:contentProvider];
    }];
}

- (void)contentProviderDidChangeState:(id <DXTKContentProvider>)contentProvider
{
    [self.plugins enumerateObjectsUsingBlock:^(id <DXTKDataSourcePlugin> plugin, NSUInteger idx, BOOL *stop) {
        [plugin contentProviderDidChangeState:contentProvider];
    }];
}

- (void)contentProviderWillBeginUpdates:(id <DXTKContentProvider>)contentProvider
{
    [self.plugins enumerateObjectsUsingBlock:^(id <DXTKDataSourcePlugin> plugin, NSUInteger idx, BOOL *stop) {
        [plugin contentProviderWillBeginUpdates:contentProvider];
    }];
}

- (void)contentProviderDidEndUpdates:(id <DXTKContentProvider>)contentProvider
{
    [self.plugins enumerateObjectsUsingBlock:^(id <DXTKDataSourcePlugin> plugin, NSUInteger idx, BOOL *stop) {
        [plugin contentProviderDidEndUpdates:contentProvider];
    }];
}

@end
