//
//  DXTKBaseDataSourceSpec.m
//  DXTableKit
//
//  Created by Sergey Zenchenko on 4/2/14.
//  Copyright 2014 111min. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "DXTKBaseDataSource.h"


SPEC_BEGIN(DXTKBaseDataSourceSpec)

__block DXTKBaseDataSource *dataSource;
__block NSObject *contentViewMock;
__block NSObject<DXTKContentProvider> *contentProviderMock;

beforeEach(^{
    contentViewMock = [KWMock nullMock];
    contentProviderMock = [KWMock nullMockForProtocol:@protocol(DXTKContentProvider)];
    
    dataSource = [[DXTKBaseDataSource alloc] initWithContentView:contentViewMock
                                                contentProvider:contentProviderMock
                                                       delegate:nil];
    
    
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
        NSObject<DXTKDataSourcePlugin> *plugin = [KWMock nullMock];
        
        [[plugin should] receive:@selector(reload)];
        
        [dataSource attachPlugin:plugin];
        
        [dataSource reload];
    });
});

SPEC_END
