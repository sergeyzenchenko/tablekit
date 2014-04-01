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
    self = [super init];
    if (self) {
        self.tableView = contentView;
        [self validate];
    }
    return self;
}

- (void)validate
{
    NSParameterAssert([self.tableView isKindOfClass:[UITableView class]]);
}

- (void)setupNib:(UINib*)nib forKey:(NSString*)key
{
    [self.tableView registerNib:nib forCellReuseIdentifier:key];
}

- (void)setupCellClass:(Class)class forKey:(NSString*)key
{
    [self.tableView registerClass:class forCellReuseIdentifier:key];
}

- (id<DXTKBaseCell>)buildCellForIndexPath:(NSIndexPath*)indexPath
{
    return nil;
}

@end
