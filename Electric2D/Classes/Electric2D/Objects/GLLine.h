//
//  GLLine.h
//  Electric2D
//
//  Created by robert on 06/07/2009.
//  Copyright 2009 Electric TopHat. All rights reserved.
//

#if !defined(__GLLine_h__)
#define __GLLine_h__

#import <UIKit/UIKit.h>
#import <vector>
#import "GLObject.h"
#import "GLColor.h"

class GLLine : public GLObject
{
#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------
public: // Functions
	
	// --------------------------------------------------
	// Constructor
	// --------------------------------------------------
	GLLine( NSUInteger _capacity = 16 );
	
	// --------------------------------------------------
	// Destructor
	// --------------------------------------------------
	~GLLine();
	
#pragma mark ---------------------------------------------------------
#pragma mark End Constructor / Destructor
#pragma mark ---------------------------------------------------------
	
#pragma mark ---------------------------------------------------------
#pragma mark Public Functions
#pragma mark ---------------------------------------------------------
public:	// Functions
	
	inline NSUInteger capacity() { return m_points.capacity(); };
	inline NSUInteger count() { return m_points.size(); };
	
	inline void add( const CGPoint & _point ) { m_points.push_back(_point); }
	inline void add( float _x, float _y ) { m_points.push_back(CGPointMake(_x,_y)); };
	
	inline CGPoint & get( NSUInteger _index ) { return m_points[_index]; };
	inline void remove( NSUInteger _index ) { m_points.erase( m_points.begin()+_index ); };
	inline void clear() { m_points.clear(); };
	
	inline const CGPoint * data() const { return &m_points[0]; };
	
	inline float width() const { return m_width; };
	inline void setWidth( float _width ) { m_width = _width; };
		
	// access the image alpha value
	inline float alpha() const { return m_color.alpha(); };
	// set the image alpha value
	inline void setAlpha(float _alpha) { m_color.setAlpha(_alpha); };
	
	// access the color variable
	inline const GLColor & color() const { return m_color; };
	// set the color or the font
	inline void setColor(float _red, float _green, float _blue, float _alpha=1.0f) { m_color.setColor(_red,_green,_blue,_alpha); };
	inline void setColor(const GLColor & _color) { m_color.setColor(_color); };
	inline void setColor(const UIColor * _color) { m_color.setColor(_color); };	
	
	
#pragma mark ---------------------------------------------------------
#pragma mark End Public Functions
#pragma mark ---------------------------------------------------------
	
#pragma mark ---------------------------------------------------------
#pragma mark Private Data
#pragma mark ---------------------------------------------------------
private: // Data
	
	GLColor m_color;
	float	m_width;
	
	std::vector<CGPoint> m_points;
	
#pragma mark ---------------------------------------------------------
#pragma mark End Private Data
#pragma mark ---------------------------------------------------------	
};

#endif