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
#import "DXTKHeaderFooterMapping.h"

enum
{
    DXTKTableViewHeader = 0,
    DXTKTableViewFooter = 1
};

@interface DXTKBlockBasedHeaderFooterMapping : NSObject<DXSingleton,DXTKHeaderFooterMapping>
+ (id)mappingWithBlock:(void (^)(id<DXTKHeaderFooterMapping>))mappingConfig;
- (void)registerClassForHeader:(Class)headerClass forSectionClass:(Class)sectionClass;
- (void)registerClassForFooter:(Class)footerClass forSectionClass:(Class)sectionClass;
@end
