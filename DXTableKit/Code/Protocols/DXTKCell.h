/**
* This protocol is required for all cells which you are going to use with DXTableKit
*/
@protocol DXTKCell <NSObject>

/** Update cell interface elements for business object
 * @param object business object
 * */
- (void)fillWithObject:(id)object;

@optional

- (void)setStateInfo:(NSDictionary*)stateInfo;

@end
