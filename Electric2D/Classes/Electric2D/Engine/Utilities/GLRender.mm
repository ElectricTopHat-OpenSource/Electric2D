/*
 *  GLRender.mm
 *  Electric2D
 *
 *  Created by robert on 15/04/2009.
 *  Copyright 2009 Electric TopHat. All rights reserved.
 *
 */

#import <algorithm>

#import "GLRender.h"
#import "GLTextureBank.h"
#import "GLTexture.h"
#import "GLTextureSprite.h"

#import "GLObjectTypes.h"

#import "GLObject.h"
#import "GLObjectHierarchy.h"

#import "GLImage.h"
#import "GLSprite.h"
#import "GLModel.h"
#import "GLLabel.h"
#import "GLLine.h"

#import "GLImageBatch.h"
#import "GLSpriteBatch.h"

//const GLfloat coordinatesSquare[] = {  0.0f, 1.0f, 1.0f, 1.0f, 0.0f, 0.0f, 1.0f, 0.0f };	
//const GLfloat verticesSquare[] = { -0.5f, -0.5f, 0.5f, -0.5f, -0.5f, 0.5f, 0.5f, 0.5f };

#pragma mark ---------------------------------------------------------
#pragma mark === Constructor / Destructor Functions  ===
#pragma mark ---------------------------------------------------------

// --------------------------------------------------
// Constructor
// --------------------------------------------------
GLRender::GLRender()
{
	boundTexture = 0;
	
	m_fpsLabel = nil;
	
	m_worldScale = 1.0f;
	m_viewPort = CGRectMake(0, 0, 320, 480);
	m_camera.setPosition( frameWidth() * 0.5f, frameHeight() * 0.5f );
}

// --------------------------------------------------
// Destructor
// --------------------------------------------------
GLRender::~GLRender()
{		
}

#pragma mark ---------------------------------------------------------
#pragma mark === End Constructor / Destructor Functions  ===
#pragma mark ---------------------------------------------------------

#pragma mark ---------------------------------------------------------
#pragma mark === Public Utility Functions  ===
#pragma mark ---------------------------------------------------------

// --------------------------------------------------
// clean up the render objects.
// --------------------------------------------------
void GLRender::cleanup()
{
	// delete the fps label
	delete(m_fpsLabel);
	m_fpsLabel = nil;
	
	for ( int i=0; i<GLEngineLayerTypesMaxNormalLayers; i++ )
	{
		cleanupLayer(m_renderLayers[i]);
	}
	cleanupLayer(m_renderLayerUI);
	
	m_textures.clear();
}

// --------------------------------------------------
// Render state setup
// --------------------------------------------------
void GLRender::setup(float _frameWidth, float _frameHeight)
{
	m_width  = _frameWidth;
	m_height = _frameHeight;
	
	m_viewPort = CGRectMake(0, 0, pixelsToWorldScale(m_width), pixelsToWorldScale(m_height));
	m_camera.setPosition( frameWidth() * 0.5f, frameHeight() * 0.5f );
	
	//glEnable(GL_DEPTH_TEST);
	glDisable(GL_DEPTH_TEST);
	glDisable(GL_FOG);
	glDisable(GL_LIGHTING);
	glDisable(GL_CULL_FACE);
	glDisable(GL_COLOR_LOGIC_OP);
	glDisable(GL_DITHER);
	glDisable(GL_STENCIL_TEST);
	
	glEnable(GL_ALPHA_TEST);
	//glAlphaFunc(GL_GREATER, 0.1f);
	
	glEnable(GL_BLEND);
	glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
	glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
	
	glEnable(GL_TEXTURE_2D);
	
	glEnableClientState(GL_VERTEX_ARRAY);
	glEnableClientState(GL_TEXTURE_COORD_ARRAY);
	glEnableClientState(GL_COLOR_ARRAY);
	
	//glVertexPointer(2, GL_FLOAT, 0, verticesSquare);
}

// --------------------------------------------------
// Render state setup
// --------------------------------------------------
void GLRender::teardown()
{
	glDisableClientState(GL_VERTEX_ARRAY);
	glDisableClientState(GL_TEXTURE_COORD_ARRAY);
	glDisableClientState(GL_COLOR_ARRAY);
	
	glDisable(GL_TEXTURE_2D);
	glDisable(GL_BLEND);
	glDisable(GL_ALPHA_TEST);
}

// --------------------------------------------------
// Render all registered objects
// --------------------------------------------------
void GLRender::render()
{
	// -------------------------
	// update the fps counter
	// -------------------------
	m_fps.update();
	// -------------------------
	
	//NSLog(@"-------------------------------------");
	//NSLog(@"Render Begin");
	
	// -------------------------
	// render or clear the background
	// -------------------------
	renderbackground();
	// -------------------------
	
	glPushMatrix();
	
	// -------------------------
	// setup the Camera
	// -------------------------
	setupCamera();
	// -------------------------
	
	// -------------------------
	// render sceen objects
	// -------------------------
	renderObjects();
	// -------------------------
	
	//NSLog(@"Render UI");
	
	// -------------------------
	// setup the screen space
	// -------------------------
	glPopMatrix();
	// -------------------------
	
	// -------------------------
	// render UI elements
	// -------------------------
	renderUI();
	// -------------------------
	
	//NSLog(@"Render End");
	//NSLog(@"-------------------------------------");
}

#pragma mark ---------------------------------------------------------
#pragma mark === End Public Utility Functions  ===
#pragma mark ---------------------------------------------------------

#pragma mark ---------------------------------------------------------
#pragma mark === Public Functions  ===
#pragma mark ---------------------------------------------------------

// ----------------------------------------
// add a GLImage to the render list
// ----------------------------------------
Boolean GLRender::add( GLObject * _object, eGLEngineLayerTypes _layer )
{
	if ( _object->m_layerType == eGLEngineLayerTypes_Invalid )
	{
		if ( _layer >= eGLEngineLayerTypes_ui )
		{
			m_renderLayerUI.push_back(_object);
			_object->m_layerType = _layer;
			return true;
		}
		else if ( _layer > eGLEngineLayerTypes_Invalid )
		{
			m_renderLayers[_layer].push_back(_object);
			_object->m_layerType = _layer;
			return true;
		}
	}

	return false;
}

// ----------------------------------------
// remove a GLImage from the render list
// ----------------------------------------
Boolean GLRender::remove( GLObject * _object )
{
	eGLEngineLayerTypes layerType = _object->m_layerType;
	if ( layerType > eGLEngineLayerTypes_Invalid )
	{
		if ( layerType >= eGLEngineLayerTypes_ui )
		{
			// taken from Item 32 of Scott Myers' Effective STL
			m_renderLayerUI.erase(std::remove(m_renderLayerUI.begin(), m_renderLayerUI.end(), _object), m_renderLayerUI.end());
			_object->m_layerType = eGLEngineLayerTypes_Invalid;
			return true;
		}
		else
		{
			// taken from Item 32 of Scott Myers' Effective STL
			m_renderLayers[layerType].erase(std::remove(m_renderLayers[layerType].begin(), m_renderLayers[layerType].end(), _object), m_renderLayers[layerType].end());
			_object->m_layerType = eGLEngineLayerTypes_Invalid;
			return true;
		}
	}
	
	return false;
}

// ----------------------------------------
// show or hide the fps
// ----------------------------------------
void GLRender::displayFps( Boolean _display )
{
	if ( _display )
	{	
		m_fpsLabel = new GLLabel( @"FPS : 0" );
		m_fpsLabel->setShadow(true);
		m_fpsLabel->setShadowColor( 0.0f, 0.0f, 0.0f );
		m_fpsLabel->setShadowOffset( -1.0f, -1.0f );
	}
	else if ( m_fpsLabel )
	{
		delete(m_fpsLabel);
		m_fpsLabel = nil;
	}
}

// --------------------------------------------------
// print the stats to the log file or console window
// --------------------------------------------------
void GLRender::printStats()
{
	NSLog( @"-------------------------------------------------");
	NSLog( @"-- GLEngine Stats");
	NSLog( @"-------------------------------------------------");
	NSLog( @"" );
	for ( int i=0; i<GLEngineLayerTypesMaxNormalLayers; i++ )
	{
		std::vector<GLObject*> & _objects = m_renderLayers[i];
		
		NSLog( @"-------------------------------------------------");
		NSLog( @"-- Render Layer %d : Containing %d objects.", i, _objects.size() );
		NSLog( @"-------------------------------------------------");
		
		for ( std::vector<GLObject*>::iterator it = _objects.begin(); it != _objects.end(); it++ )
		{
			GLObject * obj = *it;
			NSLog( @"Object type %d", obj->type() );
		}
		
		NSLog( @"-------------------------------------------------");
		NSLog( @"" );
	}
	
	NSLog( @"-------------------------------------------------");
	NSLog( @"-- GLEngine Stats End");
	NSLog( @"-------------------------------------------------");
}

#pragma mark ---------------------------------------------------------
#pragma mark === End Public Functions  ===
#pragma mark ---------------------------------------------------------

#pragma mark ---------------------------------------------------------
#pragma mark Private Functions
#pragma mark ---------------------------------------------------------

// --------------------------------------------------
// Move the render area to be at the camera
// --------------------------------------------------
void GLRender::setupCamera()
{	
	float scale = m_worldScale;
	glScalef(scale, scale, 0);
	
	const CGPoint & pos = m_camera.position();
	float x = (m_viewPort.size.width*0.5f) - pos.x;
	float y = (m_viewPort.size.height*0.5f) - pos.y;

	glTranslatef(x,y,0); //translate the screen to the position of our camera	
		
	m_viewPort.origin.x = -x;
	m_viewPort.origin.y = -y;
}

// --------------------------------------------------
// render the FPS label
// --------------------------------------------------
void GLRender::renderFPS()
{
	if ( m_fpsLabel )
	{
		float x = m_width  - ( m_fpsLabel->size().width * 0.5f );
		float y = m_height - ( m_fpsLabel->size().height * 0.5f );
		
		m_fpsLabel->setCenter( x, y );
		m_fpsLabel->setText( [NSString stringWithFormat:@"FPS : %d", m_fps.fps()] );
		renderLabel(m_fpsLabel);
	}
}

// --------------------------------------------------
// render the backgound or clear the bit buffer
// --------------------------------------------------
void GLRender::renderbackground()
{
	if ( !m_background.valid() )
	{
		// clear the background
		glClear(GL_COLOR_BUFFER_BIT);
	}
	else
	{
		//glClear(GL_COLOR_BUFFER_BIT);
		
		const GLTexture * texture	= m_background.texture();
		const GLColor & color		= m_background.color();
		
		bindTexture( texture->bindID() );
		
		m_renderBatch.addQuad( CGPointZero, CGPointMake(m_width, m_height), color );
	}
}

// --------------------------------------------------
// render the UI Elements
// --------------------------------------------------
void GLRender::renderUI()
{
	renderLayer(m_renderLayerUI);
	
	// -------------------------
	// render the FPS Label
	// -------------------------
	renderFPS();
	// -------------------------
	
	m_renderBatch.flush();
}

// --------------------------------------------------
// render the Sceen Objects
// --------------------------------------------------
void GLRender::renderObjects()
{
	for ( int i=0; i<GLEngineLayerTypesMaxNormalLayers; i++ )
	{
		renderLayer(m_renderLayers[i]);
	}
	m_renderBatch.flush();
}

// --------------------------------------------------
// render a single object layer
// --------------------------------------------------
void GLRender::renderLayer( std::vector<GLObject*> & _objects )
{
	// iterate over all the game objects and render them
	for ( std::vector<GLObject*>::iterator it = _objects.begin(); it != _objects.end(); it++ )
	{
		GLObject * obj = *it;
		renderObject(obj);
	}
}

// --------------------------------------------------
// render a single object
// --------------------------------------------------
void GLRender::renderObject( GLObject * _object )
{
	switch ( _object->type() )
	{
		case eGLObjectImage:
		{
			renderImage((GLImage*)_object);
			break;
		}
		case eGLObjectImageBatch:
		{
			renderImageBatch((GLImageBatch*)_object);
			break;
		}
		case eGLObjectSprite:
		{
			renderSprite((GLSprite*)_object);
			break;
		}
		case eGLObjectSpriteBatch:
		{
			renderSpriteBatch((GLSpriteBatch*)_object);
			break;
		}
		case eGLObjectModel:
		{
			renderModel((GLModel*)_object);
			break;
		}
		case eGLObjectLabel:
		{
			renderLabel((GLLabel*)_object);
			break;
		}
		case eGLObjectLine:
		{
			renderLine((GLLine*)_object);
			break;
		}
		case eGLObjectHierarchy:
		{
			renderHierarchy((GLObjectHierarchy*)_object);
			break;
		}
	}
}

// --------------------------------------------------
// render a Hierarchy
// --------------------------------------------------
void GLRender::renderHierarchy( GLObjectHierarchy * _hierarchy )
{
	glPushMatrix();
	
	// move the object around
	glTranslatef(_hierarchy->center().x, _hierarchy->center().y, 0);
	// rotate the object
	glRotatef(_hierarchy->rotation(), 0, 0, 1);
	// scale
	glScalef(_hierarchy->scale().width, _hierarchy->scale().height, 0);
	
	// iterate over the internal objects
	for ( int i=0; i<_hierarchy->count(); i++ )
	{
		GLObject * object = _hierarchy->get(i);
		
		renderObject(object);
	}
	
	// force a flush
	m_renderBatch.flush();
	
	glPopMatrix();
}

// --------------------------------------------------
// simple render code for an image.
// --------------------------------------------------
void GLRender::renderImage( const GLImage * _image )
{	
	//NSLog(@"Render Image : %@,  Bind Texture : %d", _image->texture()->name(), _image->texture()->bindID());
	if ( bindTexture( _image->texture() ) )
	{
		m_renderBatch.addQuad( _image->center(), 
							   _image->size(), 
							   _image->scale(), 
							   _image->rotation(), 
							   _image->textureCoordinatesLayout(),
							   _image->color() );
		
		//m_renderBatch.flush();
	}
}

// --------------------------------------------------
// simple render code for an image Batch.
// --------------------------------------------------
void GLRender::renderImageBatch( const GLImageBatch * _image )
{
	if ( _image->count() > 0 )
	{
		//NSLog(@"Render Image Batch : %@,  Bind Texture : %d", _image->texture()->name(), _image->texture()->bindID());
		if ( bindTexture( _image->texture() ) )
		{
			NSInteger count = _image->count();
			float scaleWidth = _image->pointsSize().width * _image->pointsScale().width;
			float scaleHeight = _image->pointsSize().height * _image->pointsScale().height;
			const GLColor & color = _image->pointsColor();
					
			for ( int i=0; i<count; i++ )
			{
				const GLImageBatchPoint * point = _image->point(i);
				
				m_renderBatch.addQuad( point->center(), 
									   scaleWidth * point->scale().width, scaleHeight * point->scale().height, 
									   _image->pointsRotation() + point->rotation(), 0,
									   color.red() * point->color().red(), color.green() * point->color().green(), color.blue() * point->color().blue(), color.alpha() * point->color().alpha() );
			}
			
			//m_renderBatch.flush();
		}
	}
}

// --------------------------------------------------
// simple rander code for a sprite
// --------------------------------------------------
void GLRender::renderSprite( const GLSprite * _sprite )
{
	//NSLog(@"Render Sprite Batch : %@,  Bind Texture : %d", _sprite->texture()->name(), _sprite->texture()->bindID());
	if ( bindTexture( _sprite->texture() ) )
	{
		m_renderBatch.addQuad( _sprite->center(), 
							   _sprite->size(), 
							   _sprite->scale(), 
							   _sprite->texture()->uvMin(_sprite->frame()),
							   _sprite->texture()->uvMax(_sprite->frame()),
							   _sprite->rotation(), _sprite->textureCoordinatesLayout(),
							   _sprite->color() );
		
		//m_renderBatch.flush();
	}
}

// --------------------------------------------------
// sprite batch render
// --------------------------------------------------
void GLRender::renderSpriteBatch( const GLSpriteBatch * _sprite )
{
	if ( _sprite->count() > 0 )
	{
		//NSLog(@"Render Sprite : %@,  Bind Texture : %d", _sprite->texture()->name(), _sprite->texture()->bindID());
		if ( bindTexture( _sprite->texture() ) )
		{
			NSInteger count = _sprite->count();
			float scaleWidth = _sprite->pointsSize().width * _sprite->pointsScale().width;
			float scaleHeight = _sprite->pointsSize().height * _sprite->pointsScale().height;
			const GLColor & color = _sprite->pointsColor();
			
			for ( int i=0; i<count; i++ )
			{
				const GLSpriteBatchPoint * point = _sprite->point(i);
				
				m_renderBatch.addQuad( point->center(), 
									  scaleWidth * point->scale().width, 
									  scaleHeight * point->scale().height, 
									  _sprite->texture()->uvMin(point->frame()),
									  _sprite->texture()->uvMax(point->frame()),
									  _sprite->pointsRotation() + point->rotation(), 0,
									  color.red() * point->color().red(), 
									  color.green() * point->color().green(), 
									  color.blue() * point->color().blue(), 
									  color.alpha() * point->color().alpha() );
			}
			
			//m_renderBatch.flush();
		}
	}
}

// --------------------------------------------------
// render the model
// --------------------------------------------------
void GLRender::renderModel( const GLModel * _model )
{
	//NSLog(@"Render Model : %@,  Bind Texture : %d", _model->texture()->name(), _model->texture()->bindID());
	if ( bindTexture( _model->texture() ) )
	{
		const CGPoint & point = _model->center();
		const GLVert * verts = _model->verts();
		Maths::CGVector2D rotVert;
		for( int i=0; i<_model->count(); i++ )
		{
			//grab the current vert
			const GLVert & vert = verts[i];
			
			// rotate the vert positon
			rotVert = Maths::CGVector2DRotate( vert.x, vert.y, -Maths::Degrees2Radians(_model->rotation()));
			
			// scale the vert
			rotVert.x *= _model->scale().width;
			rotVert.y *= _model->scale().height;
			
			// offset the vert to the correct location
			rotVert.x += point.x;
			rotVert.y += point.y;
			
			// add the vert into the render batch
			m_renderBatch.addVert( rotVert.x, rotVert.y, vert.uvx, vert.uvy, _model->color() );
		}
	}
}

// --------------------------------------------------
// render the label
// --------------------------------------------------
void GLRender::renderLabel( GLLabel * _label )
{	
	//NSLog(@"Render Label : %@,  Bind Texture : %d", _label->text(), _label->bindID());
	bindTexture( _label->bindID() );
	
	// update the image if dirty
	_label->update();
	
	float uvMaxX = (float)_label->frameWidth() / (float)_label->textureWidth();
	float uvMaxY = (float)_label->frameHeight() / (float)_label->textureHeight();
	
	// render the shadow
	if ( _label->shadow() )
	{
		m_renderBatch.addQuad( _label->center().x + _label->shadowOffset().x, _label->center().y + _label->shadowOffset().y, 
							   _label->size().width * _label->scale().width, _label->size().height * _label->scale().height,
							   0.0f, 0.0f, uvMaxX, uvMaxY,  
							   _label->rotation(), 0,
							   _label->shadowColor().red(), _label->shadowColor().green(), _label->shadowColor().blue(), _label->shadowColor().alpha() * _label->alpha());
	}
	
	m_renderBatch.addQuad( _label->center().x, _label->center().y,
		 				   _label->size().width * _label->scale().width, _label->size().height * _label->scale().height,
						   0.0f, 0.0f, uvMaxX, uvMaxY, 
						   _label->rotation(), 0,
						   _label->color().red(), _label->color().green(), _label->color().blue(), _label->color().alpha() * _label->alpha() );
	
	//m_renderBatch.flush();
}

// --------------------------------------------------
// render a Line
// --------------------------------------------------
void GLRender::renderLine( GLLine * _line )
{
	m_renderBatch.flush();
	
	glDisable(GL_TEXTURE_2D); 
	
	glDisableClientState(GL_TEXTURE_COORD_ARRAY);
	glDisableClientState(GL_COLOR_ARRAY);
	
	glColor4f(_line->color().red(),_line->color().green(),_line->color().blue(),_line->color().alpha()); //line color
	glLineWidth(_line->width());
	glVertexPointer(2, GL_FLOAT, 0, _line->data());
	
	glDrawArrays(GL_LINE_STRIP, 0, _line->count());
	
	glEnableClientState(GL_TEXTURE_COORD_ARRAY);
	glEnableClientState(GL_COLOR_ARRAY);
	
	glEnable(GL_TEXTURE_2D); 
}

// --------------------------------------------------
// bind the texture and store the 
// current bound texture
// --------------------------------------------------
BOOL GLRender::bindTexture( const GLTexture * texture )
{
	if ( texture )
	{
		bindTexture( texture->bindID() );
		return TRUE;
	}
	return FALSE;
}

// --------------------------------------------------
// bind the texture and store the 
// current bound texture
// --------------------------------------------------
void GLRender::bindTexture( NSInteger _bindID )
{
	GLint bound = 0;
	glGetIntegerv(GL_TEXTURE_BINDING_2D, &bound);
	
	if ( ( bound != _bindID ) || 
		 ( bound != boundTexture ) )
	{
		if ( bound != boundTexture )
		{
			// re-bind the texture
			glBindTexture(GL_TEXTURE_2D, boundTexture);	
		}
		
		m_renderBatch.flush();
		
		boundTexture = _bindID;
		glBindTexture(GL_TEXTURE_2D, _bindID);
	}
}

// --------------------------------------------------
// Clean up a layer object
// --------------------------------------------------
void GLRender::cleanupLayer( std::vector<GLObject*> & _objects )
{
	// delete all the currently registerd objects
	for ( std::vector<GLObject*>::iterator it = _objects.begin(); it != _objects.end(); it++ )
	{
		GLObject * obj = *it;
		
		delete(obj);
		obj = nil;
	}
	_objects.clear();
}

#pragma mark ---------------------------------------------------------
#pragma mark End Private Functions
#pragma mark ---------------------------------------------------------