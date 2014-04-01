//
//  DXTKContentSection.h
//  DXTableKit
//
//  Created by Sergey Zenchenko on 4/1/14.
//  Copyright (c) 2014 111min. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DXTKContentSection <NSObject>

- (id)sectionObject;

- (NSUInteger)numberOfObjects;

- (id)objectAtIndex:(NSUInteger)index;

@end
