//
// Created by zen on 12/15/12.
//
// To change the template use AppCode | Preferences | File Templates.
//

#import <Foundation/Foundation.h>
#import "DXTKCellMapping.h"

@interface DXTKBlockBasedCellMapping : NSObject <DXTKCellMapping>

+ (id <DXTKCellMapping>)mappingWithBlock:(void (^)(DXTKBlockBasedCellMapping *))mappingConfig;

@end