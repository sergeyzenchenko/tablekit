//
//  DXTKCollectionViewCellBuilder.m
//  DXTableKit
//
//  Created by Sergey Zenchenko on 4/1/14.
//  Copyright (c) 2014 111min. All rights reserved.
//

#import "DXTKCollectionViewCellBuilder.h"

@interface DXTKCollectionViewCellBuilder ()

@end

@implementation DXTKCollectionViewCellBuilder

- (Class)contentViewClass
{
    return [UICollectionView class];
}

- (void)setupNib:(UINib*)nib forKey:(NSString*)key
{
    [self.contentView registerNib:nib forCellWithReuseIdentifier:key];
}

- (void)setupCellClass:(Class)class forKey:(NSString*)key
{
    [self.contentView registerClass:class forCellWithReuseIdentifier:key];
}

- (id<DXTKBaseCell>)buildCellForIndexPath:(NSIndexPath*)indexPath
{
    return nil;
}

@end
