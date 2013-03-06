#import "DXTKBaseDataProvider.h"

@interface DXTKBaseDataProvider()

@end

@implementation DXTKBaseDataProvider

@synthesize delegate;
@synthesize items = _items;

- (NSInteger)numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

- (id)objectForIndexPath:(NSIndexPath *)path
{
    NSParameterAssert(path.section == 0);
    NSParameterAssert(path.row <= self.items.count);
    
    return self.items[path.row];
}

- (NSInteger)numberOfSections
{
    return 1;
}

- (void)reload
{
    @throw @"Not implemented";
}

- (void)commitResult:(NSArray *)array
{
    self.items = array;
    [self.delegate dataProviderDidFinishLoading:self];
}

- (void)commitError:(NSError *)error
{
    [self.delegate dataProvider:self didFinishLoadingWithError:error];
}

- (BOOL)isLoadable
{
    return YES;
}

@end