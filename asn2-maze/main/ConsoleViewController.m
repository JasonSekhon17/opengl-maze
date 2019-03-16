//
//  ConsoleViewController.m
//  asn2-maze
//
//  Created by Jason Sekhon on 2019-03-15.
//  Copyright © 2019 Jason Sekhon. All rights reserved.
//

#import "ConsoleViewController.h"
#import "ViewController.h"
#import "ConsoleScene.h"
#import "Director.h"

@implementation ConsoleViewController {
    GLKBaseEffect* _shader;
    Node *_scene;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    GLKView *view = (GLKView *)self.view;
    view.drawableDepthFormat = GLKViewDrawableDepthFormat24;
    view.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    
    [EAGLContext setCurrentContext:view.context];
    glViewport(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self setupScene];
}

- (void) setupScene{
    _shader = [[GLKBaseEffect alloc] init];
    _shader.transform.projectionMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(85.0), self.view.frame.size.width/self.view.frame.size.height, 1, 1000);
    
    _scene = [[ConsoleScene alloc] initWithShader:_shader];
    //[Director sharedInstance].view = self.view;
}

- (void)update {
    [_scene updateWithDelta:self.timeSinceLastUpdate];
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    _shader.light0.position = GLKVector4Make(1, 1, 1, 0);
    glClearColor(.5, .5, 1, 1.0);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    glEnable(GL_DEPTH_TEST);
    glEnable(GL_CULL_FACE);
    
    [_scene renderWithParentModelViewMatrix:GLKMatrix4Identity];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [[Director sharedInstance].scene touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [[Director sharedInstance].scene touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [[Director sharedInstance].scene touchesEnded:touches withEvent:event];
}


@end
