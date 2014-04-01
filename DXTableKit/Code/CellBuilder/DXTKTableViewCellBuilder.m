//
//  DXTKTableViewCellBuilder.m
//  DXTableKit
//
//  Created by Sergey Zenchenko on 4/1/14.
//  Copyright (c) 2014 111min. All rights reserved.
//

#import "DXTKTableViewCellBuilder.h"

@interface DXTKTableViewCellBuilder ()

@property (nonatomic, strong) UITableView *contentView;

@end

@implementation DXTKTableViewCellBuilder

- (Class)contentViewClass
{
    return [UITableView class];
}

- (void)setupNib:(UINib*)nib forKey:(NSString*)key
{
    [self.contentView registerNib:nib forCellReuseIdentifier:key];
}

- (void)setupCellClass:(Class)class forKey:(NSString*)key
{
    [self.contentView registerClass:class forCellReuseIdentifier:key];
}

- (id<DXTKBaseCell>)buildCellForIndexPath:(NSIndexPath*)indexPath
{
    return nil;
}

@end
