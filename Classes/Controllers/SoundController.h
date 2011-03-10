//
//  SoundController.h
//  Atog
//
//  Created by Jelle Vandebeeck on 10/03/11.
//  Copyright 2011 10to1. All rights reserved.
//

@interface SoundController : NSObject
@property (nonatomic, readonly) NSString *randomSound;

+ (SoundController *)instance;

- (void)loadPreferences;
- (void)loadSounds;
@end
