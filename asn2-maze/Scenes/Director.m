//
//  Director.m
//  asn2-maze
//
//  Created by Jason Sekhon on 2019-03-09.
//  Copyright © 2019 Jason Sekhon. All rights reserved.
//

#import "Director.h"
#import "Node.h"

@implementation Director

+ (instancetype)sharedInstance {
    static dispatch_once_t pred;
    static Director * _sharedInstance;
    dispatch_once(&pred, ^{ _sharedInstance = [[self alloc] init]; });
    return _sharedInstance;
}

- (instancetype)init {
    self = [super init];
    _mazeObject = [[mazeProcessor alloc] init];
    return self;
}

- (void)setScene:(Node *)scene {
    _scene = scene;
}

@end
