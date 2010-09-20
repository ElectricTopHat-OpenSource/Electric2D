//
//  GLTestHierarchy.mm
//  Electric2D
//
//  Created by Robert on 05/07/2009.
//  Copyright 2009 Electric TopHat Ltd. All rights reserved.
//

#import "GLTestHierarchyView.h"
#import "GLEngine.h"
#import "GLTexture.h"
#import "GLImage.h"
#import "GLObjectHierarchy.h"
#import "Maths.h"

@interface GLTestHierarchyView (PrivateMethods)

- (void) initialisation;

- (void) createTest;

@end

@implementation GLTestHierarchyView

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
	glEngine->remove( m_hierarchy );
	
	for ( int i=0;i<m_hierarchy->count(); i++ )
	{
		GLImage * image = (GLImage*)m_hierarchy->get(i);
		glEngine->releaseTexture(image->texture());
		delete(image);
		image = nil;
	}
	
	delete(m_hierarchy);
	m_hierarchy = nil;
		
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
	GLImage * image0 = new GLImage(glEngine->createTexture(@"TestTarget"));
	GLImage * image1 = new GLImage(glEngine->createTexture(@"TestTarget"));
	GLImage * image2 = new GLImage(glEngine->createTexture(@"TestTarget"));
	GLImage * image3 = new GLImage(glEngine->createTexture(@"TestTarget"));
	GLImage * image4 = new GLImage(glEngine->createTexture(@"TestTarget"));
	
	image1->setCenter( 32.0f, 32.0f );
	image2->setCenter( -32.0f, -32.0f );
	image3->setCenter( 32.0f, -32.0f );
	image4->setCenter( -32.0f, 32.0f );
	
	m_hierarchy = new GLObjectHierarchy( CGPointMake( 160, 240 ), 1 );
	m_hierarchy->add( image0 );
	m_hierarchy->add( image1 );
	m_hierarchy->add( image2 );
	m_hierarchy->add( image3 );
	m_hierarchy->add( image4 );
	
	glEngine->add( m_hierarchy );
}

// ------------------------------------------
// Update functions
// ------------------------------------------
- (void) update
{	
	m_hierarchy->setRotation( m_hierarchy->rotation() + 1 );
	
	static NSInteger state = 0;
	if ( state )
	{
		float scale = m_hierarchy->scale().width + 0.01f;
		m_hierarchy->setScale( scale );
		if ( scale >= 1.0f )
		{
			state = 0;
		}
	}
	else
	{
		float scale = m_hierarchy->scale().width - 0.01f;
		m_hierarchy->setScale( scale );
		if ( scale < 0.1f )
		{
			state = 1;
		}
	}
	
	// render
	[self draw];
}

@end
