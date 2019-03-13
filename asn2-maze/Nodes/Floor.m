//
//  Floor.m
//  asn2-maze
//
//  Created by Jason Sekhon on 2019-03-09.
//  Copyright © 2019 Jason Sekhon. All rights reserved.
//

#import "Floor.h"

@implementation Floor

const Vertex Vertices[] = {
    // Bottom
    {{1, 1, 1}, {1, 0}, {0, 1, 0}}, // 0
    {{1, 1, -1}, {1, 1}, {0, 1, 0}}, // 1
    {{-1, 1, -1}, {0, 1}, {0, 1, 0}}, // 2
    
    {{-1, 1, -1}, {0, 1}, {0, 1, 0}}, // 2
    {{-1, 1, 1}, {0, 0}, {0, 1, 0}}, // 3
    {{1, 1, 1}, {1, 0}, {0, 1, 0}}, // 0
};

- (instancetype)initWithShader:(GLKBaseEffect *)shader {
    
    if ((self = [super initWithName:"Floor" shader:shader
                           vertices:(Vertex *)Vertices
                        vertexCount:sizeof(Vertices) / sizeof(Vertices[0])])) {
        
        self.diffuseColor = GLKVector4Make(1, 1, 1, 1);
        self.specularColor = GLKVector4Make(1, 1, 1, 1);
        self.shininess = 10;
        self.scale = 10;
        
        [self loadTexture:@"Floor.jpg"];
    }
    return self;
}

- (void)updateWithDelta:(GLfloat)aDelta {
    //self.rotationZ += M_PI * aDelta;
}

@end
