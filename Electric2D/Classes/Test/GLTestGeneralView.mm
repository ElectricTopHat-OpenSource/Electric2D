//
//  GLTestView.m
//  Electric2D
//
//  Created by robert on 21/04/2009.
//  Copyright 2009 Electric TopHat. All rights reserved.
//

#import "GLTestGeneralView.h"
#include "GLEngine.h"
#include "GLImage.h"
#include "GLSprite.h"
#include "GLLabel.h"
#include "GLLine.h"

@interface GLTestGeneralView (PrivateMethods)

- (void) initialisation;

- (void) createTestImages;
- (void) createTestSprites;
- (void) createTestText;
- (void) createTextCompression;

@end


@implementation GLTestGeneralView

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
	[self createTestImages];	
	// sprite tests
	[self createTestSprites];
	// label tests
	[self createTestText];
	// compressed textures
	[self createTextCompression];

}

// ------------------------------------------
// dealloc
// ------------------------------------------
- (void)dealloc 
{	
	// ------------------------
	// test images
	// ------------------------
	glEngine->remove( imageTestNonAlpha );
	glEngine->remove( imageTestAlpha );
	glEngine->remove( imageTestInvalid );
	glEngine->remove( imageTestOtherImage );
	glEngine->remove( imageTestPVR );
	
	glEngine->releaseTexture(imageTestNonAlpha->texture());
	glEngine->releaseTexture(imageTestAlpha->texture());
	glEngine->releaseTexture(imageTestInvalid->texture());
	glEngine->releaseTexture(imageTestOtherImage->texture());
	glEngine->releaseTexture(imageTestPVR->texture());
	
	delete(imageTestNonAlpha);
	delete(imageTestAlpha);
	delete(imageTestInvalid);
	delete(imageTestOtherImage);
	delete(imageTestPVR);
	// ------------------------
	
	// ------------------------
	// test sprites
	// ------------------------
	glEngine->remove( spriteTestEvenSpaceing );
	glEngine->remove( spriteTestOddSpaceing );
	glEngine->remove( spriteTestOddInvalid );
	glEngine->remove( spriteTestArray );
	glEngine->remove( spriteTestPVR );
	
	glEngine->releaseTexture(spriteTestEvenSpaceing->texture());
	glEngine->releaseTexture(spriteTestOddSpaceing->texture());
	glEngine->releaseTexture(spriteTestOddInvalid->texture());
	glEngine->releaseTexture(spriteTestArray->texture());
	glEngine->releaseTexture(spriteTestPVR->texture());
	
	delete(spriteTestEvenSpaceing);
	delete(spriteTestOddSpaceing);
	delete(spriteTestOddInvalid);
	delete(spriteTestArray);
	delete(spriteTestPVR);
	// ------------------------
	
	// ------------------------
	// test Labels
	// ------------------------
	glEngine->remove(labelTest);
	glEngine->remove(labelTestSize);
	glEngine->remove(lableTestText);
	glEngine->remove(lableTestTextWithShadow);
	
	delete(labelTest);
	delete(labelTestSize);
	delete(lableTestText);
	delete(lableTestTextWithShadow);
	
	glEngine->remove(lineTest);
	delete(lineTest);
	// ------------------------
	
	// ------------------------
	// Compressed Images
	// ------------------------
	glEngine->remove( compressionTestPVR_Linear_2 );
	glEngine->remove( compressionTestPVR_Linear_4 );
	glEngine->remove( compressionTestPVR_Linear_m_2 );
	glEngine->remove( compressionTestPVR_Linear_m_4 );
	glEngine->remove( compressionTestPVR_Perceptual_2 );
	glEngine->remove( compressionTestPVR_Perceptual_4 );
	glEngine->remove( compressionTestPVR_Perceptual_m_2 );
	glEngine->remove( compressionTestPVR_Perceptual_m_4 );
	
	glEngine->releaseTexture(compressionTestPVR_Linear_2->texture());
	glEngine->releaseTexture(compressionTestPVR_Linear_4->texture());
	glEngine->releaseTexture(compressionTestPVR_Linear_m_2->texture());
	glEngine->releaseTexture(compressionTestPVR_Linear_m_4->texture());
	glEngine->releaseTexture(compressionTestPVR_Perceptual_2->texture());
	glEngine->releaseTexture(compressionTestPVR_Perceptual_4->texture());
	glEngine->releaseTexture(compressionTestPVR_Perceptual_m_2->texture());
	glEngine->releaseTexture(compressionTestPVR_Perceptual_m_4->texture());
	
	delete(compressionTestPVR_Linear_2);
	delete(compressionTestPVR_Linear_4);
	delete(compressionTestPVR_Linear_m_2);
	delete(compressionTestPVR_Linear_m_4);
	delete(compressionTestPVR_Perceptual_2);
	delete(compressionTestPVR_Perceptual_4);
	delete(compressionTestPVR_Perceptual_m_2);
	delete(compressionTestPVR_Perceptual_m_4);
	// ------------------------
	
    [super dealloc];
}

#pragma mark ---------------------------------------------------------
#pragma mark === End Constructor / Destructor Functions  ===
#pragma mark ---------------------------------------------------------

// ------------------------------------------
// create Test Image Objects
// ------------------------------------------
- (void) createTestImages
{
	imageTestNonAlpha = new GLImage(glEngine->createTexture(@"TestImageNoAlpha"));
	imageTestAlpha = new GLImage(glEngine->createTexture(@"TestImageAlpha"));
	imageTestInvalid = new GLImage(glEngine->createTexture(@"TestImageInvalid"));
	imageTestOtherImage = new GLImage(glEngine->createTexture(@"EasyEnemy"));
	imageTestPVR = new GLImage(glEngine->createTexture(@"TestImagePVR"));
	
	float y = glEngine->height() -  80.0f;
	CGPoint point = CGPointMake( 0.0f, y );
	
	point.x = imageTestNonAlpha->size().width * 0.5f;
	imageTestNonAlpha->setCenter( point );
	imageTestNonAlpha->setRotation( 45.0f );
	
	point.x += imageTestAlpha->size().width;
	imageTestAlpha->setCenter( point );
	
	imageTestInvalid->setSize( 64, 64 );
	point.x += imageTestInvalid->size().width;
	imageTestInvalid->setCenter( point );
	
	point.x += imageTestOtherImage->size().width;
	imageTestOtherImage->setCenter( point );
	
	point.x += imageTestPVR->size().width;
	imageTestPVR->setCenter( point );
	
	glEngine->add( imageTestNonAlpha );
	glEngine->add( imageTestAlpha );
	glEngine->add( imageTestInvalid );
	glEngine->add( imageTestOtherImage );
	glEngine->add( imageTestPVR );
}

// ------------------------------------------
// create Test Sprite Objects
// ------------------------------------------
- (void) createTestSprites
{
	spriteTestEvenSpaceing = new GLSprite(glEngine->createTextureSprite(@"TestSprite_4x4_64"));
	spriteTestOddSpaceing = new GLSprite(glEngine->createTextureSprite(@"TestSprite_4x4_64"));
	spriteTestOddInvalid = new GLSprite(glEngine->createTextureSprite(@"TestSpriteInvalid"));
	spriteTestArray = new GLSprite(glEngine->createTextureSprite(@"EasyEnemy_4x4_32_Array"));
	spriteTestPVR = new GLSprite(glEngine->createTextureSprite(@"EasyEnemyPVR_4x4_32"));
	
	float y = glEngine->height() -  160.0f;
	CGPoint point = CGPointMake( 0.0f, y );
	
	spriteTestEvenSpaceing->setSize( CGSizeMake(32.0f, 32.0f) );
	point.x += spriteTestEvenSpaceing->size().width + 10;
	spriteTestEvenSpaceing->setCenter( point );
	
	point.x += spriteTestOddSpaceing->size().width + 10;
	spriteTestOddSpaceing->setCenter( point );
	
	spriteTestOddInvalid->setSize( 32.0f, 32.0f );
	point.x += spriteTestOddInvalid->size().width + 10;
	spriteTestOddInvalid->setCenter( point );
	
	point.x += spriteTestArray->size().width + 10;
	spriteTestArray->setCenter( point );
	
	point.x += spriteTestPVR->size().width + 10;
	spriteTestPVR->setCenter( point );	
	
	glEngine->add( spriteTestEvenSpaceing );
	glEngine->add( spriteTestOddSpaceing );
	glEngine->add( spriteTestOddInvalid );
	glEngine->add( spriteTestArray );
	glEngine->add( spriteTestPVR );
}

// ------------------------------------------
// create Test Text Objects
// ------------------------------------------
- (void) createTestText
{
	labelTestSize = new GLLabel(@"Level : 0");
	lableTestText = new GLLabel(@"Label");
	lableTestTextWithShadow = new GLLabel(@"Label");
	labelTest = new  GLLabel( @"test", false, CGSizeMake(160, 24), UITextAlignmentCenter, 20 );
	
	float y = glEngine->height() -  240.0f;
	CGPoint point = CGPointMake( 0.0f, y );
	
	point.x += lableTestText->size().width + 10;
	lableTestText->setCenter( point );
	lableTestText->setText( @"Normal Label" );
	
	point.x += lableTestTextWithShadow->size().width + 10;
	lableTestTextWithShadow->setCenter( point );
	lableTestTextWithShadow->setText( @"Shadow Label" );
	lableTestTextWithShadow->setShadow( true );
	lableTestTextWithShadow->setShadowOffset( 2, 2 );
	lableTestTextWithShadow->setShadowColor( 1.0f, 0.0f, 0.0f );
	
	point.x += 64 + 10;
	labelTestSize->setCenter( point );
	labelTestSize->setFontName( @"Marker Felt" );
	labelTestSize->setText( @"Level : 00" );
	labelTestSize->setAlignment( UITextAlignmentLeft );
	labelTestSize->setFontSize( 20 );
	labelTestSize->setSize( 128, 128 );
	
	point.y += 124;
	labelTest->setCenter( point );
	
	glEngine->add(labelTest);
	glEngine->add(labelTestSize);
	glEngine->add(lableTestText);
	glEngine->add(lableTestTextWithShadow);
	
	lineTest = new GLLine();

	point = labelTestSize->rect().origin;
	lineTest->add(point);
	lineTest->add(CGPointMake( point.x, point.y + 128 ));
	lineTest->add(CGPointMake( point.x + 128, point.y + 128 ));
	lineTest->add(CGPointMake( point.x + 128, point.y ));
	lineTest->add(CGPointMake( point.x, point.y ));
	
	glEngine->add(lineTest);
}

// ------------------------------------------
// Increment the sprite frame
// ------------------------------------------
-(void) createTextCompression
{
	compressionTestPVR_Linear_2			= new GLImage(glEngine->createTexture(@"PVR_Linear_2"));
	compressionTestPVR_Linear_4			= new GLImage(glEngine->createTexture(@"PVR_Linear_4"));
	compressionTestPVR_Linear_m_2		= new GLImage(glEngine->createTexture(@"PVR_Linear_m_2"));
	compressionTestPVR_Linear_m_4		= new GLImage(glEngine->createTexture(@"PVR_Linear_m_4"));
	compressionTestPVR_Perceptual_2		= new GLImage(glEngine->createTexture(@"PVR_Perceptual_2"));
	compressionTestPVR_Perceptual_4		= new GLImage(glEngine->createTexture(@"PVR_Perceptual_4"));
	compressionTestPVR_Perceptual_m_2	= new GLImage(glEngine->createTexture(@"PVR_Perceptual_m_2"));
	compressionTestPVR_Perceptual_m_4	= new GLImage(glEngine->createTexture(@"PVR_Perceptual_m_4"));
	
	float y = glEngine->height() -  300.0f;
	CGPoint point = CGPointMake( 0.0f, y );
	
	point.x = compressionTestPVR_Linear_2->size().width * 0.5f;
	compressionTestPVR_Linear_2->setCenter( point );
	point.x += compressionTestPVR_Linear_4->size().width;
	compressionTestPVR_Linear_4->setCenter( point );
	point.x += compressionTestPVR_Linear_m_2->size().width;
	compressionTestPVR_Linear_m_2->setCenter( point );
	point.x += compressionTestPVR_Linear_m_4->size().width;
	compressionTestPVR_Linear_m_4->setCenter( point );

	point.y -= compressionTestPVR_Linear_2->size().height + 10.0f;
	point.x = compressionTestPVR_Linear_2->size().width * 0.5f;
	compressionTestPVR_Perceptual_2->setCenter( point );
	point.x += compressionTestPVR_Linear_4->size().width;
	compressionTestPVR_Perceptual_4->setCenter( point );
	point.x += compressionTestPVR_Linear_m_2->size().width;
	compressionTestPVR_Perceptual_m_2->setCenter( point );
	point.x += compressionTestPVR_Linear_m_4->size().width;
	compressionTestPVR_Perceptual_m_4->setCenter( point );
	
	glEngine->add( compressionTestPVR_Linear_2 );
	glEngine->add( compressionTestPVR_Linear_4 );
	glEngine->add( compressionTestPVR_Linear_m_2 );
	glEngine->add( compressionTestPVR_Linear_m_4 );
	glEngine->add( compressionTestPVR_Perceptual_2 );
	glEngine->add( compressionTestPVR_Perceptual_4 );
	glEngine->add( compressionTestPVR_Perceptual_m_2 );
	glEngine->add( compressionTestPVR_Perceptual_m_4 );
}

// ------------------------------------------
// Increment the sprite frame
// ------------------------------------------
- (void) incrementFrame:(GLSprite*)_sprite
{
	NSInteger frame = _sprite->frame();
	frame++;
	if ( frame >= _sprite->frameCount() )
	{
		frame = 0;
	}
	_sprite->setFrame(frame);
}

// ------------------------------------------
// Update functions
// ------------------------------------------
- (void) update
{
	// GLImage
	imageTestNonAlpha->setRotation( imageTestNonAlpha->rotation() + 0.5f );
	imageTestAlpha->setRotation( imageTestNonAlpha->rotation() - 0.7f );
	imageTestInvalid->setRotation( imageTestNonAlpha->rotation() + 0.1f );
	
	// GLSprite
	spriteTestEvenSpaceing->setRotation( spriteTestEvenSpaceing->rotation() + 0.01f );
	spriteTestOddSpaceing->setRotation( spriteTestEvenSpaceing->rotation() + 0.02f );
	spriteTestEvenSpaceing->setRotation( spriteTestOddInvalid->rotation() + 0.01f );
	
	[self incrementFrame:spriteTestEvenSpaceing];
	[self incrementFrame:spriteTestOddSpaceing];
	[self incrementFrame:spriteTestEvenSpaceing];
	
	static NSTimeInterval time = [NSDate timeIntervalSinceReferenceDate];
	if ( [NSDate timeIntervalSinceReferenceDate] - time > 0.1f )
	{
		time = [NSDate timeIntervalSinceReferenceDate];
		[self incrementFrame:spriteTestArray];
	}
	
	lableTestText->setRotation( lableTestText->rotation() - 0.1f );
	
	labelTest->setText( @"test" );
	
	// render
	[self draw];
}

@end
