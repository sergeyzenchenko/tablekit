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
__block NSObject<DXTKContentProviderDelegate> *delegate;

beforeEach(^{
    fetchedResultsController = [KWMock nullMockForClass:[NSFetchedResultsController class]];
    contentProvider = (DXTKCoreDataContentProvider<NSFetchedResultsControllerDelegate> *)[[DXTKCoreDataContentProvider alloc] initWithFetchedResultsController:fetchedResultsController];
    delegate = [KWMock nullMockForProtocol:@protocol(DXTKContentProviderDelegate)];
    [contentProvider setDelegate:delegate];
});

describe(@"DXTKCoreDataContentProvider", ^{
    
    it(@"should conforms to DXTKContentProvider protocol", ^{
        [[contentProvider should] conformToProtocol:@protocol(DXTKContentProvider)];
    });
    
    describe(@"interaction with NSFetchedResultsController", ^{
        
        it(@"should #performFetch: in FetchedResultsController on #reload method call", ^{
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
    
    describe(@"Data changing", ^{
        
        context(@"data loading started", ^{
            it(@"should call #contentProviderDidStartLoading:", ^{
                [[delegate should] receive:@selector(contentProviderDidStartLoading:)
                             withArguments:contentProvider, nil];
                [contentProvider reload];
            });
        });
        
        context(@"data loading finished with error", ^{
            it(@"should call #contentProvider:didFinishLoadingWithError:", ^{
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
        });
        
        context(@"data loading finished successfully", ^{
            it(@"should call #contentProviderDidFinishLoading:", ^{
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
        });
        
        context(@"previous and new states are not equal ", ^{
            beforeEach(^{
                [contentProvider setState:DXTKContentProviderStateReady];
            });
            
            it(@"#contentProviderWillChangeState:", ^{
                [[delegate should] receive:@selector(contentProviderWillChangeState:) withArguments:contentProvider, nil];
                [contentProvider setState:DXTKContentProviderStateError];
            });
            
            it(@"#contentProviderDidChangeState:", ^{
                [[delegate should] receive:@selector(contentProviderDidChangeState:) withArguments:contentProvider, nil];
                [contentProvider setState:DXTKContentProviderStateError];
            });
        });
        
        context(@"new and previous and new states are equal", ^{
            
            beforeEach(^{
                [contentProvider setState:DXTKContentProviderStateError];
            });
            
            it(@"should not call #contentProviderWillChangeState:", ^{
                [[delegate shouldNot] receive:@selector(contentProviderWillChangeState:) withArguments:contentProvider, nil];
                [contentProvider setState:DXTKContentProviderStateError];
            });
            
            it(@"should not call #contentProviderDidChangeState:", ^{
                [[delegate shouldNot] receive:@selector(contentProviderDidChangeState:) withArguments:contentProvider, nil];
                [contentProvider setState:DXTKContentProviderStateError];
            });
        });
    });
    
    describe(@"content changing", ^{
        it(@"should call #contentProviderWillBeginUpdates: when content changing process started", ^{
            [[delegate should] receive:@selector(contentProviderWillBeginUpdates:) withArguments:contentProvider, nil];
            [contentProvider controllerWillChangeContent:nil];
        });
        
        it(@"should call #contentProviderDidEndUpdates: when content changing process compleated", ^{
            [[delegate should] receive:@selector(contentProviderDidEndUpdates:) withArguments:contentProvider, nil];
            [contentProvider controllerDidChangeContent:nil];
        });
        
        context(@"section content updates", ^{
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
        });
        
        context(@"cell content updates", ^{
            it(@"#contentProvider:didInsertCellAtIndexPath:", ^{
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:1];
                [[delegate should] receive:@selector(contentProvider:didInsertCellAtIndexPath:)
                             withArguments:contentProvider,indexPath, nil];
                [contentProvider controller:nil
                            didChangeObject:nil
                                atIndexPath:nil
                              forChangeType:NSFetchedResultsChangeInsert
                               newIndexPath:indexPath];
            });
            
            it(@"#contentProvider:didMoveCellAtIndexPath:toIndexPath:", ^{
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:1];
                NSIndexPath *toIndexPath = [NSIndexPath indexPathForRow:2 inSection:1];
                [[delegate should] receive:@selector(contentProvider:didMoveCellAtIntexPath:toIndexPath:)
                             withArguments:contentProvider, indexPath, toIndexPath];
                [contentProvider controller:nil
                            didChangeObject:nil
                                atIndexPath:indexPath
                              forChangeType:NSFetchedResultsChangeMove
                               newIndexPath:toIndexPath];
            });
            
            it(@"#contentProvider:didUpdateCellAtIndexPath:", ^{
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:1];
                [[delegate should] receive:@selector(contentProvider:didUpdateCellAtIndexPath:)
                             withArguments:contentProvider, indexPath];
                [contentProvider controller:nil
                            didChangeObject:nil
                                atIndexPath:indexPath
                              forChangeType:NSFetchedResultsChangeUpdate
                               newIndexPath:nil];
            });
            
            it(@"#contentProvider:didRemoveRowAtIndexPath:", ^{
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:1];
                [[delegate should] receive:@selector(contentProvider:didRemoveCellAtIndexPath:)
                             withArguments:contentProvider, indexPath, nil];
                [contentProvider controller:nil
                            didChangeObject:nil
                                atIndexPath:indexPath
                              forChangeType:NSFetchedResultsChangeDelete
                               newIndexPath:nil];
            });
        });
    });
    
    describe(@"state switching", ^{
        context(@"just initialized", ^{
            it(@"should be in #DXTKContentProviderStateReady state", ^{
                [[theValue(contentProvider.state) should] equal:theValue(DXTKContentProviderStateReady)];
            });
        });
        
        context(@"start data loading", ^{            
            context(@"content provider does not have previous data", ^{
                it(@"should enter #DXTKContentProviderStateLoading state", ^{
                    [[contentProvider should] receive:@selector(setState:) withArguments:theValue(DXTKContentProviderStateLoading)];
                    [contentProvider reload];
                });
                
                it(@"should not enter #DXTKContentProviderStateUpdating state", ^{
                    [contentProvider setState:DXTKContentProviderStateEmpty];
                    [[contentProvider shouldNot] receive:@selector(setState:) withArguments:theValue(DXTKContentProviderStateUpdating)];
                    [contentProvider reload];
                });
            });
            
            context(@"content provider have previous data", ^{
                it(@"should enter DXTKContentProviderStateUpdating state", ^{
                    [contentProvider setState:DXTKContentProviderStateHasResults];
                    [[contentProvider should] receive:@selector(setState:) withArguments:theValue(DXTKContentProviderStateUpdating)];
                    [contentProvider reload];
                });
                
                it(@"should not enter #DXTKContentProviderStateLoading state", ^{
                    [contentProvider setState:DXTKContentProviderStateHasResults];
                    [[contentProvider shouldNot] receive:@selector(setState:) withArguments:theValue(DXTKContentProviderStateLoading)];
                    [contentProvider reload];
                });
            });
        });
        
        context(@"finish data loading", ^{
            context(@"finished successfully", ^{
                context(@"new data present", ^{
                    it(@"should enter #DXTKContentProviderStateHasResults state", ^{
                        [fetchedResultsController stub:@selector(fetchedObjects) andReturn:@[@1, @2]];
                        [[contentProvider shouldNot] receive:@selector(setState:) withArguments:theValue(DXTKContentProviderStateEmpty)];
                        [[contentProvider should] receive:@selector(setState:) withArguments:theValue(DXTKContentProviderStateHasResults)];
                        [contentProvider reload];
                    });
                });
                
                context(@"no data", ^{
                    context(@"empty array", ^{
                        it(@"should enter #DXTKContentProviderStateEmpty state", ^{
                            [fetchedResultsController stub:@selector(fetchedObjects) andReturn:@[]];
                            [contentProvider reload];
                            [[theValue(contentProvider.state) should] equal:theValue(DXTKContentProviderStateEmpty)];
                        });
                    });
                    
                    context(@"nil array", ^{
                        it(@"should enter #DXTKContentProviderStateEmpty state", ^{
                            [fetchedResultsController stub:@selector(fetchedObjects) andReturn:nil];
                            [contentProvider reload];
                            [[theValue(contentProvider.state) should] equal:theValue(DXTKContentProviderStateEmpty)];
                        });
                    });
                });
            });
            
            context(@"finished with error", ^{
                it(@"should enter #DXTKContentProviderStateError state", ^{
                    NSError *error = [NSError errorWithDomain:@"some error" code:0 userInfo:nil];
                    [fetchedResultsController stub:@selector(performFetch:) withBlock:^id(NSArray *params) {
                        NSValue *pointerValue = params[0];
                        void **errorRef = [pointerValue pointerValue];
                        *errorRef = (__bridge void *)(error);
                        return nil;
                    }];
                    [contentProvider reload];
                    [[theValue(contentProvider.state) should] equal:theValue(DXTKContentProviderStateError)];
                });
            });
        });
        
        
        /** Content provider loading more data */
        it(@"#DXTKContentProviderStateOutdated", ^{
            
        });
    });
    
});

SPEC_END