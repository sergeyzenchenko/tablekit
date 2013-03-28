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
#import "Header.h"
#import "DXTKContentSection.h"
#import "Footer.h"
#import "IOS5Header.h"
#import "IOS5Footer.h"
#define SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
@interface RootViewController ()

@property (nonatomic, strong) DXTableView *tableView;

@end

@implementation RootViewController {

}

- (void)viewDidLoad {
    [super viewDidLoad];


    self.tableView = [[DXTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];

    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;

    [self.view addSubview:self.tableView];

    MenuDataProvider *provider = [MenuDataProvider new];

    [provider addSectionWithTitle:@"Static"];

    [provider addMenuItemWithTitle:@"Simple List" block:^{

    }];

    [provider addMenuItemWithTitle:@"Sectioned List" block:^{

    }];

    [provider addSectionWithTitle:@"Dynamic"];

    [provider addMenuItemWithTitle:@"Remove api list" block:^{

    }];

    [provider addMenuItemWithTitle:@"Core Data List" block:^{

    }];

    [provider addSectionWithTitle:@"Forms"];

    [provider addMenuItemWithTitle:@"Form" block:^{

    }];
    NSLog(@"%@",[Header class]);
    
    self.tableView.customDataSource.headerFooterMapping = [DXTKBlockBasedHeaderFooterMapping mappingWithBlock:^(DXTKBlockBasedHeaderFooterMapping* mapping) {
        if(SYSTEM_VERSION_LESS_THAN(@"6.0")){
            [mapping registerClassForHeader:[IOS5Header class] forSectionClass:[@"static string" class]];
            [mapping registerClassForFooter:[IOS5Footer class] forSectionClass:[@"static string" class]];
        } else {
            [mapping registerClassForHeader:[Header class] forSectionClass:[@"static string" class]];
            [mapping registerClassForFooter:[Footer class] forSectionClass:[@"static string" class]];
        }
    }];
    self.tableView.customDataSource.dataProvider = provider;
       self.tableView.customDataSource.cellsMapping = [DXTKBlockBasedCellMapping mappingWithBlock:^(DXTKBlockBasedCellMapping *mapping) {
       [mapping registerClass:[MenuCell class] forDomainObjectClass:[MenuItem class]];
        
    }];

}

@end