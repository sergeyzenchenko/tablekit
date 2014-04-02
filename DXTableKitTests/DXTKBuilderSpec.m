//
//  DXTKBuilderSpec.m
//  DXTableKit
//
//  Created by Sergey Zenchenko on 4/1/14.
//  Copyright 2014 111min. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "DXTKBuilder.h"
#import "DXTKTableViewDataSource.h"
#import "DXTKBaseContentProvider.h"
#import "DXTKTableViewDataSourceBuilder.h"
#import "DXTKCollectionViewDataSourceBuilder.h"
#import "DXTKBuilder+Private.h"

SPEC_BEGIN(DXTKBuilderSpec)

describe(@"initialization", ^{
   it(@"Could not be instantiated directly", ^{
       [[theBlock(^{
           [DXTKBuilder new];
       }) should] raise];
   });
});

__block DXTKBuilder *builder;

describe(@"#withContentView", ^{
    it(@"Should create table view datasource build", ^{
        UITableView *t = [UITableView new];
        builder = [DXTKBuilder withContentView:t];
        
        [[builder should] beNonNil];
        [[builder should] beKindOfClass:[DXTKTableViewDataSourceBuilder class]];
        
        [[[builder performSelector:@selector(contentView)] should] equal:t];
    });
    
    it(@"Should create collection view datasource build", ^{
        UICollectionView *c = [KWMock mockForClass:[UICollectionView class]];
        builder = [DXTKBuilder withContentView:c];
        
        [[builder should] beNonNil];
        [[builder should] beKindOfClass:[DXTKCollectionViewDataSourceBuilder class]];
        
        [[[builder performSelector:@selector(contentView)] should] equal:c];
    });
    
    it(@"Should raise an exception for unsupported classes", ^{
        [[theBlock(^{
            builder = [DXTKBuilder withContentView:[UIView new]];
        }) should] raise];
    });
    
    it(@"Should raise an exception for nil contentView", ^{
        [[theBlock(^{
            builder = [DXTKBuilder withContentView:nil];
        }) should] raise];
    });
});

describe(@"#build", ^{
    __block UITableView *tableViewMock;
    
    beforeEach(^{
        tableViewMock = [KWMock mockForClass:[UITableView class]];
        builder = [DXTKBuilder withContentView:tableViewMock];
    });
    
    context(@"All fields are set", ^{
        context(@"TableView data source building", ^{
            
            __block id<DXTKContentProvider> contentProvider;
            __block id<DXTKDataSourceDelegate> delegate;
            
            beforeEach(^{
                contentProvider = [DXTKBaseContentProvider new];
                delegate = [KWMock mockForProtocol:@protocol(DXTKDataSourceDelegate)];
                
                [builder setContentProvider:contentProvider];
                [builder setDelegate:delegate];
            });
            
            it(@"Should create data source for tableview", ^{
                DXTKTableViewDataSource *dataSource = (DXTKTableViewDataSource*)[builder build];
                
                [[dataSource should] beKindOfClass:[DXTKTableViewDataSource class]];
                
                [[dataSource.contentView should] beNonNil];
                [[dataSource.contentView should] equal:tableViewMock];
                
                [[(id)dataSource.contentProvider should] beNonNil];
                [[(id)dataSource.contentProvider should] equal:contentProvider];
                
                NSArray *plugins = [dataSource performSelector:@selector(plugins)];
                
                [[plugins should] haveCountOf:1];
                
                id plugin = plugins[0];
                
                [[[plugin performSelector:@selector(delegate)] should] equal:delegate];
            });
            
            it(@"Should register cells by class", ^{
                [[tableViewMock should] receive:@selector(registerClass:forCellReuseIdentifier:)
                                  withArguments:[UITableViewCell class], NSStringFromClass([DXTKBuilder class]), nil];
                
                [builder registerCellClass:[UITableViewCell class] forDomainObjectClass:[DXTKBuilder class]];
            });
            
            it(@"Should register cells from nib", ^{
                
                UINib *nib = [KWMock mockForClass:[UINib class]];
                
                
                [[tableViewMock should] receive:@selector(registerNib:forCellReuseIdentifier:)
                                  withArguments:nib, NSStringFromClass([DXTKBuilder class]), nil];
                
                [builder registerNib:nib forDomainObjectClass:[DXTKBuilder class]];
            });
        });
    });
    
    context(@"Not all fields are set", ^{
        context(@"TableView data source building", ^{
            beforeEach(^{
                [builder setContentProvider:nil];
            });
            
            it(@"Should create data source for tableview", ^{
                [[theBlock(^{
                    [builder build];
                }) should] raise];
            });
        });
    });
});

SPEC_END
