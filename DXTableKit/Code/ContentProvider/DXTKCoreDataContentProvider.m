//
//  DXTKCoreDataContentProvider.m
//  DXTableKit
//
//  Created by Vladimir Shevchenko on 5/7/14.
//  Copyright (c) 2014 111min. All rights reserved.
//

#import "DXTKCoreDataContentProvider.h"
#import <CoreData/CoreData.h>

@interface DXTKCoreDataContentProvider () <NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

@end

@implementation DXTKCoreDataContentProvider
@synthesize delegate, state = _state;

#pragma mark - 
#pragma mark - initialization
#pragma mark -

- (id)initWithFetchedResultsController:(NSFetchedResultsController *)controller
{
    NSParameterAssert(controller);
    
    self = [super init];
    if (self) {
        self.state = DXTKContentProviderStateReady;
        self.fetchedResultsController = controller;
    }
    return self;
}

- (id)init UNAVAILABLE_ATTRIBUTE
{
    return nil;
}

#pragma mark - 
#pragma mark - NSfetchedResultsControllerDelegate protocol implementation
#pragma mark -

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    if ([self.delegate respondsToSelector:@selector(contentProviderWillBeginUpdates:)]) {
        [self.delegate contentProviderWillBeginUpdates:self];
    }
}

- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath
     forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    switch (type) {
        case NSFetchedResultsChangeInsert: {
            if ([self.delegate respondsToSelector:@selector(contentProvider:didInsertRowAtIndexPath:)]) {
                [self.delegate contentProvider:self didInsertRowAtIndexPath:newIndexPath];
            }
            break;
        }
        
        case NSFetchedResultsChangeMove: {
            break;
        }
            
        case NSFetchedResultsChangeUpdate: {
            break;
        }
        
        case NSFetchedResultsChangeDelete: {
            if ([self.delegate respondsToSelector:@selector(contentProvider:didRemoveRowAtIndexPath:)]) {
                [self.delegate contentProvider:self didRemoveRowAtIndexPath:indexPath];
            }
            break;
        }
            
        default:
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller
  didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex
     forChangeType:(NSFetchedResultsChangeType)type
{
    switch (type) {
        case NSFetchedResultsChangeInsert: {
            if ([self.delegate respondsToSelector:@selector(contentProvider:didInsertSection:)]) {
                [self.delegate contentProvider:self didInsertSection:sectionIndex];
            }
            break;
        }
            
        case NSFetchedResultsChangeMove: {
            break;
        }
            
        case NSFetchedResultsChangeUpdate: {
            break;
        }
            
        case NSFetchedResultsChangeDelete: {
            if ([self.delegate respondsToSelector:@selector(contentProvider:didRemoveSection:)]) {
                [self.delegate contentProvider:self didRemoveSection:sectionIndex];
            }
            break;
        }
            
        default:
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    if ([self.delegate respondsToSelector:@selector(contentProviderDidEndUpdates:)]) {
        [self.delegate contentProviderDidEndUpdates:self];
    }
}

#pragma mark - 
#pragma mark - DXTKContentProvider protcol implementation
#pragma mark - 

- (NSInteger)numberOfSections
{
    return self.fetchedResultsController.sections.count;
}

- (NSInteger)numberOfItemsInSection:(NSUInteger)section
{
    return [(id<NSFetchedResultsSectionInfo>)self.fetchedResultsController.sections[section] numberOfObjects];
}

- (id<DXTKContentSection>)sectionObjectForSection:(NSUInteger)section
{
    return self.fetchedResultsController.sections[section];
}

- (id)itemForIndexPath:(NSIndexPath *)path
{
    return [self.fetchedResultsController objectAtIndexPath:path];
}

#pragma mark - 
#pragma mark - setters
#pragma mark -

- (void)setState:(DXTKContentProviderState)state
{
    if ([self.delegate respondsToSelector:@selector(contentProviderWillChangeState:)]) {
        [self.delegate contentProviderWillChangeState:self];
    }
    
    _state = state;
    
    if ([self.delegate respondsToSelector:@selector(contentProviderDidChangeState:)]) {
        [self.delegate contentProviderDidChangeState:self];
    }
}

#pragma mark -
#pragma mark - implementation
#pragma mark -

- (void)reload
{
    if ([self.delegate respondsToSelector:@selector(contentProviderDidStartLoading:)]) {
        [self.delegate contentProviderDidStartLoading:self];
    }
 
    self.state = DXTKContentProviderStateLoading;
    
    NSError *error = nil;
    [self.fetchedResultsController performFetch:&error];
    
    if (error != nil) {
        if ([self.delegate respondsToSelector:@selector(contentProvider:didFinishLoadingWithError:)]) {
            [self.delegate contentProvider:self didFinishLoadingWithError:error];
        }
        self.state = DXTKContentProviderStateError;
    } else {
        if ([self.delegate respondsToSelector:@selector(contentProviderDidFinishLoading:)]) {
            [self.delegate contentProviderDidFinishLoading:self];
        }
        self.state = DXTKContentProviderStateHasResults;
    }    
}

@end
