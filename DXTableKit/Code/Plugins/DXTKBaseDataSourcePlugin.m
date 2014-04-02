//
// Created by Sergey Zenchenko on 4/2/14.
// Copyright (c) 2014 111min. All rights reserved.
//

#import "DXTKDataSourceDelegate.h"
#import "DXTKBaseDataSourcePlugin.h"
#import "DXTKBaseDataSource.h"


@implementation DXTKBaseDataSourcePlugin

- (void)attachToDataSource:(DXTKBaseDataSource *)dataSource
{

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

- (void)didSelectDomainObject:(id)object atIndexPath:(NSIndexPath *)indexPath fromDataSource:(id <DXTKDataSource>)dataSource
{

}

@end