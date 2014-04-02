#import "DXTKBaseContentProvider.h"
#import "DXTKContentSection.h"

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

- (NSInteger)numberOfSections
{
    return self.sections.count;
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
    return [self.sections[path.section] items][path.row];
}

- (void)reload
{
    @throw @"Not implemented";
}

- (void)commitResult:(NSArray *)array
{
    array = [self embedSectionIfNeed:array];
    
    self.sections = array;
    
    if (self.sections.count > 0) {
        self.state = DXTKContentProviderStateHasResults;
    } else {
        self.state = DXTKContentProviderStateEmpty;
    }

    [self.delegate contentProviderDidFinishLoading:self];
}

- (NSArray *)embedSectionIfNeed:(NSArray *)array
{
    if (array.count > 0 && ![array[0] isKindOfClass:[DXTKContentSection class]]) {
        DXTKContentSection *contentSection = [DXTKContentSection new];
        contentSection.items = array;
        array = @[contentSection];
    }
    
    return array;
}
- (void)commitError:(NSError *)error
{
    self.state = DXTKContentProviderStateError;
    [self.delegate contentProvider:self didFinishLoadingWithError:error];
}

@end