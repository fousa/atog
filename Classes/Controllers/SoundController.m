//
//  SoundController.m
//  Atog
//
//  Created by Jelle Vandebeeck on 10/03/11.
//  Copyright 2011 10to1. All rights reserved.
//

#import "SoundController.h"

static SoundController *singletonSoundController = nil;

@interface SoundController () {
	NSMutableArray *_sounds;
	NSString *_sound;
	BOOL _dirtyAllowed;
}
@end

@implementation SoundController

#pragma mark -
#pragma mark Singleton

+ (SoundController *)instance {
	@synchronized(self) {
		if (!singletonSoundController) {
			singletonSoundController = [[SoundController alloc] init];
			[singletonSoundController loadPreferences];
			[singletonSoundController loadSounds];
		}
	}
	return singletonSoundController;
}

#pragma mark -
#pragma mark Loading

- (void)loadPreferences {
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	_dirtyAllowed = [defaults boolForKey:@"enable_dirty_talk"];
}

- (void)loadSounds {
	NSArray *allSounds = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Sounds" ofType:@"plist"]];
	[_sounds release];
	_sounds = [[NSMutableArray array] retain];
	for (NSDictionary *aSound in allSounds) {
		if (_dirtyAllowed || ![[aSound objectForKey:@"dirty"] boolValue]) {
			[_sounds addObject:((NSString *)[aSound objectForKey:@"filename"])];
		}
	}

	srand(time(NULL));
}

- (NSString *)randomSound {
		int value = rand() % [_sounds count];
		NSString *selectedSound = [_sounds objectAtIndex:value];
		if ([selectedSound compare:_sound] == NSOrderedSame) {
			return [self randomSound];
		}
		_sound = selectedSound;
	
	
	return _sound;
}

#pragma mark -
#pragma mark Memory

- (void)dealloc {
	[_sound release], _sound = nil;
	[_sounds release], _sounds = nil;
	[super dealloc];
}

@end
