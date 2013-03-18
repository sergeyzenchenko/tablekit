//
//  HITableViewDataSource.h
//  HomeImprovements
//
//  Created by zen on 2/21/13.
//  Copyright (c) 2013 111Minutes. All rights reserved.
//

#import "DXTKBaseDataSource.h"
#import "DXTKBlockBasedHeaderFooterMapping.h"
#import "DXTKHeaderFooterFilling.h"

@interface DXTKTableViewDataSource : DXTKBaseDataSource
@property (nonatomic,strong) id<DXTKHeaderFooterMapping> headerFooterMapping;
@end
