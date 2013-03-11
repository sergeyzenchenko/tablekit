//
//  HIDataProvider.h
//  Grid
//
//  Created by zen on 2/19/13.
//  Copyright (c) 2013 111min. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DXTKContentProvider;

@protocol DXTKContentProviderDelegate <NSObject>

- (void)dataProvider:(id<DXTKContentProvider>)dataProvider didFinishLoadingWithError:(NSError *)error;
- (void)dataProviderDidFinishLoading:(id<DXTKContentProvider>)dataProvider;

@optional

- (void)dataProviderDidChangeState:(id<DXTKContentProvider>)dataProvider;

- (void)dataProviderWillBeginUpdates:(id<DXTKContentProvider>)dataProvider;
- (void)dataProviderDidEndUpdates:(id<DXTKContentProvider>)dataProvider;

@end

typedef enum DXTKContentProviderState {
    /** State for just created content provider. This is the default. */
    DXTKContentProviderStateCreated,
    /** Content provider is loading content */
    DXTKContentProviderStateLoading,
    /** Content provider is ready and has content */
    DXTKContentProviderStateHasResults,
    /** Content provider loading finished with empty data set */
    DXTKContentProviderStateEmpty,
    /** Content provider loading finished, but content is unavailable (For example there is no internet connection) */
    DXTKContentProviderStateResourceUnavailable,
    /** Content provider loading finished with error and content is not available */
    DXTKContentProviderStateError
} DXTKContentProviderState;

/**
* The goal of content provider is to provide content ofr any type for consumer (table dataSource for example).
*
* Content provider is responsible for loading content from source (remote API, CoreDate, file system, etc)
* and providing information about content structure (number of sections, number of items, specific item for index path) to consumer.
*
* Content provider state **should** describe current status of content provider.
*
* Content provider **shouldn't** provide any information about content representation in user interface. It **should** provide just business object.
*
* All classes which are implementing this protocol **should** keep contract of this protocol.
*/
@protocol DXTKContentProvider <NSObject>

/** @name Properties */

/** Content provider delegate is responsible for reacting on changes of content provider state.  */
@property (nonatomic, weak) id<DXTKContentProviderDelegate> delegate;

/** Content provider state enum DXTKContentProviderState */
@property (nonatomic, assign) DXTKContentProviderState state;

/** @name Content information methods */

/** Get number of sections in content provider.
* @return Number of sections in content provider, if content contains no sections this method should return 1.
* */
- (NSInteger)numberOfSections;

/** Get number of items in specific section.
 * @param section section index
 * @return Number of items in specific section, if content contains no sections this method should return just number of content items
* */
- (NSInteger)numberOfItemsInSection:(NSInteger)section;

/** Get section object at specific section index.
* @param section section index
* @return section Section object or nil if there is no section object for this section index.
* */
- (id)sectionObjectForSection:(NSInteger)section;

/** Get item at specific indexPath.
* @param path item indexPath
* @return Item at specific indexPath.
* @exception NSInternalInconsistencyException If there is not item at this indexPath method should raise and exception
* */
- (id)itemForIndexPath:(NSIndexPath *)path;

/** @name Control methods */

/** Reload content provider.
 * This method should be asynchronous
 * */
- (void)reload;

@end