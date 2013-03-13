//
// Created by zen on 3/10/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "DXTKTableViewDataSource.h"

@interface DXTableView : UITableView

@property (nonatomic, strong) DXTKTableViewDataSource *customDataSource;

- (void)reload;

@end