//
//  DXTKHeaderFooterMapping.h
//  DXTableKit
//
//  Created by Vlad Korzun on 19.03.13.
//  Copyright (c) 2013 111min. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DXTKHeaderFooterMapping <NSObject>
- (void)setupMappingsTable:(UITableView *)table;
- (id<DXTKHeaderFooterFilling>)dequeueReusableHeaderFooterForTableView:(UITableView*)table forSection:(id)section type:(NSString *)type;
- (CGFloat)heightForHeaderFooterInSection:(id)sectionObject type:(NSString *)type;
@end
