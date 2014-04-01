//
//  DXTKTableViewCellBuilderSpec.m
//  DXTableKit
//
//  Created by Sergey Zenchenko on 4/1/14.
//  Copyright 2014 111min. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "DXTKTableViewCellBuilder.h"
#import "DXTKBlockBasedCellMapping.h"


SPEC_BEGIN(DXTKTableViewCellBuilderSpec)

describe(@"#initWithContentView:", ^{
    context(@"Valid params", ^{
        it(@"Should save table view", ^{
            UITableView *tableView = [[UITableView alloc] init];
            DXTKTableViewCellBuilder *cellBuilder = [[DXTKTableViewCellBuilder alloc] initWithContentView:tableView];
            
            [[[cellBuilder performSelector:@selector(tableView)] should] equal:tableView];
        });
    });
    
    context(@"Invalid params", ^{
        it(@"Should raise an exception is nil table view received", ^{
            [[theBlock(^{
                [[DXTKTableViewCellBuilder alloc] initWithContentView:nil];
            }) should] raise];
        });
        
        it(@"Should raise an exception is non table view object received", ^{
            [[theBlock(^{
                [[DXTKTableViewCellBuilder alloc] initWithContentView:@""];
            }) should] raise];
        });
    });
});

describe(@"#setMapping", ^{
    __block DXTKTableViewCellBuilder *cellBuilder;
    __block id<DXTKCellMapping> cellMapping;
    __block UINib *cellNib = [KWMock mockForClass:[UINib class]];
    
    context(@"Table is setuped", ^{
        __block UITableView *tableViewMock;
        
        beforeEach(^{
            tableViewMock = [KWMock mockForClass:[UITableView class]];
            cellBuilder = [[DXTKTableViewCellBuilder alloc] initWithContentView:tableViewMock];
        });
        
        it(@"Should register cell classess from mapping", ^{
            cellMapping = [DXTKBlockBasedCellMapping mappingWithBlock:^(DXTKBlockBasedCellMapping *mapping) {
                [mapping registerClass:[UITableViewCell class] forDomainObjectClass:[NSString class]];
            }];
            
            [[tableViewMock should] receive:@selector(registerClass:forCellReuseIdentifier:) withArguments:[UITableViewCell class], @"NSString", nil];
            [cellBuilder setMapping:cellMapping];
        });
        
        it(@"Should register cell nibs from mapping", ^{
            cellMapping = [DXTKBlockBasedCellMapping mappingWithBlock:^(DXTKBlockBasedCellMapping *mapping) {
                [mapping registerNib:cellNib forDomainObjectClass:[NSString class]];
            }];
            
            [[tableViewMock should] receive:@selector(registerNib:forCellReuseIdentifier:) withArguments:cellNib, @"NSString", nil];
            [cellBuilder setMapping:cellMapping];
        });
    });
    
    context(@"Table is not setuped", ^{
        beforeEach(^{
            cellBuilder = [DXTKTableViewCellBuilder new];
        });
        
        it(@"Should throw an exception", ^{
            [[theBlock(^{
                [cellBuilder setMapping:cellMapping];
            }) should] raise];
        });
    });
});

SPEC_END
