//
//  AtogViewController.m
//  Atog
//
//  Created by Jelle Vandebeeck on 07/03/11.
//  Copyright 2011 10to1. All rights reserved.
//

#import "AtogViewController.h"

#import <AVFoundation/AVFoundation.h>

#import "PlayButton.h"

@implementation AtogViewController

#pragma mark -
#pragma mark View flow

- (void)viewDidLoad {
	NSString *text = @"Say something!";
	UIFont *font = [UIFont systemFontOfSize:20];
	float width = [text sizeWithFont:font].width;
	
	PlayButton *button = [[PlayButton alloc] initWithFrame:CGRectMake(10, 10, width + 40, 50)];
	button.center = CGPointMake((self.view.frame.size.width / 2), self.view.frame.size.height - 65);
	[button setTitle:text forState:UIControlStateNormal];
	[button setFont:font];
	UIImage *background = [[UIImage imageNamed:@"button.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:5];
	[button setBackgroundImage:background forState:UIControlStateNormal];
	[button addTarget:self action:@selector(playRandomQuote:) forControlEvents:UIControlEventTouchDown];
	[self.view addSubview:button];
	[button release];
}

#pragma mark -
#pragma mark Actions

- (IBAction)playRandomQuote:(id)sender {
	//SystemSoundID soundID;
//	NSString *path = [[NSBundle mainBundle] pathForResource:@"gast" ofType:@"3gp"];
//	NSURL *url = [NSURL fileURLWithPath:path];
//	AudioServicesCreateSystemSoundID ((CFURLRef)url, &soundID);
//	AudioServicesPlaySystemSound(soundID);
	
	
	NSString *urlAddress = [[NSBundle mainBundle] pathForResource:@"gast" ofType:@"3gp"];
	NSURL *url = [NSURL fileURLWithPath:urlAddress];
	AVAudioPlayer *audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
	audioPlayer.numberOfLoops = 0;
	[audioPlayer play];
}

#pragma mark -
#pragma mark Memory

- (void)dealloc {
    [super dealloc];
}

@end
