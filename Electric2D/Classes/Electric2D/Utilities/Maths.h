//
//  Maths.h
//  Electric2D
//
//  Created by robert on 27/05/2009.
//  Copyright 2009 Electric TopHat. All rights reserved.
//

#if !defined(__E2D_Maths_h__)
#define __E2D_Maths_h__

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

namespace Maths 
{
#pragma mark ---------------------------------------------------------
#pragma mark Math TypeDefs
#pragma mark ---------------------------------------------------------
	
	typedef CGPoint CGVector2D;
	
#pragma mark ---------------------------------------------------------
#pragma mark End Math TypeDefs
#pragma mark ---------------------------------------------------------
	
#pragma mark ---------------------------------------------------------
#pragma mark Math Constants
#pragma mark ---------------------------------------------------------

// -------------------------------------------------------------------

	const double PI		= M_PI;
	const double PI2	= M_PI_2;
	const double PI_SQR = 9.86960440108935861883449099987615114f;
	const double HalfPI = M_PI * 0.5f;

// -------------------------------------------------------------------

	const float EPSILON = 0.000001f;
	const float E = 2.71828183f;

// -------------------------------------------------------------------
	
	const double degreesToRadians = M_PI / 180.0f;
	const double radiansToDegrees = 180.0f / M_PI;

	const float _45_DegreesInRadians = 045.0f * degreesToRadians;
	const float _90_DegreesInRadians = 090.0f * degreesToRadians;
	const float _135_DegreesInRadians = 135.0f * degreesToRadians;
	const float _180_DegreesInRadians = 180.0f * degreesToRadians;
	const float _225_DegreesInRadians = 225.0f * degreesToRadians;
	const float _270_DegreesInRadians = 270.0f * degreesToRadians;
	const float _315_DegreesInRadians = 315.0f * degreesToRadians;
	const float _360_DegreesInRadians = 360.0f * degreesToRadians;

// -------------------------------------------------------------------

#pragma mark ---------------------------------------------------------
#pragma mark End Math Constants
#pragma mark ---------------------------------------------------------

#pragma mark ---------------------------------------------------------
#pragma mark Math Macros
#pragma mark ---------------------------------------------------------

	inline float Degrees2Radians( float _angle ) { return _angle * degreesToRadians; };
	inline float Radians2Degrees( float _angle ) { return _angle * radiansToDegrees; };

#pragma mark ---------------------------------------------------------
#pragma mark End Math Macros
#pragma mark ---------------------------------------------------------

#pragma mark ---------------------------------------------------------
#pragma mark Math Utilty Functions : NSInteger
#pragma mark ---------------------------------------------------------

	// --------------------------------------------------
	// Clamp a float between two values
	// --------------------------------------------------
	inline float nClamp( NSInteger _value, NSInteger _min, NSInteger _max )
	{
		return (_value > _min) ? (_value < _max ) ? _value : _max : _min;
	}

	// --------------------------------------------------
	// Loop the value
	// --------------------------------------------------
	inline NSInteger nLoop( NSInteger _value, NSInteger _min, NSInteger _max )
	{
		// TODO : Fix this function so that the value is looped correctly
		return (_value > _min) ? (_value < _max ) ? _value : _min : _max;
	}

#pragma mark ---------------------------------------------------------
#pragma mark End Math Utilty Functions : NSInteger
#pragma mark ---------------------------------------------------------
	
#pragma mark ---------------------------------------------------------
#pragma mark Math Utilty Functions : Float
#pragma mark ---------------------------------------------------------

	// --------------------------------------------------
	// Fast Sin Function
	// --------------------------------------------------
	inline float fastSin( float _rad )
	{
		//always wrap input angle to -PI..PI
		while (_rad < -3.14159265f)
		{
			_rad += 6.28318531f;
		}
		while (_rad >  3.14159265f)
		{
			_rad -= 6.28318531f;
		}
		
		float sinVal = 0.0f;
		
		//compute sine
		if (_rad < 0)
			sinVal = _rad*(1.27323954 + .405284735 * _rad);
		else
			sinVal = _rad*(1.27323954 - 0.405284735 * _rad);
		
		if (sinVal < 0)
			sinVal = sinVal*(-0.225f * (sinVal + 1) + 1);
		else
			sinVal = sinVal*(0.225f * (sinVal - 1) + 1);
		
		return sinVal;
	}
	
	// --------------------------------------------------
	// Fast Cos Function
	// --------------------------------------------------
	inline float fastCos( float _rad )
	{
		//compute cosine: sin(x + PI/2) = cos(x)
		_rad += 1.57079632f;
		while (_rad < -3.14159265f)
		{
			_rad += 6.28318531f;
		}
		while (_rad >  3.14159265f)
		{
			_rad -= 6.28318531f;
		}
		
		float cosVal;
		if (_rad < 0)
			cosVal = 1.27323954f * _rad + 0.405284735f * _rad * _rad;
		else
			cosVal = 1.27323954f * _rad - 0.405284735f * _rad * _rad;
		
		if (cosVal < 0)
			cosVal = 0.225f * (cosVal *-cosVal - cosVal) + cosVal;
		else
			cosVal = 0.225f * (cosVal * cosVal - cosVal) + cosVal;
		
		return cosVal;
	}
	
	// --------------------------------------------------
	// Clamp a float between two values
	// --------------------------------------------------
	inline float fClamp( float _value, float _min, float _max )
	{
		return (_value > _min) ? (_value < _max ) ? _value : _max : _min;
	}

	// --------------------------------------------------
	// Loop the value
	// --------------------------------------------------
	inline float fLoop( float _value, float _min, float _max )
	{
		// TODO : Fix this function so that the value is looped correctly
		return (_value > _min) ? (_value < _max ) ? _value : _min : _max;
	}

	// ---------------------------------------------------
	// Lerp function
	// ---------------------------------------------------
	inline float fLerp( float _start, float _end, float _value )
	{	
		return ((1.0f - _value) * _start) + (_value * _end);
	}

	// ---------------------------------------------------
	// Sin Lerp function
	// ---------------------------------------------------
	inline float fSinLerp( float _start, float _end, float _value )
	{
		float value = sin(_value * HalfPI);
		
		return fLerp(_start,_end,value);
	}

	// ---------------------------------------------------
	// Hermite function
	// ---------------------------------------------------
	inline float fHermite( float _start, float _end, float _value )
	{
		float value = _value * _value * (3.0f - 2.0f * _value);
		
		return fLerp(_start,_end,value);
	}


#pragma mark ---------------------------------------------------------
#pragma mark End Math Utilty Functions : Float
#pragma mark ---------------------------------------------------------

#pragma mark ---------------------------------------------------------
#pragma mark Math Utilty Functions : Vector
#pragma mark ---------------------------------------------------------

	// ---------------------------------------------------
	// Get the Length Squared of a vector
	// ---------------------------------------------------
	inline float VectorLengthSquared( float _x, float _y )
	{
		return (_x * _x) + (_y * _y);
	}

	// ---------------------------------------------------
	// Get the Length of a vector
	// ---------------------------------------------------
	inline float VectorLength( float _x, float _y )
	{
		return sqrt(VectorLengthSquared(_x, _y));
	}

#pragma mark ---------------------------------------------------------
#pragma mark End Math Utilty Functions : Vector
#pragma mark ---------------------------------------------------------

#pragma mark ---------------------------------------------------------
#pragma mark Math Utilty Functions : CGVector2D
#pragma mark ---------------------------------------------------------

	// ---------------------------------------------------
	// Make a CGVector2D
	// ---------------------------------------------------
	inline CGVector2D CGVector2DMake( float _x, float _y )
	{
		return CGPointMake(_x, _y);
	}

	// ---------------------------------------------------
	// Make a Rotated CGVector2D (radians)
	// ---------------------------------------------------
	inline CGVector2D CGVector2DMakeRotation( float _angle )
	{
		float cosTheta = cos(_angle);
		float sinTheta = sin(_angle);
		
		return CGPointMake(-sinTheta, cosTheta);
	}

	// ---------------------------------------------------
	// Rotate an existing CGVectro2D
	// ---------------------------------------------------
	inline CGVector2D CGVector2DRotate( float _x, float _y, float _angle)
	{
		// rotate a vector
		// x' = cos(theta)*x - sin(theta)*y 
		// y' = sin(theta)*x + cos(theta)*y
		
		float cosTheta = cos(_angle);
		float sinTheta = sin(_angle);
		
		float x = cosTheta*_x - sinTheta*_y;
		float y = sinTheta*_x + cosTheta*_y;
		
		return CGPointMake(x, y);		
	}
	
	// ---------------------------------------------------
	// Rotate an existing CGVectro2D
	// ---------------------------------------------------
	inline CGVector2D CGVector2DRotate( const CGVector2D & _vector, float _angle )
	{
		return CGVector2DRotate(_vector.x, _vector.y, _angle);
	}
	
	// ---------------------------------------------------
	// Scale an existing CGVectro2D
	// ---------------------------------------------------
	inline CGVector2D CGVector2DScale( const CGVector2D & _vector, float _scale )
	{
		return CGVector2DMake( _vector.x * _scale, _vector.y * _scale );
	}
	
	// ---------------------------------------------------
	// Add 2 CGVectro2D's
	// ---------------------------------------------------
	inline CGVector2D CGVector2DAdd( const CGVector2D & _vectorA, const CGVector2D & _vectorB )
	{
		return CGVector2DMake( _vectorA.x + _vectorB.x, _vectorA.y + _vectorB.y );
	}
	
	// ---------------------------------------------------
	// Sub 2 CGVectro2D's
	// ---------------------------------------------------
	inline CGVector2D CGVector2DSub( const CGVector2D & _vectorA, const CGVector2D & _vectorB )
	{
		return CGVector2DMake( _vectorA.x - _vectorB.x, _vectorA.y - _vectorB.y );
	}
	
	// ---------------------------------------------------
	// Multiply 2 CGVectro2D's
	// ---------------------------------------------------
	inline CGVector2D CGVector2DMult( const CGVector2D & _vectorA, const CGVector2D & _vectorB )
	{
		return CGVector2DMake( _vectorA.x * _vectorB.x, _vectorA.y * _vectorB.y );
	}
	
	// ---------------------------------------------------
	// Length Squared of a CGVector2D
	// ---------------------------------------------------
	inline float CGVector2DLengthSquared( const CGVector2D & _vector )
	{
		return (_vector.x * _vector.x) + (_vector.y * _vector.y);
	}

	// ---------------------------------------------------
	// Length of a CGVector2D 
	// ---------------------------------------------------
	inline float CGVector2DLength( const CGVector2D & _vector )
	{
		return sqrt(CGVector2DLengthSquared(_vector));
	}

	// ---------------------------------------------------
	// Normalise a 2D Vector
	// ---------------------------------------------------
	inline void CGVector2DNormalise( CGVector2D & _vector )
	{
		float lenSq = CGVector2DLengthSquared(_vector);
		if ( lenSq > EPSILON )
		{
			if ( lenSq != 1.0f ) // Maybe add a tollerance ??
			{
				float len = sqrt(lenSq);
				_vector.x /= len;
				_vector.y /= len;
			}
		}
		else
		{
			// Maybe add a log message
			
			_vector.x = 0.0f;
			_vector.y = 0.0f;
		}
	}

	// ---------------------------------------------------
	// DotProduct of two 2D Vectors
	// ---------------------------------------------------
	inline float CGVector2DDotProduct( const CGVector2D & _vectorA, const CGVector2D & _vectorB )
	{
		return (_vectorA.x * _vectorB.x) + (_vectorA.y * _vectorB.y);
	}

#pragma mark ---------------------------------------------------------
#pragma mark End Math Utilty Functions : CGPoint
#pragma mark ---------------------------------------------------------

};
	
#endif