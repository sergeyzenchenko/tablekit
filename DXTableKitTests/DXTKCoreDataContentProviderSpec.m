//
//  DXTKCoreDataContentProviderSpec.m
//  DXTableKit
//
//  Created by Vladimir Shevchenko on 5/7/14.
//  Copyright (c) 2014 111min. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "DXTKCoreDataContentProvider.h"
#import <CoreData/CoreData.h>

SPEC_BEGIN(DXTKContentProviderSpec)

__block DXTKCoreDataContentProvider<NSFetchedResultsControllerDelegate> *contentProvider;
__block NSFetchedResultsController *fetchedResultsController;

beforeAll(^{
    fetchedResultsController = [KWMock mockForClass:[NSFetchedResultsController class]];
    contentProvider = (DXTKCoreDataContentProvider<NSFetchedResultsControllerDelegate> *)[[DXTKCoreDataContentProvider alloc] initWithFetchedResultsController:fetchedResultsController];
});

describe(@"DXTKCoreDataContentProvider", ^{
    
    it(@"should conforms to DXTKContentProvider protocol", ^{
        [[contentProvider should] conformToProtocol:@protocol(DXTKContentProvider)];
    });

    it(@"should have fetchedResultsController method", ^{
        [[contentProvider should] respondToSelector:@selector(fetchedResultsController)];
    });
    
    it(@"should conforms to NSFetchedResultsControllerDelegate protocol", ^{
        [[contentProvider should] conformToProtocol:@protocol(NSFetchedResultsControllerDelegate)];
    });
    
    context(@"initialization", ^{
        it(@"should init with NSFetchedResultsController", ^{
            [[contentProvider should] respondToSelector:@selector(initWithFetchedResultsController:)];
        });
    });
    
    context(@"with fetched results Controller", ^{
        
        it(@" 's fetchedResultsController should performFetch on reload ", ^{
            [[fetchedResultsController should] receive:@selector(performFetch:)];
            [contentProvider reload];
        });
        
        it(@"should return fetchedResultsController's numberOfSections", ^{
            [fetchedResultsController stub:@selector(sections) andReturn:@[@1, @2]];
            NSUInteger sections = [contentProvider numberOfSections];
            [[theValue(sections) should] equal:theValue([[fetchedResultsController sections] count])];
        });
        
        it(@"should return fetchedResultsController's numberOfItemsInSection", ^{
            id sectionInfo = [KWMock mockForProtocol:@protocol(NSFetchedResultsSectionInfo)];
            [sectionInfo stub:@selector(numberOfObjects) andReturn:@(2)];
            [fetchedResultsController stub:@selector(sections) andReturn:@[sectionInfo]];
            
            id<NSFetchedResultsSectionInfo> section = fetchedResultsController.sections.firstObject;
            NSUInteger itemsInSectionsFromController = [section numberOfObjects];
            NSUInteger itemsFromContentProvider = [contentProvider numberOfItemsInSection:0];
            [[theValue(itemsInSectionsFromController) should] equal:theValue(itemsFromContentProvider)];
        });
        
        it(@"should return fetchedResultsController's objectAtIndexPath", ^{
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
            [fetchedResultsController stub:@selector(objectAtIndexPath:) andReturn:[NSObject new]];
            
            id objectFromContentProvider = [contentProvider itemForIndexPath:indexPath];
            id objectFromController = [fetchedResultsController objectAtIndexPath:indexPath];
            [[objectFromContentProvider should] equal:objectFromController];
        });
        
        it(@"should return fetchedResultsController's sectionInfo", ^{
            id sectionInfo = [KWMock mockForProtocol:@protocol(NSFetchedResultsSectionInfo)];
            [fetchedResultsController stub:@selector(sections) andReturn:@[sectionInfo]];

            [[(id)[contentProvider sectionObjectForSection:0] should] equal:sectionInfo];
        });
    });
    
    context(@"have delegate", ^{
        
        __block NSObject<DXTKContentProviderDelegate> *delegate;
        
        beforeEach(^{
            delegate = [KWMock nullMockForProtocol:@protocol(DXTKContentProviderDelegate)];
            [contentProvider setDelegate:delegate];
        });
        
        it(@"should set delegate", ^{
            [[(id)contentProvider.delegate should] beNonNil];
        });
        
        it(@"#contentProviderDidStartLoading:", ^{
            [[delegate should] receive:@selector(contentProviderDidStartLoading:) withArguments:contentProvider, nil];
            [contentProvider reload];
        });
        
        it(@"#contentProvider:didFinishLoadingWithError:", ^{
            NSError *error = [NSError errorWithDomain:@"some error" code:0 userInfo:nil];
            [fetchedResultsController stub:@selector(performFetch:) withBlock:^id(NSArray *params) {
                NSValue *pointerValue = params[0];
                void **errorRef = [pointerValue pointerValue];
                *errorRef = (__bridge void *)(error);
                return nil;
            }];
            [[delegate should] receive:@selector(contentProvider:didFinishLoadingWithError:)
                            withArguments:contentProvider,error, nil];
            [contentProvider reload];
        });
        
        it(@"#contentProviderDidFinishLoading:", ^{
            NSError *error = nil;
            [fetchedResultsController stub:@selector(performFetch:) withBlock:^id(NSArray *params) {
                NSValue *pointerValue = params[0];
                void **errorRef = [pointerValue pointerValue];
                *errorRef = (__bridge void *)(error);
                return nil;
            }];
            [[delegate should] receive:@selector(contentProviderDidFinishLoading:) withArguments:contentProvider, nil];
            [contentProvider reload];
        });
        
        it(@"#contentProviderWillChangeState:", ^{
            [[delegate should] receive:@selector(contentProviderWillChangeState:) withArguments:contentProvider, nil];
            [contentProvider setState:DXTKContentProviderStateError];
        });
        
        it(@"#contentProviderDidChangeState:", ^{
            [[delegate should] receive:@selector(contentProviderDidChangeState:) withArguments:contentProvider, nil];
            [contentProvider setState:DXTKContentProviderStateError];
        });
        
        it(@"#contentProviderWillBeginUpdates:", ^{
            [[delegate should] receive:@selector(contentProviderWillBeginUpdates:) withArguments:contentProvider, nil];
            [contentProvider controllerWillChangeContent:nil];
        });
        
        it(@"#contentProviderDidEndUpdates:", ^{
            [[delegate should] receive:@selector(contentProviderDidEndUpdates:) withArguments:contentProvider, nil];
            [contentProvider controllerDidChangeContent:nil];
        });
        
        it(@"#contentProvider:didInsertSection:", ^{
            [[delegate should] receive:@selector(contentProvider:didInsertSection:)
                         withArguments:contentProvider, theValue(2), nil];
            [contentProvider controller:nil didChangeSection:nil atIndex:2 forChangeType:NSFetchedResultsChangeInsert];
        });
        
        it(@"#contentProvider:didRemoveSection:", ^{
            [[delegate should] receive:@selector(contentProvider:didRemoveSection:)
                         withArguments:contentProvider, theValue(2), nil];
            [contentProvider controller:nil didChangeSection:nil atIndex:2 forChangeType:NSFetchedResultsChangeDelete];
        });
        
        it(@"#contentProvider:didInsertRowAtIndexPath:", ^{
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:1];
            [[delegate should] receive:@selector(contentProvider:didInsertRowAtIndexPath:)
                         withArguments:contentProvider,indexPath, nil];
            [contentProvider controller:nil
                        didChangeObject:nil
                            atIndexPath:indexPath
                          forChangeType:NSFetchedResultsChangeInsert
                           newIndexPath:indexPath];
        });
        
        it(@"#contentProvider:didRemoveRowAtIndexPath:", ^{
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:1];
            [[delegate should] receive:@selector(contentProvider:didRemoveRowAtIndexPath:)
                         withArguments:contentProvider, indexPath, nil];
            [contentProvider controller:nil
                        didChangeObject:nil
                            atIndexPath:indexPath
                          forChangeType:NSFetchedResultsChangeDelete
                           newIndexPath:indexPath];
        });
    });
    
    context(@"state switching", ^{
        
        /** State for just created content provider. This is the default. */
        it(@"#DXTKContentProviderStateReady", ^{

        });
        /** Content provider is loading content */
        it(@"#DXTKContentProviderStateLoading", ^{
        });
        
         /** Content provider is ready and has content */
        it(@"#DXTKContentProviderStateHasResults", ^{
        });
        
        /** Content provider loading finished with empty data set */
        it(@"#DXTKContentProviderStateEmpty", ^{
        });
        
        /** Content provider loading more data */
        it(@"#DXTKContentProviderStateOutdated", ^{
            
        });
        
        /** Content provider loading more data */
        it(@"#DXTKContentProviderStateUpdating", ^{

        });
        
        /** Content provider loading finished with error and content is not available */
        it(@"#DXTKContentProviderStateError", ^{
        
        });
        
    });
    
});

SPEC_END