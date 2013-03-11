//
// Created by zen on 3/10/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

typedef void (^MenuCallBack)();

@interface MenuItem : NSObject
@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) MenuCallBack callback;
@end