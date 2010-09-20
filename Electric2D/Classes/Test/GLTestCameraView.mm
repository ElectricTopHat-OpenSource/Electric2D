//
//  GLTestCamera.mm
//  Electric2D
//
//  Created by Robert on 25/06/2009.
//  Copyright 2009 Electric TopHat Ltd. All rights reserved.
//

#import "GLTestCameraView.h"
#import "GLEngine.h"
#import "GLTexture.h"
#import "GLImage.h"
#import "GLLabel.h"
#import "GLCamera.h"
#import "Maths.h"

@interface GLTestCameraView (PrivateMethods)

- (void) initialisation;

- (void) createTest;
- (void) updateCamera;

@end

@implementation GLTestCameraView

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
	glEngine->camera()->setPosition(CGPointMake(-1000.0f, -1000.0f));
	
	// image tests
	[self createTest];	
}

// ------------------------------------------
// 
// ------------------------------------------
- (void)dealloc 
{
	glEngine->remove( m_image );
	glEngine->releaseTexture(m_image->texture());
	delete(m_image);
	m_image = nil;
	
	glEngine->remove( m_imageCamera );
	glEngine->releaseTexture(m_imageCamera->texture());
	delete(m_imageCamera);
	m_imageCamera = nil;
	
	glEngine->remove( m_imageScreenPoint );
	glEngine->releaseTexture(m_imageScreenPoint->texture());
	delete(m_imageScreenPoint);
	m_imageScreenPoint = nil;
	
	glEngine->remove(m_label);
	delete(m_label);
	m_label = nil;
	
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
	m_image = new GLImage(glEngine->createTexture(@"TestBackground"));
	m_image->setCenter( 0, 0 );
	m_image->setSize( 10000, 10000 );
	glEngine->add( m_image );
	
	m_imageCamera = new GLImage(glEngine->createTexture(@"TestTarget"));
	m_imageCamera->setCenter( glEngine->camera()->position() );
	m_imageCamera->setSize( 64, 64 );
	glEngine->add( m_imageCamera );

	m_imageScreenPoint = new GLImage(glEngine->createTexture(@"TestSpot"));
	m_imageScreenPoint->setCenter( 20.0f, 20.0f );
	m_imageScreenPoint->setSize( 10, 10 );
	glEngine->add( m_imageScreenPoint, eGLEngineLayerTypes_ui );
	
	m_label = new GLLabel(@"Label");
	m_label->setCenter( -100.0f, -100.0f );
	m_label->setFontSize( 8.0f );
	m_label->setSize( 128, 128 );
	glEngine->add(m_label);
	
	glEngine->setPixelToWorldScale(1.2f);
}

- (void) updateCamera
{
	static CGPoint lastPostion = glEngine->camera()->position();
	static NSInteger state = 0;
	static NSTimeInterval lastTime = [NSDate timeIntervalSinceReferenceDate]; 
	NSTimeInterval currentTime = [NSDate timeIntervalSinceReferenceDate];
	
	NSTimeInterval diff = currentTime - lastTime;
	NSTimeInterval max  = 30.0f;
	
	
	switch (state) 
	{
		case 0:
		{
			CGPoint target = CGPointMake( 1000.0f, 1000.0f );
			
			float lerpValue = diff / max;
			
			if ( lerpValue > 1.0f )
			{
				glEngine->camera()->setPosition(target);
				
				lastTime = currentTime; 
				lastPostion = target;
				state = 1;
			}
			else
			{
				CGPoint newPos = CGPointMake(Maths::fLerp( lastPostion.x, target.x, lerpValue ), Maths::fLerp( lastPostion.y, target.y, lerpValue ));
				glEngine->camera()->setPosition(newPos);
			}
			break;
		}
		case 1:
		{
			CGPoint target = CGPointMake( -1000.0f, -1000.0f );
			
			float lerpValue = diff / max;
			
			if ( lerpValue > 1.0f )
			{
				glEngine->camera()->setPosition(target);
				
				lastTime = currentTime; 
				lastPostion = target;
				state = 0;
			}
			else
			{
				CGPoint newPos = CGPointMake(Maths::fLerp( lastPostion.x, target.x, lerpValue ), Maths::fLerp( lastPostion.y, target.y, lerpValue ));
				glEngine->camera()->setPosition(newPos);
			}
			break;
		}
		default:
			break;
	}
}

// ------------------------------------------
// Update functions
// ------------------------------------------
- (void) update
{	
	[self updateCamera];

	m_imageCamera->setCenter( glEngine->camera()->position() );
	
	CGPoint viewPos = m_imageScreenPoint->center();
	CGPoint worldPos = glEngine->viewPointToWorldPoint(viewPos);
	m_label->setText( [NSString stringWithFormat:@"World Pos :\n%f,\n%f", worldPos.x, worldPos.y] );
	m_label->setCenter( CGPointMake( worldPos.x + 10.0f + (m_label->width() * 0.5f), worldPos.y + (m_label->height() * 0.5f) ) );
	//m_imageScreenPoint->setCenter(worldPos);
	
	// render
	[self draw];
}

@end
