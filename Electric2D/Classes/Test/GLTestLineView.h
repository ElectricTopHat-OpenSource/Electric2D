//
//  GLTestLineView.h
//  Electric2D
//
//  Created by robert on 06/07/2009.
//  Copyright 2009 Electric TopHat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GLView.h"

class GLLine;

@interface GLTestLineView : GLView  
{
@private
	
	GLLine * m_line;
}

- (void) update;

@end
