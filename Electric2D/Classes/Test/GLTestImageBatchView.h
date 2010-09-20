//
//  GLTestImageBatchView.h
//  Electric2D
//
//  Created by Robert on 01/06/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GLView.h"

class GLImageBatch;

@interface GLTestImageBatchView : GLView  
{
@private
	
	GLImageBatch * m_imageBatch;
	
	Boolean m_scaleup;
	Boolean m_batchscaleup;
}

- (void) update;

@end
