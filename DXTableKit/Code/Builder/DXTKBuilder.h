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

@interface DXTKBuilder : NSObject

@property (nonatomic, strong) id<DXTKContentProvider> contentProvider;
@property (nonatomic, strong) id<DXTKCellMapping> cellMapping;

- (DXTKBaseDataSource*)build;

@end
