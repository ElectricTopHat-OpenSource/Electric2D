//
//  GLView.m
//  ToccoRobo2-Prototype
//
//  Created by robert on 14/04/2009.
//  Copyright 2009 Electric TopHat. All rights reserved.
//

#import "GLView.h"
#import "GLEngine.h"

@interface GLView (PrivateMethods)

- (void) createGLEngine;

@end


@implementation GLView

@synthesize glEngine;

// ------------------------------------------
// You must implement this method
// ------------------------------------------
+ (Class)layerClass 
{
    return [CAEAGLLayer class];
}

#pragma mark ---------------------------------------------------------
#pragma mark === Constructor / Destructor Functions  ===
#pragma mark ---------------------------------------------------------

// ------------------------------------------
// intialisation via nib
// ------------------------------------------
- (id)initWithCoder:(NSCoder*)coder 
{
	if ((self = [super initWithCoder:coder])) 
	{
		// Initialization code
		[self createGLEngine];
	}
	return self;
}

// ------------------------------------------
// intialisation using the frame
// ------------------------------------------
- (id)initWithFrame:(CGRect)frame 
{
    if (self = [super initWithFrame:frame]) 
	{
        // Initialization code
		[self createGLEngine];
    }
    return self;
}

// ------------------------------------------
// Create the GL Engine
// ------------------------------------------
- (void) createGLEngine
{	
	glEngine = new GLEngine((CAEAGLLayer *)self.layer, [UIColor lightGrayColor]);
	
	// trigger the fps to be displayed
	glEngine->displayFps(true);
}

// ------------------------------------------
// dealloc
// ------------------------------------------
- (void)dealloc 
{	
	delete(glEngine);
	glEngine = nil;
	
    [super dealloc];
}

#pragma mark ---------------------------------------------------------
#pragma mark === End Constructor / Destructor Functions  ===
#pragma mark ---------------------------------------------------------

// ------------------------------------------
//
// ------------------------------------------
- (void)layoutSubviews 
{
    glEngine->rebindContext();
}

- (void) draw
{
	// render
	glEngine->render();
}

@end
