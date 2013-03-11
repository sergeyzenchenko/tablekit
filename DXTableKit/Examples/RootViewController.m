//
// Created by zen on 3/10/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "RootViewController.h"
#import "MenuDataProvider.h"
#import "DXTKTableViewDataSource.h"
#import "MenuCell.h"
#import "DXTableView.h"


@interface RootViewController ()

@property (nonatomic, strong) DXTableView *tableView;

@end

@implementation RootViewController {

}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView = [[DXTableView alloc] initWithFrame:self.view.bounds];

    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;

    [self.view addSubview:self.tableView];

    MenuDataProvider *provider = [MenuDataProvider new];

    [provider addMenuItemWithTitle:@"Simple List" block:^{

    }];

    [provider addMenuItemWithTitle:@"Sectioned List" block:^{

    }];

    [provider addMenuItemWithTitle:@"Remove api list" block:^{

    }];

    [provider addMenuItemWithTitle:@"Core Data List" block:^{

    }];

    [provider addMenuItemWithTitle:@"Form" block:^{

    }];

    self.tableView.customDataSource.dataProvider = provider;

    self.tableView.customDataSource.cellsMapping = [DXTKBlockBasedCellMapping mappingWithBlock:^(DXTKBlockBasedCellMapping *mapping) {
       [mapping registerClass:[MenuCell class] forDomainObjectClass:[MenuItem class]];
    }];
}

@end