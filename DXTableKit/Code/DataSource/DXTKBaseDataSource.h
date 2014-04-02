//
//  HIBaseDataSource.h
//  Grid
//
//  Created by zen on 2/20/13.
//  Copyright (c) 2013 111min. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DXTKCellMapping.h"
#import "DXTKContentProvider.h"
#import "DXTKDataSource.h"
#import "DXTKExtandableDataSource.h"

@class DXTKBaseDataSource;
@protocol DXTKDataSourceDelegate;

@interface DXTKBaseDataSource : NSObject <DXTKDataSource, DXTKExtandableDataSource>

@property (nonatomic, readonly) id<DXTKContentProvider> contentProvider;

- (id)initWithContentView:(id)contentView
          contentProvider:(id <DXTKContentProvider>)contentProvider
                 delegate:(id <DXTKDataSourceDelegate>)delegate;

- (void)reloadContentView;

- (id<DXTKCell>)buildCellForIndexPath:(NSIndexPath*)indexPath;
- (void)selectCellAtIndexPath:(NSIndexPath*)indexPath;

- (id<DXTKCell>)buildCellForDomainObject:(id)domainObject indexPath:(NSIndexPath*)indexPath;

@end
