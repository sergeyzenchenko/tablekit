//
//  DXTKContentSectionSpec.m
//  DXTableKit
//
//  Created by Sergey Zenchenko on 4/2/14.
//  Copyright 2014 111min. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "DXTKContentSection.h"


SPEC_BEGIN(DXTKContentSectionSpec)

__block DXTKContentSection *section;

NSNumber *item = @(1);

NSArray *items = @[item, @(10)];
NSString *sectionObject = @"SectionObject";

void (^tests)() = ^ {
    it(@"Should have 2 items", ^{
        [[theValue([section numberOfObjects]) should] equal:2 withDelta:0];
    });
    
    it(@"Should have section object", ^{
        [[[section sectionObject] should] equal:sectionObject];
    });
    
    it(@"Should return valid object for index", ^{
        [[[section objectAtIndex:0] should] equal:item];
    });
};

describe(@"#init", ^{
    beforeEach(^{
        section = [DXTKContentSection sectionWithItems:items sectionObject:sectionObject];
    });
    
    tests();
});

describe(@"#sectionWithItems", ^{
    beforeEach(^{
        section = [[DXTKContentSection alloc] initWithItems:items sectionObject:sectionObject];
    });
    
    tests();
});

SPEC_END
