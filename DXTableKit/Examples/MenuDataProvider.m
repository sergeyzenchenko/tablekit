//
// Created by zen on 3/10/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "MenuDataProvider.h"


@interface MenuDataProvider ()

@property (nonatomic, strong) NSMutableArray *menuItems;

@end


@implementation MenuDataProvider {

}

- (void)prepareToUse
{
    self.menuItems = [NSMutableArray new];
}

- (void)reload 
{
   [self commitResult:self.menuItems];
}

- (void)addMenuItemWithTitle:(NSString *)title block:(MenuCallBack)callback
{
    MenuItem *item = [MenuItem new];
    item.title = title;
    item.callback = callback;
    
    [self.menuItems addObject:item];
}

@end