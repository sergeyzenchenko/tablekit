//
// Created by zen on 12/15/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "DXTKBlockBasedCellMapping.h"

@interface DXTKBlockBasedCellMapping ()

@property (nonatomic, strong) NSMutableDictionary *mappings;

@end

@implementation DXTKBlockBasedCellMapping

+ (id <DXTKCellMapping>)mappingWithBlock:(void (^)(DXTKBlockBasedCellMapping *))mappingConfig
{
    DXTKBlockBasedCellMapping *mapping = [DXTKBlockBasedCellMapping new];
    if (mappingConfig) {
        mappingConfig(mapping);
    }

    return mapping;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.mappings = [NSMutableDictionary new];
    }
    return self;
}

- (void)registerClass:(Class)cellClass forDomainObjectClass:(Class)domainClass
{
    [self.mappings setObject:cellClass forKey:NSStringFromClass(domainClass)];
}

- (void)registerNib:(UINib *)nib forDomainObjectClass:(Class)domainClass
{
    [self.mappings setObject:nib forKey:NSStringFromClass(domainClass)];
}

@end