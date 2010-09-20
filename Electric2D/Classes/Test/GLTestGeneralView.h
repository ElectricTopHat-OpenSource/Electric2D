//
//  GLTestView.h
//  Electric2D
//
//  Created by robert on 21/04/2009.
//  Copyright 2009 Electric TopHat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GLView.h"

class GLImage;
class GLSprite;
class GLLabel;
class GLLine;

@interface GLTestGeneralView : GLView 
{
@private
	
	// ------------------------
	// test images
	// ------------------------
	GLImage * imageTestNonAlpha;
	GLImage * imageTestAlpha;
	GLImage * imageTestInvalid;
	GLImage * imageTestOtherImage;
	GLImage * imageTestPVR;
	// ------------------------
	
	// ------------------------
	// test sprites
	// ------------------------
	GLSprite * spriteTestEvenSpaceing;
	GLSprite * spriteTestOddSpaceing;
	GLSprite * spriteTestOddInvalid;
	GLSprite * spriteTestArray;
	GLSprite * spriteTestPVR;
	// ------------------------
	
	// ------------------------
	// test Labels
	// ------------------------
	GLLabel * labelTestSize;
	GLLabel * lableTestText;
	GLLabel * lableTestTextWithShadow;
	GLLabel * labelTest;
	// ------------------------
	
	// ------------------------
	// line tests
	// ------------------------
	GLLine * lineTest;
	// ------------------------
	
	// ------------------------
	// test compressed images
	// ------------------------
	GLImage * compressionTestPVR_Linear_2;
	GLImage * compressionTestPVR_Linear_4;
	GLImage * compressionTestPVR_Linear_m_2;
	GLImage * compressionTestPVR_Linear_m_4;
	GLImage * compressionTestPVR_Perceptual_2;
	GLImage * compressionTestPVR_Perceptual_4;
	GLImage * compressionTestPVR_Perceptual_m_2;
	GLImage * compressionTestPVR_Perceptual_m_4;
	// ------------------------
}

- (void) update;

@end
