//
//  DXTKTableViewDataSourceSpec.m
//  DXTableKit
//
//  Created by Sergey Zenchenko on 4/2/14.
//  Copyright 2014 111min. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "DXTKTableViewDataSource.h"
#import "DXTKBuilder.h"

SPEC_BEGIN(DXTKTableViewDataSourceSpec)

__block DXTKTableViewDataSource *dataSource;
__block NSObject<DXTKContentProvider> *contentProvider;
__block UITableView *tableViewMock;

beforeEach(^{
    
    contentProvider = [KWMock nullMockForProtocol:@protocol(DXTKContentProvider)];
    tableViewMock = [KWMock nullMockForClass:[UITableView class]];
    
    DXTKBuilder *builder = [DXTKBuilder withContentView:tableViewMock];
    [builder setContentProvider:contentProvider];
    
    dataSource = [builder build];
});

describe(@"#numberOfSectionsInTableView", ^{
    beforeEach(^{
        [contentProvider stub:@selector(numberOfSections) andReturn:theValue(2)];
    });
    
    it(@"Should return number of sections", ^{
        [[theValue([dataSource numberOfSectionsInTableView:tableViewMock]) should] equal:theValue(2)];
    });
});

describe(@"#tableView:numberOfRowsInSection:", ^{
    beforeEach(^{
        [contentProvider stub:@selector(numberOfItemsInSection:)
                    andReturn:theValue(5)
                withArguments:theValue(3), nil];
    });
    
    it(@"Should return number of rows in section", ^{
        [[theValue([dataSource tableView:tableViewMock numberOfRowsInSection:3]) should] equal:theValue(5)];
    });
});

describe(@"#tableView:cellForRowAtIndexPath:", ^{

    it(@"Should call build cell method", ^{
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:3 inSection:2];
        
        [[dataSource should] receive:@selector(buildCellForIndexPath:) withArguments:indexPath, nil];
        
        [dataSource tableView:tableViewMock cellForRowAtIndexPath:indexPath];
    });
});

describe(@"#buildCellForDomainObject:indexPath:", ^{
    
    it(@"Should return number of rows in section", ^{
        NSString *domainObject = @"qwd";
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:3 inSection:2];
        
        [[tableViewMock should] receive:@selector(dequeueReusableCellWithIdentifier:forIndexPath:)
                          withArguments:NSStringFromClass([domainObject class]), indexPath, nil];
        
        [dataSource buildCellForDomainObject:domainObject
                                   indexPath:indexPath];
    });
});

describe(@"#tableView:didSelectRowAtIndexPath:", ^{
    
    it(@"Should call build cell method", ^{
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:3 inSection:2];
        
        [[dataSource should] receive:@selector(selectCellAtIndexPath:) withArguments:indexPath, nil];
        
        [dataSource tableView:tableViewMock didSelectRowAtIndexPath:indexPath];
    });
});

SPEC_END
