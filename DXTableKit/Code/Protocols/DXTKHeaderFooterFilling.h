//
//  DXTKHeaderFooterFilling.h
//  DXTableKit
//
//  Created by Vlad Korzun on 17.03.13.
//  Copyright (c) 2013 111min. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DXTKHeaderFooterFilling <NSObject>
- (void) fillWithObject:(id)object;
+ (CGFloat)heightForHeaderFooter;
@end