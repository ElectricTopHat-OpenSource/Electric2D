//
//  GLTestSprites.h
//  Electric2D
//
//  Created by robert on 28/04/2009.
//  Copyright 2009 Electric TopHat. All rights reserved.
//

#import <UIKit/UIKit.h>

#include <vector>
#import "GLView.h"

const NSUInteger spritesAcross = 10;
const NSUInteger spritesDown   = 20;
const NSUInteger spritesCount  = spritesAcross * spritesDown;

class GLSprite;

@interface GLTestSpritesView : GLView
{
@private
		
	GLSprite* images[spritesCount];
}
	
- (void) update;
	
@end
