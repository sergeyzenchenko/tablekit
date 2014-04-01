//
//  DXTKBaseCellBuilder.m
//  DXTableKit
//
//  Created by Sergey Zenchenko on 4/1/14.
//  Copyright (c) 2014 111min. All rights reserved.
//

#import "DXTKBaseCellBuilder.h"

@implementation DXTKBaseCellBuilder

- (instancetype)initWithContentView:(id)contentView;
{
    self = [super init];
    if (self) {
        self.contentView = contentView;
        [self validate];
    }
    return self;
}

- (Class)contentViewClass
{
    return nil;
}

- (void)setMapping:(id<DXTKCellMapping>)cellMapping
{
    NSParameterAssert(cellMapping);
    
    [self validate];
    
    NSDictionary *mappings = [cellMapping mappings];
    
    for (id key in mappings.allKeys) {
        id value = mappings[key];
        
        if ([value isKindOfClass:[UINib class]]) {
            [self setupNib:value forKey:key];
        } else {
            [self setupCellClass:value forKey:key];
        }
    }
}

- (void)setupNib:(UINib*)nib forKey:(NSString*)key
{
    @throw @"not implemented";
}

- (void)setupCellClass:(Class)class forKey:(NSString*)key
{
    @throw @"not implemented";
}

- (id<DXTKBaseCell>)buildCellForDomainObject:(id)domainObject indexPath:(NSIndexPath*)indexPath
{
    @throw @"not implemented";
}

- (void)validate
{
    NSParameterAssert([self.contentView isKindOfClass:self.contentViewClass]);
}

@end
