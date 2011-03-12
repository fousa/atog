/*
 *  CommonMacros.h
 *
 *  Created by Piet Jaspers on 28/12/10.
 *  Copyright 2010 10to1. All rights reserved.
 *
 */

// A check to see if we're running on an iPad.
// Blatantly picked up from: http://cocoawithlove.com/2010/07/tips-tricks-for-conditional-ios3-ios32.html
static inline BOOL IsIPad() {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 30200
    if ([[UIDevice currentDevice] respondsToSelector:@selector(userInterfaceIdiom)] &&
        [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
		return YES;
	}
    else
#endif
    {
       	return NO;
    }
}