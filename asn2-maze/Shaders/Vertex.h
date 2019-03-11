//
//  Vertex.h
//  asn2-maze
//
//  Created by Jason Sekhon on 2019-03-09.
//  Copyright © 2019 Jason Sekhon. All rights reserved.
//
#import <OpenGLES/ES2/glext.h>

typedef enum {
    VertexAttribPosition = 0,
} VertexAttributes;

typedef struct {
    float Position[3];
    float TexCoord[2];
    float Normal[3];
} Vertex;
