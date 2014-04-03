//
//  DXTKBuilder.m
//  DXTableKit
//
//  Created by Sergey Zenchenko on 4/1/14.
//  Copyright (c) 2014 111min. All rights reserved.
//

#import "DXTKBuilder.h"
#import "DXTKTableViewDataSource.h"
#import "DXTKDataSourceDelegate.h"
#import "DXTKTableViewDataSourceBuilder.h"
#import "DXTKCollectionViewDataSourceBuilder.h"

@interface DXTKBuilder ()

@property(nonatomic, strong) id <DXTKContentProvider> contentProvider;
@property(nonatomic, strong) id contentView;
@property(nonatomic, weak) id <DXTKDataSourceDelegate> delegate;
@property(nonatomic, strong) Class customDataSourceClass;

@end

@implementation DXTKBuilder

+ (DXTKBuilder *)withContentView:(id)contentView
{
    NSParameterAssert(contentView);
    
    if ([contentView isKindOfClass:[UITableView class]]) {
        return [[DXTKTableViewDataSourceBuilder alloc] initWithContentView:contentView];
    }
    
    if ([contentView isKindOfClass:[UICollectionView class]]) {
        return [[DXTKCollectionViewDataSourceBuilder alloc] initWithContentView:contentView];
    }
    
    [NSException raise:NSInvalidArgumentException format:@"ContentView have to be UITableView or UICollectionView intance"];
    
    return nil;
}

- (instancetype)init
{
    if ([self class] == [DXTKBuilder class]) {
        [NSException raise:NSObjectInaccessibleException format:@"DXTKBuilder can't be directy instantiated"];
    }
    return [super init];
}

- (instancetype)initWithContentView:(id)contentView
{
    NSParameterAssert(contentView);
    
    self = [super init];
    
    if (self) {
        self.contentView = contentView;
    }

    return self;
}

- (Class)dataSourceClass
{
    return nil;
}

- (void)setCustomDataSourceClass:(Class)dataSourceClass
{
    NSParameterAssert([dataSourceClass isSubclassOfClass:[self dataSourceClass]]);
    
    _customDataSourceClass = dataSourceClass;
}

- (id<DXTKDataSource>)build
{
    NSParameterAssert(self.contentProvider);
    
    Class dataSourceClass = [self dataSourceClass];
    
    if (self.customDataSourceClass) {
        dataSourceClass = self.customDataSourceClass;
    }
    
    id<DXTKDataSource> ds = [[dataSourceClass alloc] initWithContentView:self.contentView
                                                                       contentProvider:self.contentProvider
                                                                              delegate:self.delegate];

    return ds;
}

- (void)registerCellClass:(Class)cellClass forDomainObjectClass:(Class)domainClass
{
    
}

- (void)registerNib:(UINib *)nib forDomainObjectClass:(Class)domainClass
{
    
}

@end
