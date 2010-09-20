//
//  GLBackground.h
//  Electric2D
//
//  Created by Robert on 25/06/2009.
//  Copyright 2009 Electric TopHat Ltd. All rights reserved.
//

#if !defined(__GLBackground_h__)
#define __GLBackground_h__

#import <UIKit/UIKit.h>
#import "GLColor.h"

class GLTexture;

// Render background used instead of clear
class GLBackground 
{
#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------
public: // Functions
	
	// --------------------------------------------------
	// Constructor
	// --------------------------------------------------
	GLBackground();
	
	// --------------------------------------------------
	// Destructor
	// --------------------------------------------------
	~GLBackground();
	
#pragma mark ---------------------------------------------------------
#pragma mark End Constructor / Destructor
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark Public Functions
#pragma mark ---------------------------------------------------------
public:	// Functions

	// is it a valid background
	inline Boolean valid() const { return m_texture != nil; };
	
	Boolean setTexture( const GLTexture * _texture );
	void clear();
	
	inline const GLTexture * texture() const { return m_texture; };
	inline const GLColor & color() const { return m_backgroundColor; };
	
	inline void setColor(float _red, float _green, float _blue) { m_backgroundColor.setColor(_red,_green,_blue); };
	inline void setColor(const GLColor & _color) { m_backgroundColor.setColor(_color); };
	inline void setColor(const UIColor * _color) { m_backgroundColor.setColor(_color); };
	
#pragma mark ---------------------------------------------------------
#pragma mark End Public Functions
#pragma mark ---------------------------------------------------------
	
#pragma mark ---------------------------------------------------------
#pragma mark Private Functions
#pragma mark ---------------------------------------------------------
private: // Functions
	
#pragma mark ---------------------------------------------------------
#pragma mark End Private Functions
#pragma mark ---------------------------------------------------------
	
#pragma mark ---------------------------------------------------------
#pragma mark Private Data
#pragma mark ---------------------------------------------------------
private: // Data

	// ------------------------
	// background texture
	// ------------------------
	const GLTexture * m_texture;
	
	GLColor     m_backgroundColor;
	// ------------------------

#pragma mark ---------------------------------------------------------
#pragma mark End Private Data
#pragma mark ---------------------------------------------------------
};

#endif
