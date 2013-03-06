//
//  HIDataSourcePlugin.h
//  HomeImprovements
//
//  Created by zen on 2/22/13.
//  Copyright (c) 2013 111Minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DXTKDataProvider.h"

@class DXTKBaseDataSource;

@protocol DXTKDataSourcePlugin <NSObject, DXTKDataProviderDelegate>

- (void)attachToDataSource:(DXTKBaseDataSource*)dataSource;

- (void)reload;


@end
