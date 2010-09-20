//
//  GLTestSpriteBatchView.h
//  Electric2D
//
//  Created by robert on 02/06/2009.
//  Copyright 2009 Electric TopHat. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GLView.h"

class GLSpriteBatch;

@interface GLTestSpriteBatchView : GLView  
{
@private
	
	GLSpriteBatch * m_spriteBatch;
	
	Boolean m_scaleup;
	Boolean m_batchscaleup;
}

- (void) update;

@end
