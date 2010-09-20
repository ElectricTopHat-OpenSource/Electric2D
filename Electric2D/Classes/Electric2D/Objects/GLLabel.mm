/*
 *  GLLabel.mm
 *  Electric2D
 *
 *  Created by robert on 20/04/2009.
 *  Copyright 2009 Electric TopHat. All rights reserved.
 *
 */

#include "GLLabel.h"

#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------

// --------------------------------------------------
// Constructor
// --------------------------------------------------
GLLabel::GLLabel( NSString * _text, Boolean _staticText, CGSize _size, UITextAlignment _alignment, float _fontSize, NSString * _fontName, CGPoint _center )
:GLObject ( eGLObjectLabel )
{
	m_text = _text;
	m_center = _center;
	m_alpha = 1.0f;
	m_rotation = 0.0f;
	m_size = _size;
	m_scale = CGSizeMake(1.0f, 1.0f);
	
	m_static = _staticText;
	m_dirty	= false;
	m_fontName = _fontName;
	m_fontSize = _fontSize;
	m_fontAlignment = _alignment;
	m_fontVerticalAlignment = UITextVerticalAlignmentMiddle;
	
	m_shadow = false;
	m_fontShadowOffSet = CGPointZero;
	
	m_bindID = 0;
	m_data   = nil;
	
	m_dirtySize = true;
	updateBuffers();
}

// --------------------------------------------------
// Destructor
// --------------------------------------------------
GLLabel::~GLLabel()
{
	releaseTexture();
	releaseBuffers();
}

#pragma mark ---------------------------------------------------------
#pragma mark End Constructor / Destructor
#pragma mark ---------------------------------------------------------

// --------------------------------------------------
// set the rect
// --------------------------------------------------
void GLLabel::setRect( CGRect _rect )
{
	m_dirtySize = true;
	
	m_scale	= CGSizeMake(1.0f, 1.0f);
	m_size	= _rect.size;
	
	m_center = _rect.origin;
	m_center.x += m_size.width * 0.5f;
	m_center.y += m_size.height * 0.5f;
}

#pragma mark ---------------------------------------------------------
#pragma mark Private Functions
#pragma mark ---------------------------------------------------------

// --------------------------------------------------
// update the buffer size
// --------------------------------------------------
void GLLabel::updateBuffers()
{
	if ( m_dirtySize )
	{
		m_dirty = false; // reset the flag
		m_dirtySize = false;
		
		releaseTexture();
		releaseBuffers();
		
		// set up the buffers for rendering
		m_fontFrameWidth = m_size.width;
		m_fontFrameHeight = m_size.height;
		
		//make the frames a power of 2
		m_fontTextureWidth	= nearestpower2(m_fontFrameWidth);
		m_fontTextureHeight	= nearestpower2(m_fontFrameHeight);
		
		if ( m_fontTextureWidth < m_fontFrameWidth )
		{
			m_fontTextureWidth	*= 2.0f;
		}
		
		if ( m_fontTextureHeight < m_fontFrameHeight )
		{
			m_fontTextureHeight	*= 2.0f;
		}
		
		createBuffers();
		
		renderStringToTexture();
		
		if ( m_static )
		{
			releaseBuffers();
		}
	}
}

// cause the text to be re-rendered if required
Boolean GLLabel::update()
{
	updateBuffers();
	
	if ( !m_static && m_dirty )
	{
		m_dirty = false; // reset the flag
		
		releaseTexture();
		renderStringToTexture();
		
		return true;
	}
	return false;
}

// find the nearestpower2
NSInteger GLLabel::nearestpower2(NSInteger v)
{
	int k;
	if (v == 0)
		return 1;
	for (k = sizeof(NSInteger) * 8 - 1; ((static_cast<NSInteger>(1U) << k) & v) == 0; k--);
	if (((static_cast<NSInteger>(1U) << (k - 1)) & v) == 0)
		return static_cast<NSInteger>(1U) << k;
	return static_cast<NSInteger>(1U) << (k + 1);
}

// render the string to the
// texture buffer.
void GLLabel::renderStringToTexture()
{
	if ( m_bindID == 0 )
	{		
		UIFont * font = [UIFont fontWithName:m_fontName size:m_fontSize];
		
		if ( font )
		{
			CGSize textSize = [m_text sizeWithFont:font];
			if ( textSize.width > m_fontFrameWidth )
			{
				NSInteger newFontSize	= m_fontSize * ( m_fontFrameWidth / textSize.width );
				font					= nil;
				font					= [UIFont fontWithName:m_fontName size:newFontSize];//[font fontWithSize:newFontSize];
				textSize				= [m_text sizeWithFont:font];
			}
			if ( textSize.height > m_fontFrameHeight )
			{
				NSInteger newFontSize	= m_fontSize * ( m_fontFrameHeight / textSize.height );
				font					= nil;
				font					= [UIFont fontWithName:m_fontName size:newFontSize];//[font fontWithSize:newFontSize];
				textSize				= [m_text sizeWithFont:font];
			}
			
			CGRect rect = CGRectMake(0, 0, m_fontFrameWidth, m_fontFrameHeight);		
		
			
			switch (m_fontVerticalAlignment) 
			{
				case UITextVerticalAlignmentMiddle:
					rect.origin.y = ( m_fontFrameHeight * 0.5f ) - ( textSize.height * 0.5f );
					break;
				case UITextVerticalAlignmentTop:
					rect.origin.y = 0;
					break;
				case UITextVerticalAlignmentBottom:
					rect.origin.y = m_fontFrameHeight - textSize.height;
					break;
				default:
					break;
			}
			
			memset(m_data, 0, m_fontTextureWidth * m_fontTextureHeight);
		
			// create the graphics context
			CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
			CGContextRef context = CGBitmapContextCreate(m_data, m_fontTextureWidth, m_fontTextureHeight, 8, m_fontTextureWidth, colorSpace, kCGImageAlphaNone);
			CGColorSpaceRelease(colorSpace);
		
			// setup the context for rendering
			CGContextSetGrayFillColor(context, 1.0, 1.0);
			CGContextTranslateCTM(context, 0.0, m_fontTextureHeight);
			CGContextScaleCTM(context, 1.0, -1.0); //NOTE: NSString draws in UIKit referential i.e. renders upside-down compared to CGBitmapContext referential
		
			// render the text into the context
			UIGraphicsPushContext(context);
				[m_text drawInRect:rect withFont:font lineBreakMode:UILineBreakModeClip alignment:m_fontAlignment];
			UIGraphicsPopContext();
		
			// release the context
			CGContextRelease(context);
		
			// Use OpenGL ES to generate a name for the texture.
			glGenTextures(1, &m_bindID);
		
			// Bind the texture name. 
			glBindTexture(GL_TEXTURE_2D, m_bindID);
		
			glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
		 
			// Speidfy a 2D texture image, provideing the a pointer to the image data in memory
			glTexImage2D(GL_TEXTURE_2D, 0, GL_ALPHA, m_fontTextureWidth, m_fontTextureHeight, 0, GL_ALPHA, GL_UNSIGNED_BYTE, m_data);
		}
	}
}

// release the gl texture
void GLLabel::releaseTexture()
{
	GLuint boundTexture[1] = { m_bindID };
	glDeleteTextures(1, boundTexture);
	
	m_bindID = 0;
}

void GLLabel::createBuffers()
{
	if ( m_data != nil )
	{
		releaseBuffers();
	}
	m_data = malloc(m_fontTextureHeight * m_fontTextureWidth);
}

void GLLabel::releaseBuffers()
{
	free(m_data);

	m_data = nil;
}

#pragma mark ---------------------------------------------------------
#pragma mark End Private Functions
#pragma mark ---------------------------------------------------------