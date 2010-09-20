//
//  GLTestImages.h
//  Electric2D
//
//  Created by robert on 28/04/2009.
//  Copyright 2009 Electric TopHat. All rights reserved.
//

#import <UIKit/UIKit.h>
#include <vector>
#import "GLView.h"

const NSUInteger imagesAcross = 10;
const NSUInteger imagesDown   = 20;
const NSUInteger imagesCount  = imagesAcross * imagesDown;

class GLImage;

@interface GLTestImagesView : GLView 
{
@private

	GLImage* images[imagesCount];	
}

- (void) update;

@end
