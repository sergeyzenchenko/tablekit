//
// Created by zen on 3/10/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "DXTableView.h"


@implementation DXTableView {

}

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.customDataSource = [DXTKTableViewDataSource new];
        self.customDataSource.contentView = self;
    }
    return self;
}

- (void)reload
{
    [self.customDataSource reload];
}

@end