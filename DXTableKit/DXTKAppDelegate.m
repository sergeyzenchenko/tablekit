//
//  DXTKAppDelegate.m
//  DXTableKit
//
//  Created by zen on 3/6/13.
//  Copyright (c) 2013 111min. All rights reserved.
//

#import "DXTKAppDelegate.h"

@implementation DXTKAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
