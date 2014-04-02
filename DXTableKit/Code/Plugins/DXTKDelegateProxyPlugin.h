//
// Created by Sergey Zenchenko on 4/2/14.
// Copyright (c) 2014 111min. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DXTKBaseDataSourcePlugin.h"


@interface DXTKDelegateProxyPlugin : DXTKBaseDataSourcePlugin

- (instancetype)initWithDelegate:(id<DXTKDataSourceDelegate>)delegate;

@end