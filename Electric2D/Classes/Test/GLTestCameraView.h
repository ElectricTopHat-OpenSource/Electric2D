//
//  GLTestCamera.h
//  Electric2D
//
//  Created by Robert on 25/06/2009.
//  Copyright 2009 Electric TopHat Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GLView.h"

class GLTexture;
class GLImage;
class GLLabel;

@interface GLTestCameraView : GLView  
{
@private
		
	GLImage * m_image;
	GLImage * m_imageCamera;

	GLImage * m_imageScreenPoint;
	GLLabel * m_label;
}

- (void) update;

@end
