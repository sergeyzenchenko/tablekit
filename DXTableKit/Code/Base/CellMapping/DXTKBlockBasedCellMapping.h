//
// Created by zen on 12/15/12.
//
// To change the template use AppCode | Preferences | File Templates.
//

#import <Foundation/Foundation.h>
#import "DXTKCellMapping.h"
#import <DXFoundation/DXSingleton.h>

@interface DXTKBlockBasedCellMapping : NSObject <DXTKCellMapping, DXSingleton>

+ (id <DXTKCellMapping>)mappingWithBlock:(void (^)(DXTKBlockBasedCellMapping *))mappingConfig;


@end