//
// Created by zen on 3/10/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "DXTKBaseContentProvider.h"
#import "MenuItem.h"

@interface MenuDataProvider : DXTKBaseContentProvider

- (void)addMenuItemWithTitle:(NSString *)title block:(MenuCallBack)callback;

@end