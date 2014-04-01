//
//  DXTKBaseCellBuilder.h
//  DXTableKit
//
//  Created by Sergey Zenchenko on 4/1/14.
//  Copyright (c) 2014 111min. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DXTKCellBuilder.h"

@interface DXTKBaseCellBuilder : NSObject <DXTKCellBuilder>

@property (nonatomic, strong) id contentView;

- (Class)contentViewClass;

@end
