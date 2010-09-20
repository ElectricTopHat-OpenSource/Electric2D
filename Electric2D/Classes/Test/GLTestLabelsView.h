//
//  GLTestLabels.h
//  Electric2D
//
//  Created by robert on 28/04/2009.
//  Copyright 2009 Electric TopHat. All rights reserved.
//

#import <UIKit/UIKit.h>

#include <vector>
#import "GLView.h"

const NSUInteger labelsAcross = 10;
const NSUInteger labelsDown   = 20;
const NSUInteger labelsCount  = labelsAcross * labelsDown;

class GLLabel;

@interface GLTestLabelsView : GLView
{
@private
	
	GLLabel* labels[labelsCount];
}

- (void) update;

@end
