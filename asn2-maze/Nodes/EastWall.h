//
//  EastWall.h
//  asn2-maze
//
//  Created by Jason Sekhon on 2019-03-09.
//  Copyright © 2019 Jason Sekhon. All rights reserved.
//

#import "Node.h"

NS_ASSUME_NONNULL_BEGIN

@interface EastWall : Node

- (instancetype)initWithShader:
(GLKBaseEffect *)shader;

@end

NS_ASSUME_NONNULL_END
