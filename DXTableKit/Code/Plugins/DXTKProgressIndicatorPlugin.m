//
//  HIProgressIndicatorPlugin.m
//  HomeImprovements
//
//  Created by zen on 2/22/13.
//  Copyright (c) 2013 111Minutes. All rights reserved.
//

#import "DXTKProgressIndicatorPlugin.h"
#import "DXTKBaseDataSource.h"

@interface DXTKProgressIndicatorPlugin ()

@property (nonatomic, weak) DXTKBaseDataSource *dataSource;

@end

@implementation DXTKProgressIndicatorPlugin

- (void)attachToDataSource:(DXTKBaseDataSource *)dataSource
{
    self.dataSource = dataSource;
}

#pragma mark -
#pragma mark HIDataProviderDelegate

- (void)reload
{
    [MBProgressHUD showHUDAddedTo:self.dataSource.contentView animated:YES];
}

- (void)dataProvider:(id <DXTKDataProvider>)dataProvider didFinishLoadingWithError:(NSError *)error
{
    
}

- (void)dataProviderDidFinishLoading:(id <DXTKDataProvider>)dataProvider
{
    [MBProgressHUD hideAllHUDsForView:self.dataSource.contentView animated:YES];
}

@end
