//
//  DXTKBlockBaseHeaderFooterMapping.m
//  DXTableKit
//
//  Created by Vlad Korzun on 17.03.13.
//  Copyright (c) 2013 111min. All rights reserved.
//

#import "DXTKBlockBasedHeaderFooterMapping.h"
#import "DXTKHeaderFooterFilling.h"
#import "DXTKContentSection.h"
#import "DXTKBaseHeader.h"

#define DefaultHeader @"DefaultHeader"

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
    [self.mappings setObject:headerClass forKey:[NSString stringWithFormat:@"%@%d",NSStringFromClass(sectionClass),DXTKTableViewHeader]];
}

- (void)registerClassForFooter:(Class)footerClass forSectionClass:(Class)sectionClass
{
    [self.mappings setObject:footerClass forKey:[NSString stringWithFormat:@"%@%d",NSStringFromClass(sectionClass),DXTKTableViewFooter]];
}

-(void)setupMappingsTable:(UITableView*)table
{
    for(NSString * key in self.mappings.allKeys)
    {
        [table registerClass:self.mappings[key] forHeaderFooterViewReuseIdentifier:key];
    }
    [table registerClass:[DXTKBaseHeader class] forHeaderFooterViewReuseIdentifier:DefaultHeader];
}

- (id<DXTKHeaderFooterFilling>)dequeueReusableHeaderFooterForTableView:(UITableView*)table forSection:(id)sectionObject type:(NSInteger)type
{
    NSString* identifierString = [NSString stringWithFormat:@"%@%d",NSStringFromClass([sectionObject class]),type];
    
    id<DXTKHeaderFooterFilling> headerFooterView = nil;
    if(!self.mappings[identifierString]){
        if(type == DXTKTableViewHeader && [sectionObject isKindOfClass:[NSString class]]){
            identifierString = DefaultHeader;
        } else {
            return nil;
        }
    }
    headerFooterView = [table dequeueReusableHeaderFooterViewWithIdentifier:identifierString];
    return headerFooterView;
}

- (CGFloat)heightForHeaderFooterInSection:(id)sectionObject type:(NSInteger)type
{
    NSString* identifierString = [NSString stringWithFormat:@"%@%d",NSStringFromClass([sectionObject class]),type];
    if(!self.mappings[identifierString]){
        if(type == DXTKTableViewHeader && [sectionObject isKindOfClass:[NSString class]]){
           return [DXTKBaseHeader heightForHeaderFooter];
        }
    } else {
       return [(id<DXTKHeaderFooterFilling>)self.mappings[identifierString] heightForHeaderFooter];
    }
    return 0;
}

@end