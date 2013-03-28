//
//  IOS5Footer.h
//  DXTableKit
//
//  Created by Vlad Korzun on 28.03.13.
//  Copyright (c) 2013 111min. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DXTKHeaderFooterFilling.h"
@interface IOS5Footer : UIView<DXTKHeaderFooterFilling>
@property (nonatomic,strong)UILabel* textLabel;
@end
