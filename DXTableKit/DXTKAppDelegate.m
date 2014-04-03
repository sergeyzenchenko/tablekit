//
//  DXTKAppDelegate.m
//  DXTableKit
//
//  Created by zen on 3/6/13.
//  Copyright (c) 2013 111min. All rights reserved.
//

#import "DXTKAppDelegate.h"
#import "DXTKRootViewController.h"

@implementation DXTKAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    self.window.rootViewController = [DXTKRootViewController new];
    
    [self.window makeKeyAndVisible];
    return YES;
}

@end
