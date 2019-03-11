//
//  NorthWall.m
//  asn2-maze
//
//  Created by Jason Sekhon on 2019-03-09.
//  Copyright © 2019 Jason Sekhon. All rights reserved.
//

#import "NorthWall.h"

@implementation NorthWall

const Vertex Vertices2[] = {
    // Back
    {{-1, -1, -1}, {1, 0}, {0, 0, -1}}, // 0
    {{-1, 1, -1}, {1, 1}, {0, 0, -1}}, // 1
    {{1, 1, -1}, {0, 1}, {0, 0, -1}}, // 2
    
    {{1, 1, -1}, {0, 1}, {0, 0, -1}}, // 2
    {{1, -1, -1}, {0, 0}, {0, 0, -1}}, // 3
    {{-1, -1, -1}, {1, 0}, {0, 0, -1}}, // 0
};

const GLubyte Indices2[] = {
    // Right
    0, 1, 2,
    2, 3, 0
};

- (instancetype)initWithShader:(GLKBaseEffect *)shader {
    
    if ((self = [super initWithName:"NorthWall" shader:shader
                           vertices:(Vertex *)Vertices2
                        vertexCount:sizeof(Vertices2) / sizeof(Vertices2[0])])) {
        
        self.diffuseColor = GLKVector4Make(1, 1, 1, 1);
        self.specularColor = GLKVector4Make(1, 1, 1, 1);
        self.shininess = 10;
        self.scale = 5;
        
        [self loadTexture:@"NorthWall.jpg"];
    }
    return self;
}

- (void)updateWithDelta:(GLfloat)aDelta {
    //self.rotationZ += M_PI * aDelta;
}

@end
