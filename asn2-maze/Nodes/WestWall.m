//
//  WestWall.m
//  asn2-maze
//
//  Created by Jason Sekhon on 2019-03-09.
//  Copyright © 2019 Jason Sekhon. All rights reserved.
//

#import "WestWall.h"

@implementation WestWall

const Vertex Vertices0[] = {
    // Right
    {{1, -1, -1}, {1, 0}, {1, 0, 0}}, // 0
    {{1, 1, -1}, {1, 1}, {1, 0, 0}}, // 1
    {{1, 1, 1}, {0, 1}, {1, 0, 0}}, // 2
    
    {{1, 1, 1}, {0, 1}, {1, 0, 0}}, // 2
    {{1, -1, 1}, {0, 0}, {1, 0, 0}}, // 3
    {{1, -1, -1}, {1, 0}, {1, 0, 0}}, // 0
};

const GLubyte Indices0[] = {
    // Right
    0, 1, 2,
    2, 3, 0
};

- (instancetype)initWithShader:(GLKBaseEffect *)shader {
    
    if ((self = [super initWithName:"WestWall" shader:shader
                           vertices:(Vertex *)Vertices0
                        vertexCount:sizeof(Vertices0) / sizeof(Vertices0[0])])) {
        
        self.diffuseColor = GLKVector4Make(1, 1, 1, 1);
        self.specularColor = GLKVector4Make(1, 1, 1, 1);
        self.shininess = 10;
        self.scale = 5;
        
        [self loadTexture:@"WestWall.jpg"];
    }
    return self;
}

- (void)updateWithDelta:(GLfloat)aDelta {
    //self.rotationZ += M_PI * aDelta;
}

@end
