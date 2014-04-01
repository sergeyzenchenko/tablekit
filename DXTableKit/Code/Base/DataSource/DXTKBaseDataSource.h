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
#import "DXTKBlockBasedCellMapping.h"
#import "DXTKDataSource.h"

@class DXTKBaseDataSource;

@protocol DXTKBaseDataSourceDelegate <NSObject>

- (void)didSelectDomainObject:(id)object fromDataSource:(DXTKBaseDataSource*)dataSource;

@end

@interface DXTKBaseDataSource : NSObject <DXTKContentProviderDelegate, DXTKDataSource>

@property (nonatomic, strong) id<DXTKContentProvider> dataProvider;
@property (nonatomic, strong) id<DXTKCellMapping> cellsMapping;
@property (nonatomic, weak) UIView *contentView;
@property (nonatomic, weak) id<DXTKBaseDataSourceDelegate> delegate;

- (void)setup;

- (id<DXTKBaseCell>)buildCellForIndexPath:(NSIndexPath*)indexPath;

- (void)reloadContentView;

- (void)selectCellAtIndexPath:(NSIndexPath*)indexPath;

@end
