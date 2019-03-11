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
#import "Floor.h"
#import "mazeProcessor.h"
#import "WestWall.h"
#import "EastWall.h"
#import "NorthWall.h"
#import "SouthWall.h"

@implementation GameScene {
    CGSize _gameArea;
    float _sceneOffset;
    Floor *_floor;
    WestWall *_westWall;
    EastWall *_eastWall;
    NorthWall *_northWall;
    SouthWall *_southWall;
    mazeProcessor *mazeObject;
}

- (instancetype)initWithShader:(GLKBaseEffect *)shader {
    if ((self = [super initWithName:"GameScene" shader:shader vertices:nil vertexCount:0])) {
        
        // Create initial scene position (i.e. camera)
        _gameArea = CGSizeMake(40, 80);
        _sceneOffset = _gameArea.height/2 / tanf(GLKMathRadiansToDegrees(85.0/2));
        self.position = GLKVector3Make(0, -_gameArea.height/2 + 20, -_sceneOffset);
        self.rotationX = GLKMathDegreesToRadians(15);
        
        mazeObject = [[mazeProcessor alloc] init];
        for (int i = 0; i < [mazeObject getRows]; i++) {
            for (int j = 0; j < [mazeObject getCols]; j++) {
                _floor = [[Floor alloc] initWithShader:shader];
                _floor.position = GLKVector3Make((i * _floor.scale * 2), 0, (j * _floor.scale * 2));
                [self.children addObject:_floor];
                if ([mazeObject getCellAtRow:i col:j].eastWallPresent) {
                    _eastWall = [[EastWall alloc] initWithShader:shader];
                    _eastWall.position = GLKVector3Make((i * _eastWall.scale * 2), _floor.scale*2, (j * _eastWall.scale * 2));
                    [self.children addObject:_eastWall];
                    _westWall = [[WestWall alloc] initWithShader:shader];
                    _westWall.position = GLKVector3Make((i * _westWall.scale * 2) - (_floor.scale * 2), _floor.scale*2, (j * _westWall.scale * 2));
                    [self.children addObject:_westWall];
                }
                if ([mazeObject getCellAtRow:i col:j].westWallPresent) {
                    _westWall = [[WestWall alloc] initWithShader:shader];
                    _westWall.position = GLKVector3Make((i * _westWall.scale * 2), _floor.scale*2, (j * _westWall.scale * 2));
                    [self.children addObject:_westWall];
                    _eastWall = [[EastWall alloc] initWithShader:shader];
                    _eastWall.position = GLKVector3Make((i * _eastWall.scale * 2) + (_floor.scale * 2), _floor.scale*2, (j * _eastWall.scale * 2));
                    [self.children addObject:_eastWall];
                }
                if ([mazeObject getCellAtRow:i col:j].southWallPresent) {
                    _southWall = [[SouthWall alloc] initWithShader:shader];
                    _southWall.position = GLKVector3Make((i * _southWall.scale * 2), _floor.scale*2, (j * _southWall.scale * 2));
                    [self.children addObject:_southWall];
                    _northWall = [[NorthWall alloc] initWithShader:shader];
                    _northWall.position = GLKVector3Make((i * _northWall.scale * 2), _floor.scale*2, (j * _northWall.scale * 2) + (_floor.scale * 2));
                    [self.children addObject:_northWall];
                }
                if ([mazeObject getCellAtRow:i col:j].northWallPresent) {
                    _northWall = [[NorthWall alloc] initWithShader:shader];
                    _northWall.position = GLKVector3Make((i * _northWall.scale * 2), _floor.scale*2, (j * _northWall.scale * 2));
                    [self.children addObject:_northWall];
                    _southWall = [[SouthWall alloc] initWithShader:shader];
                    _southWall.position = GLKVector3Make((i * _southWall.scale * 2), _floor.scale*2, (j * _southWall.scale * 2) - (_floor.scale * 2));
                    [self.children addObject:_southWall];
                }
            }
        }
        
    }
    return self;
}

- (void)updateWithDelta:(GLfloat)aDelta {
    [super updateWithDelta:aDelta];
    self.rotationY += GLKMathDegreesToRadians(15) * aDelta;
}

@end
