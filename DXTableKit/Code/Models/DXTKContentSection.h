//
// Created by zen on 3/10/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "DXTKContentSectionInfo.h"

@interface DXTKContentSection : NSObject <DXTKContentSectionInfo>

+ (instancetype)sectionWithItems:(NSArray *)items sectionObject:(id)sectionObject;

- (instancetype)initWithItems:(NSArray *)items sectionObject:(id)sectionObject;

@end