//
//  DXTKBlockBasedHeaderFooterMapping.h
//  DXTableKit
//
//  Created by Vlad Korzun on 17.03.13.
//  Copyright (c) 2013 111min. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <DXFoundation/DXSingleton.h>
#import "DXTKHeaderFooterFilling.h"
@protocol DXTKHeaderFooterMapping  <NSObject>
+ (id)mappingWithBlock:(void (^)(id<DXTKHeaderFooterMapping>))mappingConfig;
- (void)registerClassForHeader:(Class)headerClass forSectionClass:(Class)sectionClass;
- (void)registerClassForFooter:(Class)footerClass forSectionClass:(Class)sectionClass;
- (id<DXTKHeaderFooterFilling>)dequeueReusableHeaderFooterForTableView:(UITableView*)table forSection:(id)section type:(NSString *)type;
- (CGFloat)heightForHeaderFooterInSection:(id)section type:(NSString *)type;
@end

@interface DXTKBlockBasedHeaderFooterMapping : NSObject<DXSingleton,DXTKHeaderFooterMapping>

@end
