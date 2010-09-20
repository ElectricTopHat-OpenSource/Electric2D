//
//  GLTestModelView.h
//  Electric2D
//
//  Created by Robert on 15/10/2009.
//  Copyright 2009 Electric TopHat Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GLView.h"

class GLModel;

@interface GLTestModelView : GLView  
{
@private
	
	GLModel * m_model;
}

- (void) update;

@end