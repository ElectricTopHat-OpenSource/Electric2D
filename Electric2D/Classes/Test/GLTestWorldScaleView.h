//
//  GLTestWorldScaleView.h
//  Electric2D
//
//  Created by Robert on 07/07/2009.
//  Copyright 2009 Electric TopHat Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GLView.h"

class GLLine;

@interface GLTestWorldScaleView : GLView  
{
@private
	
	GLLine * m_line;
}

- (void) update;

@end
