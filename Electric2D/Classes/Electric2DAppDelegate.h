//
//  Electric2DAppDelegate.h
//  Electric2D
//
//  Created by robert on 21/04/2009.
//  Copyright Electric TopHat 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EAGLView;

@interface Electric2DAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end

