//
// Created by zen on 3/10/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "MenuDataProvider.h"
#import "DXTKContentSection.h"


@interface MenuDataProvider ()

@property(nonatomic, strong) NSMutableArray *sections;
@property(nonatomic, strong) DXTKContentSection *currentSection;
@property(nonatomic, strong) NSMutableArray *currentItems;

@end


@implementation MenuDataProvider

- (void)prepareToUse
{
    self.sections = [NSMutableArray new];
    self.currentItems = [NSMutableArray new];
}

- (void)reload
{
    if (self.currentSection) {
        self.currentSection.items = [self.currentItems copy];
        [self.currentItems removeAllObjects];
        self.currentSection = nil;
    }

    [self commitResult:self.sections];
}

- (void)addSectionWithTitle:(NSString *)sectionTitle
{
    if (self.currentSection) {
        self.currentSection.items = [self.currentItems copy];
        [self.currentItems removeAllObjects];
    }

    self.currentSection = [DXTKContentSection new];
    self.currentSection.sectionObject = sectionTitle;

    [self.sections addObject:self.currentSection];
}

- (void)addMenuItemWithTitle:(NSString *)title block:(MenuCallBack)callback
{
    MenuItem *item = [MenuItem new];
    item.title = title;
    item.callback = callback;

    [self.currentItems addObject:item];
}

- (NSArray*)arrayOfIndexes
{
    return [NSArray arrayWithObjects:@"A",@"Z", nil];
}

@end