//
//  GLView.h
//  ToccoRobo2-Prototype
//
//  Created by robert on 14/04/2009.
//  Copyright 2009 Electric TopHat. All rights reserved.
//

#import <UIKit/UIKit.h>

class GLEngine;

@interface GLView : UIView 
{
@protected
	GLEngine * glEngine;
}

@property (nonatomic,readonly) GLEngine * glEngine;

- (void) draw;

@end
