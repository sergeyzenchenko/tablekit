//
// Created by zen on 3/10/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "DXTKContentSection.h"


@interface DXTKContentSection ()

@property(nonatomic, strong) NSArray *items;
@property(nonatomic, strong) id sectionObject;

@end

@implementation DXTKContentSection

+ (instancetype)sectionWithItems:(NSArray *)items sectionObject:(id)sectionObject
{
    return [[self alloc] initWithItems:items sectionObject:sectionObject];
}

- (instancetype)initWithItems:(NSArray *)items sectionObject:(id)sectionObject
{
    self = [super init];
    if (self) {
        self.items = items;
        self.sectionObject = sectionObject;
    }

    return self;
}


- (NSUInteger)numberOfObjects
{
    return self.items.count;
}

- (id)objectAtIndex:(NSUInteger)index
{
    return self.items[index];
}

@end