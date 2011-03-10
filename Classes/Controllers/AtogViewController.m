//
//  AtogViewController.m
//  Atog
//
//  Created by Jelle Vandebeeck on 07/03/11.
//  Copyright 2011 10to1. All rights reserved.
//

#import "AtogViewController.h"

#import "SoundController.h"

@interface AtogViewController () {
	GKPeerPickerController *picker;
	NSArray *gameData;
	AVAudioPlayer *player;
}

@property (nonatomic, retain) GKSession *session;
@property (nonatomic, retain) NSString *peerId;
@end

@interface AtogViewController (Actions)
- (void)playWithDuration:(NSNumber *)duration;
- (void)playSound;
@end

@interface AtogViewController (Animations)
- (void)moveMouthWithDuration:(float)duration;
- (void)startBlinking;
- (void)stopBlinking;
@end

@implementation AtogViewController

#pragma mark -
#pragma mark Initialization

- (void)viewDidLoad {
	[SoundController instance];
}

#pragma mark -
#pragma mark Actions

- (IBAction)playRandomQuote:(id)sender {
	[self playSound];
	[self moveMouthWithDuration:player.duration];
	
	if (self.peerId) {
		NSData *data = [NSKeyedArchiver archivedDataWithRootObject:[NSNumber numberWithFloat:player.duration]];
		[self.session sendData:data toPeers:[NSArray arrayWithObject:peerId] withDataMode:GKSendDataUnreliable error:nil];
	}
}

- (IBAction)connect:(id)sender {
	if (self.session) {
		[self.session disconnectFromAllPeers];
		self.session = nil;
		self.bluetooth.selected = NO;
		[self stopBlinking];
	} else {
		picker = [[GKPeerPickerController alloc] init];
		picker.delegate = self;
		picker.connectionTypesMask = GKPeerPickerConnectionTypeNearby;
		[picker show];
	}
}

#pragma mark -
#pragma mark Connection

- (GKSession *)peerPickerController:(GKPeerPickerController *)aPicker sessionForConnectionType:(GKPeerPickerConnectionType)type {
    self.session = [[GKSession alloc] initWithSessionID:nil displayName:@"Atog" sessionMode:GKSessionModePeer];
    [self.session autorelease];
    return self.session;
}

- (void)peerPickerController:(GKPeerPickerController *)aPicker didConnectPeer:(NSString *)aPeerID toSession:(GKSession *)aSession {
    self.session = aSession;
	self.peerId = aPeerID;

    self.session.delegate = self;
    [self.session setDataReceiveHandler:self withContext:nil];

    picker.delegate = nil;
    [picker dismiss];
    [picker autorelease];
	
	self.bluetooth.selected = YES;
	[self startBlinking];
}

- (void)peerPickerControllerDidCancel:(GKPeerPickerController *)aPicker {
    picker.delegate = nil;
    [picker autorelease];
	
	self.peerId = nil;
	self.session = nil;
	self.bluetooth.selected = NO;
	[self stopBlinking];
}

- (void)session:(GKSession *)aSession peer:(NSString *)peerID didChangeState:(GKPeerConnectionState)state { 
	if(state == GKPeerStateDisconnected) {
		NSString *message = [NSString stringWithFormat:@"Could not reconnect with %@.", [self.session displayNameForPeer:peerID]];
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Lost Connection" message:message delegate:self cancelButtonTitle:@"End Game" otherButtonTitles:nil];
		[alert show];
		[alert release];
		
		self.peerId = nil;
		self.session = nil;
		self.bluetooth.selected = NO;
		[self stopBlinking];
	}
}

- (void)receiveData:(NSData *)data fromPeer:(NSString *)peer inSession:(GKSession *)aSession context:(void *)context {
	self.play.enabled = NO;
	
	NSNumber *duration = [NSKeyedUnarchiver unarchiveObjectWithData:data];
	
	[self performSelector:@selector(playWithDuration:) withObject:duration afterDelay:[duration floatValue]];
}

#pragma mark -
#pragma mark Sounds

- (void)playWithDuration:(NSNumber *)duration {
	[self playSound];
	[self moveMouthWithDuration:[duration floatValue]];
}

- (void)playSound {
	NSString *urlAddress = [[NSBundle mainBundle] pathForResource:[SoundController instance].randomSound ofType:@"3gp"];
	NSURL *url = [NSURL fileURLWithPath:urlAddress];
	player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];	
	player.numberOfLoops = 0;
	player.delegate = self;
	[player play];
	
	self.play.enabled = NO;
}

#pragma mark -
#pragma mark Audio

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
	self.play.enabled = YES;
}

#pragma mark -
#pragma mark Animations

- (void)startBlinking {
	CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
	[animation setDuration:1.0];
	[animation setDelegate:self];
	[animation setToValue:[NSNumber numberWithFloat:0.3]];
	[animation setRepeatCount:HUGE_VALF];
	[animation setAutoreverses:YES];
	
	[self.bluetooth.layer addAnimation:animation forKey:nil];
}

- (void)stopBlinking {
	[self.bluetooth.layer removeAllAnimations];
}

- (void)moveMouthWithDuration:(float)duration {
	float interval = 0.15;
	
	CABasicAnimation *animation;
    animation = [CABasicAnimation animationWithKeyPath:@"transform.translation"];
    animation.duration = interval;
    animation.repeatCount = (int)(duration / (interval * 2));
    animation.autoreverses = YES;
	animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(0, 0)];
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(3, 20)];
	
    [self.mounth.layer addAnimation:animation forKey:@"mouthMovement"];
}

- (void)stopMouthMovement {
	[self.mounth.layer removeAllAnimations];
}

#pragma mark -
#pragma mark Memory

- (void)dealloc {
	mounth = nil;
	[picker release], picker = nil;
	
    [super dealloc];
}

@end
