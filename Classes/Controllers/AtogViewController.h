//
//  AtogViewController.h
//  Atog
//
//  Created by Jelle Vandebeeck on 07/03/11.
//  Copyright 2011 10to1. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import <GameKit/GameKit.h>

@interface AtogViewController : UIViewController <GKPeerPickerControllerDelegate, GKSessionDelegate, AVAudioPlayerDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, retain) IBOutlet UIImageView *face;
@property (nonatomic, retain) IBOutlet UIImageView *mounth;
@property (nonatomic, retain) IBOutlet UIButton *bluetooth;

- (IBAction)playRandomQuote:(id)sender;
- (IBAction)connect:(id)sender;

- (void)disconnect;

@end

