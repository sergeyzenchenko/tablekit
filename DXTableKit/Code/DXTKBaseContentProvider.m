#import "DXTKBaseContentProvider.h"

@interface DXTKBaseContentProvider ()

@property (nonatomic, strong) NSArray *sections;

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

- (NSInteger)numberOfItemsInSection:(NSUInteger)section
{
    return [[self.sections[section] items] count];
}

- (id)sectionObjectForSection:(NSUInteger)section
{
    return self.sections[section];
}

- (id)itemForIndexPath:(NSIndexPath *)path
{
    NSParameterAssert(path.section <= self.sections.count);
    NSParameterAssert(path.row <= [[self.sections[path.section] items] count]);
    
    return [self.sections[path.section] items][path.row];
}

- (NSInteger)numberOfSections
{
    return self.sections.count;
}

- (void)reload
{
    @throw @"Not implemented";
}

- (void)commitResult:(NSArray *)array
{
    self.sections = array;

    if (self.sections.count > 0) {
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