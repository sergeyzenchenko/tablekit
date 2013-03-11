#import "DXTKBaseContentProvider.h"

@interface DXTKBaseContentProvider ()

@property (nonatomic, strong) NSArray *items;

@end

@implementation DXTKBaseContentProvider

@synthesize delegate = _delegate, state = _state;

- (id)init
{
    self = [super init];
    if (self) {
        [self prepareToUse];
    }
    return self;
}

- (void)prepareToUse
{

}

- (NSInteger)numberOfItemsInSection:(NSInteger)section
{
    return self.items.count;
}

- (id)itemForIndexPath:(NSIndexPath *)path
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

    if (self.items.count > 0) {
        self.state = DXTKContentProviderStateHasResults;
    } else {
        self.state = DXTKContentProviderStateEmpty;
    }

    [self.delegate dataProviderDidFinishLoading:self];
}

- (void)commitError:(NSError *)error
{
    self.state = DXTKContentProviderStateError;
    [self.delegate dataProvider:self didFinishLoadingWithError:error];
}

@end