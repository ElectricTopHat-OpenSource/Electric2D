//
//  GLTestHierarchy.h
//  Electric2D
//
//  Created by Robert on 05/07/2009.
//  Copyright 2009 Electric TopHat Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GLView.h"
	
class GLObjectHierarchy;

@interface GLTestHierarchyView : GLView  
{
@private
		
	GLObjectHierarchy * m_hierarchy;
}
	
- (void) update;
	
@end
