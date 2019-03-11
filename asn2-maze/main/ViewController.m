//
//  ViewController.m
//  asn2-maze
//
//  Created by Jason Sekhon on 2019-03-06.
//  Copyright © 2019 Jason Sekhon. All rights reserved.
//

#import "ViewController.h"
#import "mazeProcessor.h"
#import "Director.h"
#import "GameScene.h"

@interface ViewController () {
    GLKBaseEffect* _shader;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    GLKView *view = (GLKView *)self.view;
    view.drawableDepthFormat = GLKViewDrawableDepthFormat24;
    view.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    
    [EAGLContext setCurrentContext:view.context];
    glViewport(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self setupScene];
}

- (void) setupScene{
    _shader = [[GLKBaseEffect alloc] init];
    _shader.transform.projectionMatrix = GLKMatrix4MakePerspective(GLKMathRadiansToDegrees(85.0), self.view.frame.size.width/self.view.frame.size.height, 1, 150);
    
    
    [Director sharedInstance].scene = [[GameScene alloc] initWithShader:_shader];
    [Director sharedInstance].view = self.view;
}

- (void)update {
    [[Director sharedInstance].scene updateWithDelta:self.timeSinceLastUpdate];
}
    
- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    float amount = 0.25 * sin(CACurrentMediaTime()) + 0.75;
    float amount2 = 0.25 * sin(CACurrentMediaTime()+M_PI_4) + 0.75;
    float amount3 = 0.25 * sin(CACurrentMediaTime()+M_PI_2) + 0.75;
    
    glClearColor(amount, amount2, amount3, 1.0);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    glEnable(GL_DEPTH_TEST);
    glEnable(GL_CULL_FACE);
    
    [[Director sharedInstance].scene renderWithParentModelViewMatrix:GLKMatrix4Identity];
}


@end
