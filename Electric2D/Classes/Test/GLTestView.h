//
//  GLTestView.h
//  Electric2D
//
//  Created by robert on 21/04/2009.
//  Copyright 2009 Electric TopHat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <vector>
#import "GLView.h"

class GLImage;
class GLSprite;
class GLLabel;

@interface GLTestView : GLView 
{
@private
	
	NSTimer*   updateTimer;
	
	// stl vector containing test images
	std::vector<GLImage*>  testImages;
	
	std::vector<GLSprite*> testSprites;
	
	GLLabel * testLabel;
}

@end
