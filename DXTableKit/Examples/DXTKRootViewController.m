//
//  DXTKRootViewController.m
//  DXTableKit
//
//  Created by Sergey Zenchenko on 4/3/14.
//  Copyright (c) 2014 111min. All rights reserved.
//

#import "DXTKRootViewController.h"
#import "DXTKBuilder.h"
#import "DXTKExampelContentProvider.h"
#import "DXTKExampleTableViewCell.h"


@interface DXTKRootViewController ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) id<DXTKDataSource> dataSource;

@end

@implementation DXTKRootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    [self.view addSubview:self.tableView];
    
    DXTKBuilder *builder = [DXTKBuilder withContentView:self.tableView];
    
    [builder setContentProvider:[DXTKExampelContentProvider new]];
    [builder registerCellClass:[DXTKExampleTableViewCell class] forDomainObjectClass:[@(1) class]];
    
    self.dataSource = [builder build];
    
    [self.dataSource reload];
}

@end
