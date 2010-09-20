/*
 *  GLObject.h
 *  Electric2D
 *
 *  Created by robert on 15/04/2009.
 *  Copyright 2009 Electric TopHat. All rights reserved.
 *
 */

#if !defined(__GLObject_h__)
#define __GLObject_h__

#import "GLObjectTypes.h"
#import "GLEngineLayerTypes.h"

// --------------------------------------
// GLObject is a pure virtual base class.
// --------------------------------------
class GLObject
{
#pragma mark ---------------------------------------------------------
	friend class GLRender;
#pragma mark ---------------------------------------------------------
	
#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------
public: // Functions
	
	// --------------------------------------------------
	// Constructor
	// --------------------------------------------------
	GLObject(eGLObjectTypes _objectType);
	
	// --------------------------------------------------
	// Destructor
	// --------------------------------------------------
	~GLObject();
	
#pragma mark ---------------------------------------------------------
#pragma mark End Constructor / Destructor
#pragma mark ---------------------------------------------------------
	
#pragma mark ---------------------------------------------------------
#pragma mark Public Functions
#pragma mark ---------------------------------------------------------
public:	// Functions
	
	// Object Type via an enumerator
	inline eGLObjectTypes type() const { return m_objectType; }
	// Engine Layer
	inline eGLEngineLayerTypes layer() const { return m_layerType; };
	
#pragma mark ---------------------------------------------------------
#pragma mark End Public Functions
#pragma mark ---------------------------------------------------------
	
#pragma mark ---------------------------------------------------------
#pragma mark Private Data
#pragma mark ---------------------------------------------------------
protected: // Data
	
	eGLObjectTypes		m_objectType;
	eGLEngineLayerTypes m_layerType;
	
#pragma mark ---------------------------------------------------------
#pragma mark End Private Data
#pragma mark ---------------------------------------------------------
};

#endif