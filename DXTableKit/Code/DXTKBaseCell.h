/**
* This protocol is required for all cells which you are going to use with DXTableKit
*/
@protocol DXTKBaseCell <NSObject>

/** Update cell interface elements for business object
 * @param object business object
 * */
- (void)fillWithObject:(id)object;

@end
