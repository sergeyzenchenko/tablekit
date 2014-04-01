//
//  DXTKCollectionViewCellBuilder.m
//  DXTableKit
//
//  Created by Sergey Zenchenko on 4/1/14.
//  Copyright (c) 2014 111min. All rights reserved.
//

#import "DXTKCollectionViewCellBuilder.h"

@interface DXTKCollectionViewCellBuilder ()

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation DXTKCollectionViewCellBuilder

- (instancetype)initWithContentView:(id)contentView;
{
    NSParameterAssert([contentView isKindOfClass:[UICollectionView class]]);
    
    self = [super init];
    if (self) {
        self.collectionView = contentView;
    }
    return self;
}

- (void)setMapping:(id<DXTKCellMapping>)cellMapping
{
    NSParameterAssert(cellMapping);
    NSParameterAssert(self.collectionView);
    
    NSDictionary *mappings = [cellMapping mappings];
    
    for (id key in mappings.allKeys) {
        id value = mappings[key];
        
        if ([value isKindOfClass:[UINib class]]) {
            [self.collectionView registerNib:value forCellWithReuseIdentifier:key];
        } else {
            [self.collectionView registerClass:value forCellWithReuseIdentifier:key];
        }
    }
}

- (id<DXTKBaseCell>)buildCellForIndexPath:(NSIndexPath*)indexPath
{
    return nil;
}

@end
