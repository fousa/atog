//
//  AtogViewController.h
//  Atog
//
//  Created by Jelle Vandebeeck on 07/03/11.
//  Copyright 2011 10to1. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import <GameKit/GameKit.h>

@interface AtogViewController : UIViewController <GKPeerPickerControllerDelegate, GKSessionDelegate, AVAudioPlayerDelegate>

@property (nonatomic, retain) IBOutlet UIImageView *mounth;
@property (nonatomic, retain) IBOutlet UIButton *bluetooth;
@property (nonatomic, retain) IBOutlet UIButton *play;

- (IBAction)playRandomQuote:(id)sender;
- (IBAction)connect:(id)sender;

@end

