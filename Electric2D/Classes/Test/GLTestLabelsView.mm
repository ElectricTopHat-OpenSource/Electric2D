//
//  GLTestLabels.mm
//  Electric2D
//
//  Created by robert on 28/04/2009.
//  Copyright 2009 Electric TopHat. All rights reserved.
//

#import "GLTestLabelsView.h"
#include "GLEngine.h"
#include "GLLabel.h"

@interface GLTestLabelsView (PrivateMethods)

- (void) initialisation;

- (void) createTest;

@end

@implementation GLTestLabelsView

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
	for ( int i=0; i<labelsCount; i++ )
	{
		glEngine->remove( labels[i] );
				
		delete(labels[i]);
	}
	
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
	NSInteger across = labelsAcross;
	NSInteger down = labelsDown;
	
	NSInteger width = 320 / across;
	NSInteger height = 480 / down;
	
	NSInteger x = width * 0.5f;
	NSInteger y = height * 0.5f;
	NSInteger counter = 0;
	for ( int i=0; i<down; i++ )
	{
		for ( int j=0; j<across; j++ )
		{
			GLLabel * label = new  GLLabel( @"test", false, CGSizeMake(160, 24), UITextAlignmentCenter, 20 );
						
			label->setCenter( x, y );
			label->setSize( width, height );
			
			labels[counter] = label;
			counter++;
			
			glEngine->add( label );
			
			x += width;
		}
		x = width * 0.5f;
		y += height;
	}
}

// ------------------------------------------
// Update functions
// ------------------------------------------
- (void) update
{
	static Boolean textState = TRUE;
	textState = !textState;
	
	NSString * text = (textState) ? @"test" : @"other";
	labels[0]->setText( text );
	
	for ( int i=0; i<labelsCount; i++ )
	{
		labels[i]->setRotation( labels[i]->rotation() + 1 );
	}	
	
	
	
	// render
	[self draw];
}

@end
