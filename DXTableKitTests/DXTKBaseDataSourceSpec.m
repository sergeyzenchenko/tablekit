//
//  DXTKBaseDataSourceSpec.m
//  DXTableKit
//
//  Created by Sergey Zenchenko on 4/2/14.
//  Copyright 2014 111min. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "DXTKBaseDataSource.h"
#import "DXTKDataSourceDelegate.h"
#import "DXTKBaseDataSourcePlugin.h"

SPEC_BEGIN(DXTKBaseDataSourceSpec)

__block DXTKBaseDataSource *dataSource;
__block NSObject *contentViewMock;
__block NSObject<DXTKContentProvider> *contentProviderMock;
__block NSObject<DXTKDataSourceDelegate> *delegateMock;
__block NSObject<DXTKContentProviderDelegate> *contentProviderDelegateMock;

beforeEach(^{
    contentViewMock = [KWMock nullMock];
    contentProviderMock = [KWMock nullMockForProtocol:@protocol(DXTKContentProvider)];
    
    [contentProviderMock stub:@selector(setDelegate:) withBlock:^id(NSArray *params) {
        contentProviderDelegateMock = params[0];
        [contentProviderMock stub:@selector(delegate) andReturn:contentProviderDelegateMock];
        return nil;
    }];
    
    delegateMock = [KWMock mockForProtocol:@protocol(DXTKDataSourceDelegate)];
    
    dataSource = [[DXTKBaseDataSource alloc] initWithContentView:contentViewMock
                                                contentProvider:contentProviderMock
                                                       delegate:delegateMock];
    
    
});

describe(@"#attachPlugin", ^{
    it(@"Should attach plugin", ^{
        NSObject<DXTKDataSourcePlugin> *plugin = [KWMock mock];
        
        [[plugin should] receive:@selector(attachToDataSource:) withArguments:dataSource, nil];
        
        [dataSource attachPlugin:plugin];
        
        NSArray *plugins = [dataSource performSelector:@selector(plugins)];
        
        [[plugins should] containObjects:plugin, nil];
    });
});

describe(@"#reload", ^{
    it(@"Should reload plugins", ^{
        NSObject<DXTKDataSourcePlugin> *plugin = [KWMock nullMock];
        
        [[plugin should] receive:@selector(reload)];
        
        [dataSource attachPlugin:plugin];
        
        [dataSource reload];
    });
    
    it(@"Should reload content provider", ^{
        [[contentProviderMock should] receive:@selector(reload)];
        
        [dataSource reload];
    });
});

describe(@"#reloadContentView", ^{
    it(@"Should reload contentView", ^{
        [[contentViewMock should] receive:@selector(reloadData)];
        
        [dataSource reloadContentView];
    });
});

describe(@"#buildCellForIndexPath:", ^{
    it(@"Should build cell", ^{
        NSObject *domainObjectMock = [KWMock mock];
        NSObject *cellMock = [KWMock mock];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:2 inSection:0];
        
        [contentProviderMock stub:@selector(itemForIndexPath:) andReturn:domainObjectMock withArguments:indexPath, nil];
        
        [dataSource stub:@selector(buildCellForDomainObject:indexPath:)
               andReturn:cellMock
           withArguments:domainObjectMock, indexPath];
        
        [[cellMock should] receive:@selector(fillWithObject:) withArguments:domainObjectMock, nil];
        
        [[(NSObject*)[dataSource buildCellForIndexPath:indexPath] should] equal:cellMock];
    });
});

describe(@"#selectCellAtIndexPath:", ^{
    it(@"Should send selected object to all plugins", ^{
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
        
        id domainObject = [KWMock nullMock];
        
        [contentProviderMock stub:@selector(itemForIndexPath:) andReturn:domainObject withArguments:indexPath, nil];
        
        [[delegateMock should] receive:@selector(didSelectDomainObject:atIndexPath:fromDataSource:)
                   withArguments:domainObject, indexPath, dataSource, nil];
        
        NSObject<DXTKDataSourcePlugin> *plugin = [DXTKBaseDataSourcePlugin new];
        
        [[plugin should] receive:@selector(didSelectDomainObject:atIndexPath:fromDataSource:)
                         withArguments:domainObject, indexPath, dataSource, nil];
        
        [dataSource attachPlugin:plugin];
        
        [dataSource selectCellAtIndexPath:indexPath];
    });
});

describe(@"#attachPlugin:", ^{
    __block NSObject<DXTKDataSourcePlugin> *plugin;
    
    beforeEach(^{
        plugin = [KWMock nullMockForProtocol:@protocol(DXTKDataSourcePlugin)];
    });
    
    it(@"Should attach file to dataSource", ^{
        [[[plugin should] receive] attachToDataSource:dataSource];
        
        [dataSource attachPlugin:plugin];
    });
    
    it(@"Should add plugin to plugins list", ^{
        [dataSource attachPlugin:plugin];
        
        NSArray *plugins = [dataSource performSelector:@selector(plugins)];
        
        [[plugins should] containObjects:plugin, nil];
    });
    
    it(@"Should add plugin to multicast delegate", ^{
        NSObject *delegate = [KWMock mock];
        [dataSource stub:@selector(contentProviderDelegateProxy) andReturn:delegate];
        
        [[delegate should] receive:@selector(addDelegate:) withArguments:plugin, nil];
        
        [dataSource attachPlugin:plugin];
    });
    
    it(@"Should raise an exception if nil plugin received", ^{
        [[theBlock(^{
            [dataSource attachPlugin:nil];
        }) should] raise];
    });
    
    it(@"Should raise an exception if plugin is not implemented DXTKDataSourcePlugin", ^{
        [[theBlock(^{
            [dataSource attachPlugin:(id)@""];
        }) should] raise];
    });
});

describe(@"Content provider callbacks", ^{
    __block NSObject<DXTKDataSourcePlugin> *plugin;
    __block NSArray *targets;
    
    beforeEach(^{
        plugin = [DXTKBaseDataSourcePlugin new];
        [dataSource attachPlugin:plugin];
        targets = @[plugin, dataSource];
    });
    
    it(@"#contentProviderDidStartLoading:", ^{

        [targets enumerateObjectsUsingBlock:^(NSObject *obj, NSUInteger idx, BOOL *stop) {
            [[[obj should] receive] contentProviderDidStartLoading:contentProviderMock];
        }];
        
        [contentProviderMock.delegate contentProviderDidStartLoading:contentProviderMock];
    });
    
    it(@"#contentProvider:didFinishLoadingWithError:", ^{
        
        NSError *error = [KWMock mock];
        
        [targets enumerateObjectsUsingBlock:^(NSObject *obj, NSUInteger idx, BOOL *stop) {
            [[[obj should] receive] contentProvider:contentProviderMock didFinishLoadingWithError:error];
        }];
        
        [contentProviderMock.delegate contentProvider:contentProviderMock didFinishLoadingWithError:error];
    });
    
    it(@"#contentProviderDidFinishLoading:", ^{
        
        [targets enumerateObjectsUsingBlock:^(NSObject *obj, NSUInteger idx, BOOL *stop) {
            [[[obj should] receive] contentProviderDidFinishLoading:contentProviderMock];
        }];
        
        [contentProviderMock.delegate contentProviderDidFinishLoading:contentProviderMock];
    });
    
    it(@"#contentProviderWillChangeState:", ^{
        
        [targets enumerateObjectsUsingBlock:^(NSObject *obj, NSUInteger idx, BOOL *stop) {
            [[[obj should] receive] contentProviderWillChangeState:contentProviderMock];
        }];
        
        [contentProviderMock.delegate contentProviderWillChangeState:contentProviderMock];
    });
    
    it(@"#contentProviderDidChangeState:", ^{
        
        [targets enumerateObjectsUsingBlock:^(NSObject *obj, NSUInteger idx, BOOL *stop) {
            [[[obj should] receive] contentProviderDidChangeState:contentProviderMock];
        }];
        
        [contentProviderMock.delegate contentProviderDidChangeState:contentProviderMock];
    });
    
    it(@"#contentProviderWillBeginUpdates:", ^{
        
        [targets enumerateObjectsUsingBlock:^(NSObject *obj, NSUInteger idx, BOOL *stop) {
            [[[obj should] receive] contentProviderWillBeginUpdates:contentProviderMock];
        }];
        
        [contentProviderMock.delegate contentProviderWillBeginUpdates:contentProviderMock];
    });
    
    it(@"#contentProviderDidEndUpdates:", ^{
        
        [targets enumerateObjectsUsingBlock:^(NSObject *obj, NSUInteger idx, BOOL *stop) {
            [[[obj should] receive] contentProviderDidEndUpdates:contentProviderMock];
        }];
        
        [contentProviderMock.delegate contentProviderDidEndUpdates:contentProviderMock];
    });
});

SPEC_END
