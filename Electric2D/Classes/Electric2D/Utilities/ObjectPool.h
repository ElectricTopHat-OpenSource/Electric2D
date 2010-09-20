//
//  Pool.h
//  Electric2D
//
//  Created by Robert McDowell on 11/02/2010.
//  Copyright 2010 Electric TopHat Ltd.. All rights reserved.
//

#import <Foundation/Foundation.h>


template<class T> 
class ObjectPool
{ 
public:
	
	ObjectPool(int count) 
	{ 
		m_ObjectData = new T[count]; 
		m_ObjectFree = new T*[count]; 
		
		m_ObjectCount = count; 
		
		FreeAll(); 
	} 
	
	virtual ~ObjectPool(void) 
	{ 
		delete[] m_ObjectData; 
		delete[] m_ObjectFree; 
	} 

	T * NewInstance(void) 
	{ 
		if(m_Top>0)
		{ 
			return(m_ObjectFree[--m_Top]); 
		} 
		return nil; 
	}
	
	void FreeInstance(T * instance) 
	{ 
		if( (instance) && 
		    (m_Top < m_ObjectCount) && 
		    (instance>=&m_ObjectData[0]) && 
		    (instance<=&m_ObjectData[m_ObjectCount-1]))
		{ 
			m_ObjectFree[m_Top++] = instance; 
		} 
		return; 
	} 
	
private: 
	
	void FreeAll() 
	{ 
		int i = (m_ObjectCount-1); 
		
		for(m_Top=0;m_Top<m_ObjectCount;m_Top++)
		{ 
			m_ObjectFree[m_Top] = &m_ObjectData[i--]; 
		} 
		return; 
	} 
	
private: 
	T *		m_ObjectData; 
	T **	m_ObjectFree; 
	int		m_ObjectCount;
	int		m_Top; 
};
