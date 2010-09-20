//
//  GLTestModelView.m
//  Electric2D
//
//  Created by Robert on 15/10/2009.
//  Copyright 2009 Electric TopHat Ltd. All rights reserved.
//

#import "GLTestModelView.h"
#import "GLEngine.h"
#import "GLModel.h"

@interface GLTestModelView (PrivateMethods)

- (void) initialisation;

- (void) createTest;

@end

@implementation GLTestModelView

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
		[self initialisation];
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
		[self initialisation];
    }
    return self;
}

// ------------------------------------------
// 
// ------------------------------------------
- (void) initialisation
{		
	// image tests
	[self createTest];	
}

// ------------------------------------------
// 
// ------------------------------------------
- (void)dealloc 
{
	// ------------------------
	// test images
	// ------------------------
	glEngine->remove( m_model );
	
	glEngine->releaseTexture(m_model->texture());
	
	delete(m_model);
	// ------------------------

    [super dealloc];
}

#pragma mark ---------------------------------------------------------
#pragma mark === End Constructor / Destructor Functions  ===
#pragma mark ---------------------------------------------------------

// ------------------------------------------
// create Test Objects
// ------------------------------------------
- (void) createTest
{	
	GLVert verts[6];
	
	CGPoint max = CGPointMake( 50, 50 );
	CGPoint min = CGPointMake( -50, -50 );
	float minUV[2] = { 0.0f, 0.0f };
	float maxUV[2] = { 1.0f, 1.0f };
		
	// build a square with two triangles
	verts[0] = GLVertMake( min.x, max.y, minUV[0], minUV[1]);
	verts[1] = GLVertMake( max.x, max.y, maxUV[0], minUV[1]);
	verts[2] = GLVertMake( min.x, min.y, minUV[0], maxUV[1]);
	verts[3] = GLVertMake( max.x, max.y, maxUV[0], minUV[1]);
	verts[4] = GLVertMake( min.x, min.y, minUV[0], maxUV[1]);
	verts[5] = GLVertMake( max.x, min.y, maxUV[0], maxUV[1]);
	
	CGPoint point = CGPointMake( 160.0f, 240.0f );
	
	m_model = new GLModel( verts, 6, glEngine->createTexture(@"TestImageNoAlpha"), point );
	
	glEngine->add( m_model );
}

// ------------------------------------------
// Update functions
// ------------------------------------------
- (void) update
{	
	m_model->setRotation( m_model->rotation() + 1.0f );
	
	// render
	[self draw];
}

@end
