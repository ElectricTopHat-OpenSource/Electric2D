//
//  Electric2DViewController.h
//  Electric2D
//
//  Created by robert on 28/04/2009.
//  Copyright 2009 Electric TopHat. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Electric2DViewController : UIViewController 
{
@private

	NSTimer * updateTimer;
	UIView *  subView;
	
}

- (IBAction) actionShowGeneralView;
- (IBAction) actionShowImageView;
- (IBAction) actionShowImageBatchView;
- (IBAction) actionShowSpriteView;
- (IBAction) actionShowSpriteBatchView;
- (IBAction) actionShowTextView;
- (IBAction) actionShowBackgroundView;
- (IBAction) actionShowCameraView;
- (IBAction) actionShowHierarchy;
- (IBAction) actionShowLine;
- (IBAction) actionShowWorldScale;
- (IBAction) actionShowModel;

@end
