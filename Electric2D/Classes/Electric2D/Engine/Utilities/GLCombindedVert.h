//
//  GLCombindedVert.h
//  Electric2D
//
//  Created by Robert on 25/06/2009.
//  Copyright 2009 Electric TopHat Ltd. All rights reserved.
//

#if !defined(__GLCombindedVert_h__)
#define __GLCombindedVert_h__

// --------------------------------
// Internal Vert
// --------------------------------
typedef struct _GLInernalVert {
	float x;
	float y;
} GLInternalVert;
// --------------------------------

// --------------------------------
// Internal Color
// --------------------------------
typedef struct _GLInernalColor {
	unsigned char red;
	unsigned char green;
	unsigned char blue;
	unsigned char alpha;	
} GLInternalColor;
// --------------------------------

// --------------------------------
// Internal UV Cordinates
// --------------------------------
typedef struct _GLInernalUV {
	float x;
	float y;
} GLInternalUV;
// --------------------------------

// --------------------------------
// structure that is in the 
// desired format for the
// underlying render system
// --------------------------------
typedef struct _GLCombindedVert
{
	GLInternalVert	vert;
	GLInternalColor	color;
	GLInternalUV	uv;
} GLCombindedVert;
// --------------------------------

#endif