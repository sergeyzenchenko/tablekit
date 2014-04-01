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

- (NSDictionary*)mappings;

- (id<DXTKBaseCell>)dequeueReusableCellFromCollectionViewOrTable:(id)view forDomainObject:(id)domainObject indexPath:(NSIndexPath*)indexPath;

- (void)registerClass:(Class)cellClass forDomainObjectClass:(Class)domainClass;
- (void)registerNib:(UINib *)nib forDomainObjectClass:(Class)domainClass;

@end