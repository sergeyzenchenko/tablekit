//
//  DXTKTableViewCellBuilder.m
//  DXTableKit
//
//  Created by Sergey Zenchenko on 4/1/14.
//  Copyright (c) 2014 111min. All rights reserved.
//

#import "DXTKTableViewCellBuilder.h"

@interface DXTKTableViewCellBuilder ()

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation DXTKTableViewCellBuilder

- (instancetype)initWithContentView:(id)contentView;
{
    NSParameterAssert([contentView isKindOfClass:[UITableView class]]);
    
    self = [super init];
    if (self) {
        self.tableView = contentView;
    }
    return self;
}

- (void)setMapping:(id<DXTKCellMapping>)cellMapping
{
    NSParameterAssert(cellMapping);
    NSParameterAssert(self.tableView);
    
    NSDictionary *mappings = [cellMapping mappings];
    
    for (id key in mappings.allKeys) {
        id value = mappings[key];
        
        if ([value isKindOfClass:[UINib class]]) {
            [self.tableView registerNib:value forCellReuseIdentifier:key];
        } else {
            [self.tableView registerClass:value forCellReuseIdentifier:key];
        }
    }
}

- (id<DXTKBaseCell>)buildCellForIndexPath:(NSIndexPath*)indexPath
{
    return nil;
}

@end
