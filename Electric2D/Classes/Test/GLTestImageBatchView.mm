//
//  GLTestImageBatchView.mm
//  Electric2D
//
//  Created by Robert on 01/06/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "GLTestImageBatchView.h"
#import "GLEngine.h"
#import "GLImageBatch.h"
#import "GLBackground.h"
#import "Maths.h"

@interface GLTestImageBatchView (PrivateMethods)

- (void) initialisation;

- (void) createTest;

@end


@implementation GLTestImageBatchView

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
	
	m_scaleup = false;
	m_batchscaleup = true;
}

// ------------------------------------------
// 
// ------------------------------------------
- (void)dealloc 
{
	glEngine->remove( m_imageBatch );
		
	glEngine->releaseTexture(m_imageBatch->texture());
		
	delete(m_imageBatch);
	
	//glEngine->releaseTexture( glEngine->background()->texture() );
	//glEngine->background()->clear();
	
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
	//glEngine->background()->setTexture( glEngine->createTexture( @"TestBackground" ) );
	
	NSInteger across = 20;
	NSInteger down = 20;
	NSInteger count = across * down;

	float width = 320.0f / (float)across;
	float height = 480.0f / (float)down;
	
	m_imageBatch = new GLImageBatch(glEngine->createTexture(@"TestImageStar"), count);
	m_imageBatch->addBatch(count);
	m_imageBatch->setPointsColor( 1.0f, 1.0f, 0.0f );
	m_imageBatch->setPointsSize( width, height );
	
	float x = (width * 0.5f);
	float y = (height * 0.5f);
	NSInteger counter = 0;
	for ( int i=0; i<down; i++ )
	{
		for ( int j=0; j<across; j++ )
		{
			m_imageBatch->getPoint( counter )->setCenter( x, y );
			counter++;
			x += width;
		}
		x = (width * 0.5f);
		y += height;
	}
	
	glEngine->add( m_imageBatch );
}

// ------------------------------------------
// Update functions
// ------------------------------------------
- (void) update
{
	m_imageBatch->setPointsRotation( m_imageBatch->pointsRotation() - 1 );
	
	float scale = m_imageBatch->pointsScale().width;
	if ( m_scaleup )
	{
		scale += 0.01f;
		if ( scale >= 2.0f )
		{
			m_scaleup = false;
		}
	}
	else
	{
		scale -= 0.01f;
		if ( scale <= 0.0f )
		{
			scale = 0.0f;
			m_scaleup = true;
		}
	}
	m_imageBatch->setPointsScale(scale);
	
	// render
	[self draw];
}
@end
