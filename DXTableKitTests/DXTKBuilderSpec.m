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
    __block UITableView *tableView;
    
    beforeEach(^{
        tableView = [UITableView new];
        builder = [DXTKBuilder withContentView:tableView];
    });
    
    context(@"All fields are set", ^{
        context(@"TableView data source building", ^{
            
            __block id<DXTKContentProvider> contentProvider;
            
            beforeEach(^{
                contentProvider = [DXTKBaseContentProvider new];
                [builder setContentProvider:contentProvider];
            });
            
            it(@"Should create data source for tableview", ^{
                DXTKTableViewDataSource *dataSource = (DXTKTableViewDataSource*)[builder build];
                
                [[dataSource should] beKindOfClass:[DXTKTableViewDataSource class]];
                
                [[dataSource.contentView should] beNonNil];
                [[dataSource.contentView should] equal:tableView];
                
                [[(id)dataSource.contentProvider should] beNonNil];
                [[(id)dataSource.contentProvider should] equal:contentProvider];
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
