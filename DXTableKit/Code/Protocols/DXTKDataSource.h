//
//  DXTKDataSource.h
//  DXTableKit
//
//  Created by Sergey Zenchenko on 4/1/14.
//  Copyright (c) 2014 111min. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DXTKDataSourcePlugin.h"

@protocol DXTKDataSource <NSObject>

- (void)reload;

- (void)attachPlugin:(id<DXTKDataSourcePlugin>)plugin;

@end
