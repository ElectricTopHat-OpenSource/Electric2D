//
//  GLTestSpriteBatchView.mm
//  Electric2D
//
//  Created by robert on 02/06/2009.
//  Copyright 2009 Electric TopHat. All rights reserved.
//

#import "GLTestSpriteBatchView.h"
#import "GLEngine.h"
#import "GLSpriteBatch.h"
#import "Maths.h"

@interface GLTestSpriteBatchView (PrivateMethods)

- (void) initialisation;

- (void) createTest;

@end


@implementation GLTestSpriteBatchView

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
	glEngine->remove( m_spriteBatch );
	
	glEngine->releaseTexture(m_spriteBatch->texture());
	
	delete(m_spriteBatch);
	
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
	NSInteger across = 10;
	NSInteger down = 20;
	NSInteger count = across * down;
	
	m_spriteBatch = new GLSpriteBatch(glEngine->createTextureSprite(@"TestSpriteSquare_4x4_32"), count);
	m_spriteBatch->addBatch(count);
	
	float width = 320 / across;
	float height = 480 / down;
	
	float x = (width * 0.5f);
	float y = (height * 0.5f);
	NSInteger counter = 0;
	for ( int i=0; i<down; i++ )
	{
		for ( int j=0; j<across; j++ )
		{
			m_spriteBatch->getPoint( counter )->setCenter( x, y );
			counter++;
			x += width;
		}
		x = (width * 0.5f);
		y += height;
	}
	
	glEngine->add( m_spriteBatch );
}

// ------------------------------------------
// Update functions
// ------------------------------------------
- (void) update
{
	m_spriteBatch->setPointsRotation( m_spriteBatch->pointsRotation() - 1 );
	
	float scale = m_spriteBatch->pointsScale().width;
	if ( m_scaleup )
	{
		scale += 0.01f;
		if ( scale >= 1.5f )
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
	m_spriteBatch->setPointsScale(scale);
	
	//m_spriteBatch->incrementFrame();
	
	NSUInteger frameCount = m_spriteBatch->frameCount();
	for ( int i=0; i<m_spriteBatch->count(); i++ )
	{
		NSUInteger newFrame = m_spriteBatch->getPoint( i )->frame() + 1;
		if ( newFrame >= frameCount )
		{
			newFrame = 0;
		}
		m_spriteBatch->getPoint( i )->setFrame(newFrame);
	}
	
	// render
	[self draw];
}
@end
