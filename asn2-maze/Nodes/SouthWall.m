//
//  SouthWall.m
//  asn2-maze
//
//  Created by Jason Sekhon on 2019-03-09.
//  Copyright © 2019 Jason Sekhon. All rights reserved.
//

#import "SouthWall.h"

@implementation SouthWall

const Vertex Vertices3[] = {
    // Front
    {{1, -1, 1}, {1, 0}, {0, 0, 1}}, // 0
    {{1, 1, 1}, {1, 1}, {0, 0, 1}}, // 1
    {{-1, 1, 1}, {0, 1}, {0, 0, 1}}, // 2
    
    {{-1, 1, 1}, {0, 1}, {0, 0, 1}}, // 2
    {{-1, -1, 1}, {0, 0}, {0, 0, 1}}, // 3
    {{1, -1, 1}, {1, 0}, {0, 0, 1}}, // 0
};

- (instancetype)initWithShader:(GLKBaseEffect *)shader {
    
    if ((self = [super initWithName:"SouthWall" shader:shader
                           vertices:(Vertex *)Vertices3
                        vertexCount:sizeof(Vertices3) / sizeof(Vertices3[0])])) {
        
        self.diffuseColor = GLKVector4Make(1, 1, 1, 1);
        self.specularColor = GLKVector4Make(1, 1, 1, 1);
        self.shininess = 10;
        self.scale = 10;
        
        [self loadTexture:@"SouthWall.jpg"];
    }
    return self;
}

- (void)updateWithDelta:(GLfloat)aDelta {
    //self.rotationZ += M_PI * aDelta;
}


@end
