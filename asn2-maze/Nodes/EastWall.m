//
//  EastWall.m
//  asn2-maze
//
//  Created by Jason Sekhon on 2019-03-09.
//  Copyright © 2019 Jason Sekhon. All rights reserved.
//

#import "EastWall.h"

@implementation EastWall

const Vertex Vertices1[] = {
    // Left
    {{-1, -1, 1}, {1, 0}, {-1, 0, 0}}, // 0
    {{-1, 1, 1}, {1, 1}, {-1, 0, 0}}, // 1
    {{-1, 1, -1}, {0, 1}, {-1, 0, 0}}, // 2
    
    {{-1, 1, -1}, {0, 1}, {-1, 0, 0}}, // 2
    {{-1, -1, -1}, {0, 0}, {-1, 0, 0}}, // 3
    {{-1, -1, 1}, {1, 0}, {-1, 0, 0}}, // 0
};

const GLubyte Indices1[] = {
    // Right
    0, 1, 2,
    2, 3, 0
};

- (instancetype)initWithShader:(GLKBaseEffect *)shader {
    
    if ((self = [super initWithName:"EastWall" shader:shader
                           vertices:(Vertex *)Vertices1
                        vertexCount:sizeof(Vertices1) / sizeof(Vertices1[0])])) {
        
        self.diffuseColor = GLKVector4Make(1, 1, 1, 1);
        self.specularColor = GLKVector4Make(1, 1, 1, 1);
        self.shininess = 10;
        self.scale = 5;
        
        [self loadTexture:@"EastWall.jpg"];
    }
    return self;
}

- (void)updateWithDelta:(GLfloat)aDelta {
    //self.rotationZ += M_PI * aDelta;
}

@end
