//
//  DXTKDelegateProxyPluginSpec.m
//  DXTableKit
//
//  Created by Sergey Zenchenko on 4/2/14.
//  Copyright 2014 111min. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "DXTKDataSourceDelegate.h"
#import "DXTKDelegateProxyPlugin.h"


SPEC_BEGIN(DXTKDelegateProxyPluginSpec)

    describe(@"DXTKDelegateProxyPlugin", ^{
        it(@"Should call didSelectDomainObject:atIndex:fromDataSource:", ^{
            NSObject<DXTKDataSourceDelegate> *delegate = [KWMock mockForProtocol:@protocol(DXTKDataSourceDelegate)];

            [[delegate should] receive:@selector(didSelectDomainObject:atIndexPath:fromDataSource:)
                         withArguments:@(1), @(2), @(3), nil];

            DXTKDelegateProxyPlugin *plugin = [[DXTKDelegateProxyPlugin alloc] initWithDelegate:delegate];

            [plugin didSelectDomainObject:@(1) atIndexPath:@(2) fromDataSource:@(3)];
        });
    });

SPEC_END
