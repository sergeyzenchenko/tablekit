//
//  HITableViewDataSource.h
//  HomeImprovements
//
//  Created by zen on 2/21/13.
//  Copyright (c) 2013 111Minutes. All rights reserved.
//

#import "DXTKBaseDataSource.h"
#import "DXTKBlockBasedHeaderFooterMapping.h"

@interface DXTKTableViewDataSource : DXTKBaseDataSource <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic,strong) id<DXTKHeaderFooterMapping> headerFooterMapping;
@property BOOL shouldAutoDeselectCells;
@end
