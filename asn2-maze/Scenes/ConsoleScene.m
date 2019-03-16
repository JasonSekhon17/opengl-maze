//
//  ConsoleScene.m
//  asn2-maze
//
//  Created by Jason Sekhon on 2019-03-15.
//  Copyright © 2019 Jason Sekhon. All rights reserved.
//

#import "ConsoleScene.h"
#import "Node.h"
#import "Cube.h"
#import "Floor.h"
#import "mazeProcessor.h"
#import "WestWall.h"
#import "EastWall.h"
#import "NorthWall.h"
#import "SouthWall.h"
#import "Director.h"
#import "GameScene.h"
#import "PlayerModel.h"

@implementation ConsoleScene {
    CGSize _gameArea;
    float _sceneOffset;
    Cube *_cube;
    PlayerModel *_playerModel;
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
        // Create initial scene position (i.e. camera)
        _gameArea = CGSizeMake(40, 80);
        self.position = GLKVector3Make(-_gameArea.width/2-7, -_gameArea.height/2, -90);
        self.rotationY = GLKMathDegreesToRadians(90);
        self.rotationX = GLKMathDegreesToRadians(70);
        
        mazeObject = [Director sharedInstance].mazeObject;
        for (int i = 0; i < [mazeObject getRows]; i++) {
            for (int j = 0; j < [mazeObject getCols]; j++) {
                _floor = [[Floor alloc] initWithShader:shader];
                _floor.position = GLKVector3Make((i * _floor.scale * 2), 0, (j * _floor.scale * 2));
                [self.children addObject:_floor];
                [_cells addObject:_floor];
                if (i == 0 && j == 0) {
                    _cube = [[Cube alloc] initWithShader:shader];
                    _cube.position = GLKVector3Make(0, -_gameArea.height/2 + 60, _floor.position.z);
                    [self.children addObject:_cube];
                    _playerModel = [[PlayerModel alloc] initWithShader:shader];
                    _playerModel.position = GLKVector3Make(0, -_gameArea.height/2 + 60, _floor.position.z);
                    [self.children addObject:_playerModel];
                }
                if ([mazeObject getCellAtRow:i col:j].northWallPresent) {
                    _eastWall = [[EastWall alloc] initWithShader:shader];
                    _eastWall.position = GLKVector3Make((i * _eastWall.scale * 2), _floor.scale*2, (j * _eastWall.scale * 2));
                    [self.children addObject:_eastWall];
                    _westWall = [[WestWall alloc] initWithShader:shader];
                    _westWall.position = GLKVector3Make((i * _westWall.scale * 2) - (_floor.scale * 2), _floor.scale*2, (j * _westWall.scale * 2));
                    [self.children addObject:_westWall];
                }
                if ([mazeObject getCellAtRow:i col:j].southWallPresent) {
                    _westWall = [[WestWall alloc] initWithShader:shader];
                    _westWall.position = GLKVector3Make((i * _westWall.scale * 2), _floor.scale*2, (j * _westWall.scale * 2));
                    [self.children addObject:_westWall];
                    _eastWall = [[EastWall alloc] initWithShader:shader];
                    _eastWall.position = GLKVector3Make((i * _eastWall.scale * 2) + (_floor.scale * 2), _floor.scale*2, (j * _eastWall.scale * 2));
                    [self.children addObject:_eastWall];
                }
                if ([mazeObject getCellAtRow:i col:j].eastWallPresent) {
                    _southWall = [[SouthWall alloc] initWithShader:shader];
                    _southWall.position = GLKVector3Make((i * _southWall.scale * 2), _floor.scale*2, (j * _southWall.scale * 2));
                    [self.children addObject:_southWall];
                    _northWall = [[NorthWall alloc] initWithShader:shader];
                    _northWall.position = GLKVector3Make((i * _northWall.scale * 2), _floor.scale*2, (j * _northWall.scale * 2) + (_floor.scale * 2));
                    [self.children addObject:_northWall];
                }
                if ([mazeObject getCellAtRow:i col:j].westWallPresent) {
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
    ((Node *)[self.children objectAtIndex:2]).position = GLKVector3Make(-((Node *)[Director sharedInstance].scene.children[2]).position.x,
                                                                        ((Node *)[self.children objectAtIndex:2]).position.y,
                                                                        -((Node *)[Director sharedInstance].scene.children[2]).position.z);
    ((Node *)[self.children objectAtIndex:2]).rotationY = -((Node *)[Director sharedInstance].scene.self).rotationY;
}


@end
