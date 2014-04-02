//
// Created by Sergey Zenchenko on 4/2/14.
// Copyright (c) 2014 111min. All rights reserved.
//

#import "DXTKDataSourceDelegate.h"
#import "DXTKDelegateProxyPlugin.h"

@interface DXTKDelegateProxyPlugin ()

@property (nonatomic, weak) id<DXTKDataSourceDelegate> delegate;

@end

@implementation DXTKDelegateProxyPlugin

- (instancetype)initWithDelegate:(id <DXTKDataSourceDelegate>)delegate
{
    self = [super init];
    if (self) {
        self.delegate = delegate;
    }

    return self;
}

- (void)didSelectDomainObject:(id)object atIndexPath:(NSIndexPath *)indexPath fromDataSource:(id <DXTKDataSource>)dataSource
{
    [self.delegate didSelectDomainObject:object atIndexPath:indexPath fromDataSource:dataSource];
}

@end