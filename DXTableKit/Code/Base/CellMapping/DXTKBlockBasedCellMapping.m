//
// Created by zen on 12/15/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "DXTKBlockBasedCellMapping.h"
#define SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
@interface DXTKBlockBasedCellMapping ()

@property (nonatomic, strong) NSMutableDictionary *mappings;

@end

@implementation DXTKBlockBasedCellMapping
{

}

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


- (void)setupMappingsForCollectionViewOrTable:(id)view;
{
    NSParameterAssert(view);

    if (self != [DXTKBlockBasedCellMapping shared]) {
        [self.mappings addEntriesFromDictionary:[DXTKBlockBasedCellMapping shared].mappings];
    }
    
    for (NSString * className in self.mappings.allKeys) {
        id mappingObject = self.mappings[className];
        if ([mappingObject isKindOfClass:[UINib class]] && [view respondsToSelector:@selector(registerNib:forCellReuseIdentifier:)]) {
            [view registerNib:mappingObject forCellReuseIdentifier:className];
        } else if ([view respondsToSelector:@selector(registerClass:forCellReuseIdentifier:)]) {
                [view registerClass:mappingObject forCellReuseIdentifier:className];
        } else if ([mappingObject isKindOfClass:[UINib class]] && [view respondsToSelector:@selector(registerNib:forCellWithReuseIdentifier:)]) {
            [view registerNib:mappingObject forCellWithReuseIdentifier:className];
            
        } else if ([view respondsToSelector:@selector(registerClass:forCellWithReuseIdentifier:)]) {

            [view registerClass:mappingObject forCellWithReuseIdentifier:className];
        }
    }
}

- (id<DXTKBaseCell>)dequeueReusableCellFromCollectionViewOrTable:(id)view forDomainObject:(id)domainObject indexPath:(NSIndexPath*)indexPath
{
    assert(self.mappings[NSStringFromClass([domainObject class])]);
    
    id<DXTKBaseCell> cell = nil;
    
    if ([view respondsToSelector:@selector(dequeueReusableCellWithIdentifier:)]) {
        cell = [view dequeueReusableCellWithIdentifier:NSStringFromClass([domainObject class])];
    } else if([view respondsToSelector:@selector(dequeueReusableCellWithReuseIdentifier:forIndexPath:)]) {
        cell = [view dequeueReusableCellWithReuseIdentifier:NSStringFromClass([domainObject class]) forIndexPath:indexPath];
    }
    
    if (!cell) {
        cell = [self createCellForDomainObject:domainObject];
    }

    assert(cell);

    return cell;
}

- (void)registerClass:(Class)cellClass forDomainObjectClass:(Class)domainClass
{
    [self.mappings setObject:cellClass forKey:NSStringFromClass(domainClass)];
}

- (void)registerNib:(UINib *)nib forDomainObjectClass:(Class)domainClass
{
    [self.mappings setObject:nib forKey:NSStringFromClass(domainClass)];
}

- (id<DXTKBaseCell>)createCellForDomainObject:(id)domainObject
{
    Class cellClass = self.mappings[NSStringFromClass([domainObject class])];
    
    id<DXTKBaseCell> cell = nil;
    
    if (cellClass) {
        if ([cellClass isSubclassOfClass:[UITableViewCell class]]) {
            cell = [[cellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([domainObject class])];
        } else {
            cell = [cellClass new];
        }
    }
    
    return cell;
}

@end