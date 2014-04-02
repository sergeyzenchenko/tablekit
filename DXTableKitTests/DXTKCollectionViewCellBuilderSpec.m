//
//  DXTKCollectionViewCellBuilderSpec.m
//  DXTableKit
//
//  Created by Sergey Zenchenko on 4/1/14.
//  Copyright 2014 111min. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "DXTKCollectionViewCellBuilder.h"
#import "DXTKDomaonObject.h"

SPEC_BEGIN(DXTKCollectionViewCellBuilderSpec)

__block DXTKCollectionViewCellBuilder *cellBuilder;
__block id<DXTKCellMapping> cellMapping;

describe(@"#initWithContentView:", ^{
    context(@"Valid params", ^{
        it(@"Should save collectionView view", ^{
            UICollectionView *collectionView = [KWMock mockForClass:[UICollectionView class]];
            DXTKCollectionViewCellBuilder *cellBuilder = [[DXTKCollectionViewCellBuilder alloc] initWithContentView:collectionView];
            
            [[[cellBuilder performSelector:@selector(contentView)] should] equal:collectionView];
        });
    });
    
    context(@"Invalid params", ^{
        it(@"Should raise an exception is nil table view received", ^{
            [[theBlock(^{
                [[DXTKCollectionViewCellBuilder alloc] initWithContentView:nil];
            }) should] raise];
        });
        
        it(@"Should raise an exception is non table view object received", ^{
            [[theBlock(^{
                [[DXTKCollectionViewCellBuilder alloc] initWithContentView:@""];
            }) should] raise];
        });
    });
});

describe(@"#setMapping", ^{
    __block UINib *cellNib = [KWMock mockForClass:[UINib class]];
    
    context(@"CollectionView is setuped", ^{
        __block UICollectionView *collectionViewMock;
        
        beforeEach(^{
            collectionViewMock = [KWMock mockForClass:[UICollectionView class]];
            cellBuilder = [[DXTKCollectionViewCellBuilder alloc] initWithContentView:collectionViewMock];
        });
        
        it(@"Should register cell classess from mapping", ^{
            [[collectionViewMock should] receive:@selector(registerClass:forCellWithReuseIdentifier:) withArguments:[UICollectionView class], @"NSString", nil];
            [cellBuilder setMapping:cellMapping];
        });
        
        it(@"Should register cell nibs from mapping", ^{
            [[collectionViewMock should] receive:@selector(registerNib:forCellWithReuseIdentifier:) withArguments:cellNib, @"NSString", nil];
            [cellBuilder setMapping:cellMapping];
        });
    });
    
    context(@"CollectionView is not setuped", ^{
        beforeEach(^{
            cellBuilder = [DXTKCollectionViewCellBuilder new];
        });
        
        it(@"Should throw an exception", ^{
            [[theBlock(^{
                [cellBuilder setMapping:cellMapping];
            }) should] raise];
        });
    });
});

describe(@"#buildCellForDomainObject:indexPath:", ^{
    __block UICollectionView *collectionViewMock;
    
    beforeEach(^{
        collectionViewMock = [KWMock mockForClass:[UICollectionView class]];
        cellBuilder = [[DXTKCollectionViewCellBuilder alloc] initWithContentView:collectionViewMock];
    });
    
    context(@"Registred cells requested", ^{
        it(@"Should deque cell", ^{
            [[collectionViewMock should] receive:@selector(dequeueReusableCellWithReuseIdentifier:forIndexPath:)
                                   withArguments:@"DXTKDomaonObject", [NSIndexPath indexPathForRow:0 inSection:0], nil];
            
            id cell = [cellBuilder buildCellForDomainObject:[DXTKDomaonObject new]
                                                  indexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        });
    });
    
});

SPEC_END
