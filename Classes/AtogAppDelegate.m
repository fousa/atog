//
//  AtogAppDelegate.m
//  Atog
//
//  Created by Jelle Vandebeeck on 07/03/11.
//  Copyright 2011 10to1. All rights reserved.
//

#import "AtogAppDelegate.h"

@implementation AtogAppDelegate

@synthesize window, viewController;

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    [self.window addSubview:self.viewController.view];
    [self.window makeKeyAndVisible];

    return YES;
}

#pragma mark -
#pragma mark Memory

- (void)dealloc {
    self.viewController = nil;
    self.window = nil;
	
    [super dealloc];
}


@end
