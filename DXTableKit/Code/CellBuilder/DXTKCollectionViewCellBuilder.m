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
    self = [super init];
    if (self) {
        self.collectionView = contentView;
        [self validate];
    }
    return self;
}

- (void)validate
{
    NSParameterAssert([self.collectionView isKindOfClass:[UICollectionView class]]);
}

- (void)setupNib:(UINib*)nib forKey:(NSString*)key
{
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:key];
}

- (void)setupCellClass:(Class)class forKey:(NSString*)key
{
    [self.collectionView registerClass:class forCellWithReuseIdentifier:key];
}

- (id<DXTKBaseCell>)buildCellForIndexPath:(NSIndexPath*)indexPath
{
    return nil;
}

@end
