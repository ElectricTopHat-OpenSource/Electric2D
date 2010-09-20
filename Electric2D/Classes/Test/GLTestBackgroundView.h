//
//  GLTestBackgroundView.h
//  Electric2D
//
//  Created by Robert on 29/05/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GLView.h"

class GLTexture;
class GLImage;

@interface GLTestBackgroundView : GLView  
{
@private
	
	const GLTexture * m_background;
		
	GLImage * m_image;
	
}

- (void) update;

@end
