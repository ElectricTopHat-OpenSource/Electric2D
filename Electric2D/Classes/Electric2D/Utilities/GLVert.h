//
//  GLVert.h
//  Electric2D
//
//  Created by Robert on 15/10/2009.
//  Copyright 2009 Electric TopHat Ltd. All rights reserved.
//

// -------------------------------
// Vert Structure
// -------------------------------
typedef struct 
{
	float x;
	float y;
	float uvx;
	float uvy;
		
} GLVert;

inline GLVert
GLVertMake(float x, float y, float uvx, float uvy)
{
	GLVert vert = { x, y, uvx, uvy };
	return vert;
}