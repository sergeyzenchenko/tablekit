//
//  DXTKBlockBaseHeaderFooterMapping.m
//  DXTableKit
//
//  Created by Vlad Korzun on 17.03.13.
//  Copyright (c) 2013 111min. All rights reserved.
//

#import "DXTKBlockBasedHeaderFooterMapping.h"
#import "DXTKHeaderFooterFilling.h"


@interface DXTKBlockBasedHeaderFooterMapping()
@property (nonatomic,strong)NSMutableDictionary * mappings;
@end

@implementation DXTKBlockBasedHeaderFooterMapping

- (id)init
{
    if(self = [super init]){
        self.mappings = [NSMutableDictionary new];
    }
    return self;
}

+ (id)mappingWithBlock:(void (^)(id <DXTKHeaderFooterMapping>))mappingConfig
{
    DXTKBlockBasedHeaderFooterMapping *mapping = [DXTKBlockBasedHeaderFooterMapping new];
    if (mappingConfig) {
        mappingConfig(mapping);
    }
    return mapping;
}

- (void)registerClassForHeader:(Class)headerClass forSectionClass:(Class)sectionClass
{
    [self.mappings setObject:headerClass forKey:[NSString stringWithFormat:@"%@Header",NSStringFromClass(sectionClass)]];
}

- (void)registerClassForFooter:(Class)footerClass forSectionClass:(Class)sectionClass
{
    [self.mappings setObject:footerClass forKey:[NSString stringWithFormat:@"%@Footer",NSStringFromClass(sectionClass)]];
}

- (id<DXTKHeaderFooterFilling>)dequeueReusableHeaderFooterForTableView:(UITableView*)table forSection:(id)section type:(NSString *)type
{
    NSString* identifierString = [NSString stringWithFormat:@"%@%@",NSStringFromClass([section class]),type];
    
    id<DXTKHeaderFooterFilling> headerFooterView = nil;
    if(!self.mappings[identifierString]){
        return nil;
    }
    headerFooterView = [table dequeueReusableHeaderFooterViewWithIdentifier:identifierString];
    headerFooterView = [self createHeaderFooterIdentifier:identifierString];
    return headerFooterView;
}

- (CGFloat)heightForHeaderFooterInSection:(id)section type:(NSString *)type
{
    NSString* identifierString = [NSString stringWithFormat:@"%@%@",NSStringFromClass([section class]),type];
    if(!self.mappings[identifierString]){
        return 0;
    } else {
       return [(id<DXTKHeaderFooterFilling>)self.mappings[identifierString] heightForHeaderFooter];
    }
}

- (id<DXTKHeaderFooterFilling>)createHeaderFooterIdentifier:(NSString *)identifierString
{
    Class headerFooterClass = self.mappings[identifierString];
    return [headerFooterClass new];
}

@end
