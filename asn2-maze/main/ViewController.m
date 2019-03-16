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
    __weak IBOutlet UISlider *_rSlider;
    __weak IBOutlet UISlider *_gSlider;
    __weak IBOutlet UISlider *_bSlider;
}
@property (weak, nonatomic) IBOutlet UIView *_console;

@end

@implementation ViewController {
    BOOL toggleDay;
    BOOL toggleFog;
    BOOL toggleFlashlight;
    float red;
    float green;
    float blue;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __console.hidden = true;
    
    
    UITapGestureRecognizer *twoTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    twoTapGesture.numberOfTapsRequired = 2;
    twoTapGesture.numberOfTouchesRequired = 2;
    [self.view addGestureRecognizer:twoTapGesture];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    tapGesture.numberOfTapsRequired = 2;
    tapGesture.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:tapGesture];
    
    GLKView *view = (GLKView *)self.view;
    view.drawableDepthFormat = GLKViewDrawableDepthFormat24;
    view.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    
    toggleDay = TRUE;
    toggleFog = FALSE;
    red = .5;
    green = .5;
    blue = .5;
    
    [EAGLContext setCurrentContext:view.context];
    glViewport(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self setupScene];
}

- (void) setupScene{
    _shader = [[GLKBaseEffect alloc] init];
    _shader.transform.projectionMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(85.0), self.view.frame.size.width/self.view.frame.size.height, 1, 300);
    
    [Director sharedInstance].scene = [[GameScene alloc] initWithShader:_shader];
    [Director sharedInstance].view = self.view;
}

- (void)update {
    [[Director sharedInstance].scene updateWithDelta:self.timeSinceLastUpdate];
}
    
- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    
    if (toggleDay) {
        _shader.light0.position = GLKVector4Make(1, 1, 1, 0);
        glClearColor(.5, .5, 1, 1.0);
    } else {
        _shader.light0.position = GLKVector4Make(0, 0, 0, 0);
        glClearColor(.1, .1, .25, 1.0);
    }
    if (toggleFog) {
        _shader.fog.enabled = GL_TRUE;
        _shader.fog.mode = 1;
        _shader.fog.density = .025;
        _shader.fog.color = GLKVector4Make(red, green, blue, .1);
    } else {
        _shader.fog.enabled = GL_FALSE;
    }
    if (toggleFlashlight) {
        _shader.light1.enabled = GL_TRUE;
    } else {
        _shader.light1.enabled = GL_FALSE;
    }
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    glEnable(GL_DEPTH_TEST);
    glEnable(GL_CULL_FACE);
    
    [[Director sharedInstance].scene renderWithParentModelViewMatrix:GLKMatrix4Identity];
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

- (void)handleTapGesture:(UITapGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateRecognized && sender.numberOfTouches == 1) {
        [(GameScene *)[Director sharedInstance].scene resetPosition];
    } else if (sender.state == UIGestureRecognizerStateRecognized && sender.numberOfTouches == 2) {
        __console.hidden = !__console.hidden;
    }
}

- (IBAction)dayNightBtn:(id)sender {
    toggleDay = !toggleDay;
}

- (IBAction)fogBtn:(id)sender {
    toggleFog = !toggleFog;
}
- (IBAction)rSlider:(id)sender {
    red = [_rSlider value ];
}
- (IBAction)gSlider:(id)sender {
    green = [_gSlider value];
}
- (IBAction)bSlider:(id)sender {
    blue = [_bSlider value];
}
- (IBAction)flashlightBtn:(id)sender {
    toggleFlashlight = !toggleFlashlight;
}

@end
