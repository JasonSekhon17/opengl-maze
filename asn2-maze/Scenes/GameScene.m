//
//  GameScene.m
//  asn2-maze
//
//  Created by Jason Sekhon on 2019-03-09.
//  Copyright © 2019 Jason Sekhon. All rights reserved.
//

#import "GameScene.h"
#import "Director.h"
#import "Node.h"
#import "Cube.h"
#import "Floor.h"
#import "mazeProcessor.h"
#import "WestWall.h"
#import "EastWall.h"
#import "NorthWall.h"
#import "SouthWall.h"

@implementation GameScene {
    CGSize _gameArea;
    float _sceneOffset;
    Cube *_cube;
    Floor *_floor;
    WestWall *_westWall;
    EastWall *_eastWall;
    NorthWall *_northWall;
    SouthWall *_southWall;
    mazeProcessor *mazeObject;
    NSMutableArray *_cells;
    NSMutableArray *_originalObjects;
    CGPoint _previousTouchLocation;
    GLKBaseEffect *_shader;
}

- (instancetype)initWithShader:(GLKBaseEffect *)shader {
    if ((self = [super initWithName:"GameScene" shader:shader vertices:nil vertexCount:0])) {
        _shader = shader;
        _shader.light1.position = GLKVector4Make(0, 0, -1, 1);
        // Create initial scene position (i.e. camera)
        _gameArea = CGSizeMake(40, 80);
        //_sceneOffset = _gameArea.height/2 / tanf(GLKMathRadiansToDegrees(80.0/2));
        //self.position = GLKVector3Make(0, -_gameArea.height/2, -_sceneOffset);
        self.position = GLKVector3Make(0, -_gameArea.height/2 + 20, -20);
        self.rotationY = GLKMathDegreesToRadians(90);
        mazeObject = [Director sharedInstance].mazeObject;
        [self createMaze];
    }
    return self;
}

- (void)createMaze {
    printf("%lu \n", self.children.count);
    for (int i = 0; i < [mazeObject getRows]; i++) {
        for (int j = 0; j < [mazeObject getCols]; j++) {
            _floor = [[Floor alloc] initWithShader:_shader];
            _floor.position = GLKVector3Make((i * _floor.scale * 2), 0, (j * _floor.scale * 2));
            [self.children addObject:_floor];
            [_cells addObject:_floor];
            if (i == 0 && j == 0) {
                _cube = [[Cube alloc] initWithShader:_shader];
                _cube.position = GLKVector3Make(0, -_gameArea.height/2 + 60, _floor.position.z);
                [self.children addObject:_cube];
            }
            if ([mazeObject getCellAtRow:i col:j].northWallPresent) {
                _eastWall = [[EastWall alloc] initWithShader:_shader];
                _eastWall.position = GLKVector3Make((i * _eastWall.scale * 2), _floor.scale*2, (j * _eastWall.scale * 2));
                [self.children addObject:_eastWall];
                _westWall = [[WestWall alloc] initWithShader:_shader];
                _westWall.position = GLKVector3Make((i * _westWall.scale * 2) - (_floor.scale * 2), _floor.scale*2, (j * _westWall.scale * 2));
                [self.children addObject:_westWall];
            }
            if ([mazeObject getCellAtRow:i col:j].southWallPresent) {
                _westWall = [[WestWall alloc] initWithShader:_shader];
                _westWall.position = GLKVector3Make((i * _westWall.scale * 2), _floor.scale*2, (j * _westWall.scale * 2));
                [self.children addObject:_westWall];
                _eastWall = [[EastWall alloc] initWithShader:_shader];
                _eastWall.position = GLKVector3Make((i * _eastWall.scale * 2) + (_floor.scale * 2), _floor.scale*2, (j * _eastWall.scale * 2));
                [self.children addObject:_eastWall];
            }
            if ([mazeObject getCellAtRow:i col:j].eastWallPresent) {
                _southWall = [[SouthWall alloc] initWithShader:_shader];
                _southWall.position = GLKVector3Make((i * _southWall.scale * 2), _floor.scale*2, (j * _southWall.scale * 2));
                [self.children addObject:_southWall];
                _northWall = [[NorthWall alloc] initWithShader:_shader];
                _northWall.position = GLKVector3Make((i * _northWall.scale * 2), _floor.scale*2, (j * _northWall.scale * 2) + (_floor.scale * 2));
                [self.children addObject:_northWall];
            }
            if ([mazeObject getCellAtRow:i col:j].westWallPresent) {
                _northWall = [[NorthWall alloc] initWithShader:_shader];
                _northWall.position = GLKVector3Make((i * _northWall.scale * 2), _floor.scale*2, (j * _northWall.scale * 2));
                [self.children addObject:_northWall];
                _southWall = [[SouthWall alloc] initWithShader:_shader];
                _southWall.position = GLKVector3Make((i * _southWall.scale * 2), _floor.scale*2, (j * _southWall.scale * 2) - (_floor.scale * 2));
                [self.children addObject:_southWall];
            }
        }
    }
}

- (CGPoint)touchLocationToGameArea:(CGPoint)touchLocation {
    
    // Perform calculation to convert touch location to game area
    float ratio = [Director sharedInstance].view.frame.size.height / _gameArea.height;
    float actualX = touchLocation.x / ratio;
    float actualY = ([Director sharedInstance].view.frame.size.height - touchLocation.y) / ratio;
    CGPoint actual = CGPointMake(actualX, actualY);
    
    //NSLog(@"Actual touch: %@", NSStringFromCGPoint(actual));
    return actual;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    // Store previous touch location
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:[Director sharedInstance].view];
    _previousTouchLocation = [self touchLocationToGameArea:touchLocation];
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    // Get current touch location
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:[Director sharedInstance].view];
    touchLocation = [self touchLocationToGameArea:touchLocation];
    
    // Calculate diff between previous touch location and current touch location
    CGPoint diff = CGPointMake(touchLocation.x - _previousTouchLocation.x, touchLocation.y - _previousTouchLocation.y);
    _previousTouchLocation = touchLocation;
    
    float newX = self.position.x + diff.x;
    newX = MIN(MAX(newX, self.width/2), _gameArea.width - self.width/2);
    
    float newY = self.position.y + diff.y;
    newY = MIN(MAX(newY, self.height/2), _gameArea.height - self.height/2);
    
    if ((2 * M_PI) - fabsf(self.rotationY) <= 0)
        self.rotationY = 0;
    
    if (fabs(diff.x) > fabs(diff.y)) {
        float cosYaw = cosf(diff.x);
        float sinYaw = sinf(diff.x);
        self.rotationY += diff.x;
        self.position = GLKVector3Make(cosYaw, self.position.y, sinYaw);
    } else {
        for (int i = 0; i < self.children.count; i++){
            Node *child = (Node *)[self.children objectAtIndex:i];
            child.position = GLKVector3Make(child.position.x + (diff.y*-sinf(self.rotationY)), child.position.y, child.position.z  + (diff.y*cosf(self.rotationY)));
        }
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
}

- (void)resetPosition {
    [self.children removeAllObjects];
    [self createMaze];
}

- (void)updateWithDelta:(GLfloat)aDelta {
    [super updateWithDelta:aDelta];
}

@end
