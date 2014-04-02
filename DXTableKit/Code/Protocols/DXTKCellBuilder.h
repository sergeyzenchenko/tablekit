//
//  DXTKCellBuilder.h
//  DXTableKit
//
//  Created by Sergey Zenchenko on 4/1/14.
//  Copyright (c) 2014 111min. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DXTKCell.h"
#import "DXTKCellMapping.h"

@protocol DXTKCellBuilder <NSObject>

- (instancetype)initWithContentView:(id)contentView;

- (void)setMapping:(id<DXTKCellMapping>)cellMapping;

- (id<DXTKCell>)buildCellForDomainObject:(id)domainObject indexPath:(NSIndexPath*)indexPath;

- (void)validate;

@end
