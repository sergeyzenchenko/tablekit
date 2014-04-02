//
// Created by Sergey Zenchenko on 4/2/14.
// Copyright (c) 2014 111min. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DXTKDataSourcePlugin;

@protocol DXTKExtandableDataSource <NSObject>

- (void)attachPlugin:(id<DXTKDataSourcePlugin>)plugin;

@end