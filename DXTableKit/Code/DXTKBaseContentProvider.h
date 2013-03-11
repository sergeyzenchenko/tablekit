#import <Foundation/Foundation.h>
#import "DXTKContentProvider.h"

@interface DXTKBaseContentProvider : NSObject <DXTKContentProvider>

- (void)commitResult:(id)result;
- (void)commitError:(NSError *)error;

- (void)prepareToUse;

@end