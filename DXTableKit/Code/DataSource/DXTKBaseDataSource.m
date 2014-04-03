//
//  HIBaseDataSource.m
//  Grid
//
//  Created by zen on 2/20/13.
//  Copyright (c) 2013 111min. All rights reserved.
//

#import <LBDelegateMatrioska/LBDelegateMatrioska.h>
#import "DXTKBaseDataSource.h"
#import "DXTKDataSourcePlugin.h"
#import "DXTKDataSource.h"
#import "DXTKDataSourceDelegate.h"


@interface DXTKBaseDataSource ()

@property (nonatomic, strong) NSMutableArray *plugins;
@property (nonatomic, strong) id<DXTKContentProvider> contentProvider;
@property (nonatomic, weak) id contentView;

@property (nonatomic, strong) LBDelegateMatrioska<DXTKContentProviderDelegate, DXTKDataSourceDelegate> *contentProviderDelegateProxy;

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
        
        self.contentProviderDelegateProxy = (id)[[LBDelegateMatrioska alloc] initWithDelegates:@[self]];
        
        [self.contentProvider setDelegate:self.contentProviderDelegateProxy];
        
        if (delegate) {
            [self.contentProviderDelegateProxy addDelegate:delegate];
        }
    }

    return self;
}

- (void)attachPlugin:(id <DXTKDataSourcePlugin>)plugin
{
    NSParameterAssert(plugin);
    
    [plugin attachToDataSource:self];
    [self.plugins addObject:plugin];
    [self.contentProviderDelegateProxy addDelegate:plugin];
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

    id <DXTKCell> cell = [self buildCellForDomainObject:domainObject
                                                          indexPath:indexPath];
    [cell fillWithObject:domainObject];

    return cell;
}

- (id<DXTKCell>)buildCellForDomainObject:(id)domainObject indexPath:(NSIndexPath*)indexPath
{
    return nil;
}

#pragma mark - Plugins callbacks forwarding

- (void)selectCellAtIndexPath:(NSIndexPath *)indexPath
{
    id domainObject = [self.contentProvider itemForIndexPath:indexPath];
    
    [self.contentProviderDelegateProxy didSelectDomainObject:domainObject
                                                 atIndexPath:indexPath
                                              fromDataSource:self];
}

- (void)contentProviderDidStartLoading:(id <DXTKContentProvider>)contentProvider
{
    
}

- (void)contentProvider:(id <DXTKContentProvider>)contentProvider didFinishLoadingWithError:(NSError *)error
{
    
}

- (void)contentProviderDidFinishLoading:(id <DXTKContentProvider>)contentProvider
{
    
}

- (void)contentProviderWillChangeState:(id <DXTKContentProvider>)contentProvider
{
    
}

- (void)contentProviderDidChangeState:(id <DXTKContentProvider>)contentProvider
{
    
}

- (void)contentProviderWillBeginUpdates:(id <DXTKContentProvider>)contentProvider
{
    
}

- (void)contentProviderDidEndUpdates:(id <DXTKContentProvider>)contentProvider
{
    
}

@end
