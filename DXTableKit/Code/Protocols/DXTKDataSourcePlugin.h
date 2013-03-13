//
//  HIDataSourcePlugin.h
//  HomeImprovements
//
//  Created by zen on 2/22/13.
//  Copyright (c) 2013 111Minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DXTKContentProvider.h"

@class DXTKBaseDataSource;

@protocol DXTKDataSourcePlugin <NSObject, DXTKContentProviderDelegate>

- (void)attachToDataSource:(DXTKBaseDataSource*)dataSource;

- (void)reload;


@end
