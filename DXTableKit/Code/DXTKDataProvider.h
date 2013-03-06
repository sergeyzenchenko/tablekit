//
//  HIDataProvider.h
//  Grid
//
//  Created by zen on 2/19/13.
//  Copyright (c) 2013 111min. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DXTKDataProvider;

@protocol DXTKDataProviderDelegate <NSObject>

- (void)dataProvider:(id<DXTKDataProvider>)dataProvider didFinishLoadingWithError:(NSError *)error;
- (void)dataProviderDidFinishLoading:(id<DXTKDataProvider>)dataProvider;

@end

@protocol DXTKDataProvider <NSObject>

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, weak) id<DXTKDataProviderDelegate> delegate;

- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (id)objectForIndexPath:(NSIndexPath *)path;
- (NSInteger)numberOfSections;
- (void)reload;
- (BOOL)isLoadable;

- (void)commitResult:(NSArray *)array;
- (void)commitError:(NSError *)error;

@end