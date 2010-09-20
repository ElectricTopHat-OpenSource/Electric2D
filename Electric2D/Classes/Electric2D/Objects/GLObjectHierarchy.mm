//
//  GLObjectHierarchy.mm
//  Electric2D
//
//  Created by Robert on 05/07/2009.
//  Copyright 2009 Electric TopHat Ltd. All rights reserved.
//

#import "GLObjectHierarchy.h"

#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------

// --------------------------------------------------
// Constructor
// --------------------------------------------------
GLObjectHierarchy::GLObjectHierarchy( CGPoint _center, NSInteger _capacity )
: GLObject( eGLObjectHierarchy )
{
	m_center	= _center;
	m_rotation	= 0.0f;
	m_scale		= CGSizeMake(1.0f, 1.0f);
	m_objects.reserve(_capacity);
}

// --------------------------------------------------
// Destructor
// --------------------------------------------------
GLObjectHierarchy::~GLObjectHierarchy()
{
}

#pragma mark ---------------------------------------------------------
#pragma mark End Constructor / Destructor
#pragma mark ---------------------------------------------------------

// --------------------------------------------------
// add an object to the hierarchy
// --------------------------------------------------
void GLObjectHierarchy::add( GLObject * _obj )
{ 
	m_objects.push_back(_obj); 
}

// --------------------------------------------------
// insert an object into the hierarchy
// --------------------------------------------------
void GLObjectHierarchy::insert( GLObject * _obj, NSUInteger _index )	
{ 
	m_objects.insert(m_objects.begin()+_index, _obj); 
}

// --------------------------------------------------
// remove an object from the hierarchy
// --------------------------------------------------
void GLObjectHierarchy::remove( GLObject * _obj )						
{ 
	m_objects.erase(std::remove(m_objects.begin(), m_objects.end(), _obj), m_objects.end()); 
}