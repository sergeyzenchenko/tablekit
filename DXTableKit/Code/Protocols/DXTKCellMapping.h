//
//  HICellMapping.h
//  Grid
//
//  Created by zen on 2/19/13.
//  Copyright (c) 2013 111min. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DXTKCell.h"

@protocol DXTKCellMapping <NSObject>

- (NSDictionary*)mappings;

- (void)registerClass:(Class)cellClass forDomainObjectClass:(Class)domainClass;
- (void)registerNib:(UINib *)nib forDomainObjectClass:(Class)domainClass;

@end