//
// Created by Sergey Zenchenko on 4/2/14.
// Copyright (c) 2014 111min. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DXTKDataSource;

@protocol DXTKDataSourceDelegate <NSObject>

- (void)didSelectDomainObject:(id)object
                  atIndexPath:(NSIndexPath *)indexPath
               fromDataSource:(id <DXTKDataSource>)dataSource;

@end