//
//  HICellMapping.h
//  Grid
//
//  Created by zen on 2/19/13.
//  Copyright (c) 2013 111min. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DXTKBaseCell.h"

@protocol DXTKCellMapping <NSObject>

- (void)setupMappingsForCollectionViewOrTable:(id)view;

- (id<DXTKBaseCell>)dequeueReusableCellFromCollectionViewOrTable:(id)view forDomainObject:(id)domainObject indexPath:(NSIndexPath*)indexPath;

@end