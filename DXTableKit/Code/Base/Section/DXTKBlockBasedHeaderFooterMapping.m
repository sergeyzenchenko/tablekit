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
#define SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

@interface DXTKBlockBasedHeaderFooterMapping()
@property (nonatomic,strong)NSMutableDictionary * mappings;
@end

@implementation DXTKBlockBasedHeaderFooterMapping

const struct DXTableViewHeaderFooterConstants DXTableViewHeaderFooterConstants = {
    .DXTKTableViewHeader = @"Header",
    .DXTKTableViewFooter = @"Footer",
    .DXTKTableViewDefineHeader = @"DefineHeader",

};

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
    [self.mappings setObject:headerClass forKey:[NSString stringWithFormat:@"%@%@",NSStringFromClass(sectionClass),DXTableViewHeaderFooterConstants.DXTKTableViewHeader]];
}

- (void)registerClassForFooter:(Class)footerClass forSectionClass:(Class)sectionClass
{
    [self.mappings setObject:footerClass forKey:[NSString stringWithFormat:@"%@%@",NSStringFromClass(sectionClass),DXTableViewHeaderFooterConstants.DXTKTableViewFooter]];
}

-(void)setupMappingsTable:(UITableView*)table
{
    if(!SYSTEM_VERSION_LESS_THAN(@"6.0")){
        for(NSString * key in self.mappings.allKeys)
        {
            [table registerClass:self.mappings[key] forHeaderFooterViewReuseIdentifier:key];
        }
    
        [table registerClass:[DXTKBaseHeader class] forHeaderFooterViewReuseIdentifier:DXTableViewHeaderFooterConstants.DXTKTableViewDefineHeader];
    }
}

- (id<DXTKHeaderFooterFilling>)dequeueReusableHeaderFooterForTableView:(UITableView*)table forSection:(id)sectionObject type:(NSString *)type
{
    NSString* identifierString = [NSString stringWithFormat:@"%@%@",NSStringFromClass([sectionObject class]),type];
    
    id<DXTKHeaderFooterFilling> headerFooterView = nil;
    if(!self.mappings[identifierString]){
        if([type isEqualToString:DXTableViewHeaderFooterConstants.DXTKTableViewHeader] && [sectionObject isKindOfClass:[NSString class]]){
            identifierString = DXTableViewHeaderFooterConstants.DXTKTableViewDefineHeader;
        } else {
            return nil;
        }
    }
    if(SYSTEM_VERSION_LESS_THAN(@"6.0")){
        return [[self.mappings[identifierString] alloc] initWithFrame:CGRectMake(0, 0, 320, [self heightForHeaderFooterInSection:sectionObject type:type])];
    } else {
        headerFooterView = [table dequeueReusableHeaderFooterViewWithIdentifier:identifierString];
    }

    return headerFooterView;
}

- (CGFloat)heightForHeaderFooterInSection:(id)sectionObject type:(NSString *)type
{
    NSString* identifierString = [NSString stringWithFormat:@"%@%@",NSStringFromClass([sectionObject class]),type];
    if(!self.mappings[identifierString]){
        if([type isEqualToString:DXTableViewHeaderFooterConstants.DXTKTableViewHeader] && [sectionObject isKindOfClass:[NSString class]]){
           return [DXTKBaseHeader heightForHeaderFooter];
        }
    } else {
       return [(id<DXTKHeaderFooterFilling>)self.mappings[identifierString] heightForHeaderFooter];
    }
    return 0;
}

@end