//
//  DXTKExampelContentProvider.m
//  DXTableKit
//
//  Created by Sergey Zenchenko on 4/3/14.
//  Copyright (c) 2014 111min. All rights reserved.
//

#import "DXTKExampelContentProvider.h"

@implementation DXTKExampelContentProvider

@synthesize delegate = _delegate, state = _state;

- (NSInteger)numberOfSections
{
    return 1;
}

- (NSInteger)numberOfItemsInSection:(NSUInteger)section
{
    return 1000000;
}

- (id<DXTKContentSection>)sectionObjectForSection:(NSUInteger)section
{
    return nil;
}

- (id)itemForIndexPath:(NSIndexPath *)path
{
    return @(path.row);
}

- (void)reload
{
    [self.delegate contentProviderDidStartLoading:self];
    self.state = DXTKContentProviderStateHasResults;
    [self.delegate contentProviderDidFinishLoading:self];
}


@end
