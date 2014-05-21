//
//  DXTKCoreDataContentProvider.h
//  DXTableKit
//
//  Created by Vladimir Shevchenko on 5/7/14.
//  Copyright (c) 2014 111min. All rights reserved.
//

#import "DXTKContentProvider.h"

@class NSFetchedResultsController;
@interface DXTKCoreDataContentProvider : NSObject <DXTKContentProvider>

- (id)initWithFetchedResultsController:(NSFetchedResultsController *)controller;

@end
