//
// Created by zen on 3/10/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

/**
* This class is responsible for storing information about section of content in content providers
*/
@interface DXTKContentSection : NSObject

/** Object which represent section. It can be a string or custom business object */
@property (nonatomic, strong) id sectionObject;

/** Array of business objects in section */
@property (nonatomic, strong) NSArray *items;

@end