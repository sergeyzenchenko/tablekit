//
// Created by zen on 3/10/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "MenuCell.h"
#import "MenuItem.h"

@implementation MenuCell

- (void)fillWithObject:(MenuItem*)object
{
    self.textLabel.text = object.title;
    self.textLabel.textColor = [UIColor grayColor];
}

@end