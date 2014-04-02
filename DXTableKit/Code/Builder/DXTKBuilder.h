//
//  DXTKBuilder.h
//  DXTableKit
//
//  Created by Sergey Zenchenko on 4/1/14.
//  Copyright (c) 2014 111min. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DXTKContentProvider.h"
#import "DXTKCellMapping.h"
#import "DXTKBaseDataSource.h"

@protocol DXTKDataSourceDelegate;

@interface DXTKBuilder : NSObject

+ (DXTKBuilder*)withContentView:(id)contentView;

- (id<DXTKDataSource>)build;

- (void)setContentProvider:(id<DXTKContentProvider>)contentProvider;
- (void)setDelegate:(id<DXTKDataSourceDelegate>)delegate;

- (void)registerCellClass:(Class)cellClass forDomainObjectClass:(Class)domainClass;
- (void)registerNib:(UINib*)nib forDomainObjectClass:(Class)domainClass;

@end
