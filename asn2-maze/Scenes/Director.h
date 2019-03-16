//
//  Director.h
//  asn2-maze
//
//  Created by Jason Sekhon on 2019-03-09.
//  Copyright © 2019 Jason Sekhon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>
#import "mazeProcessor.h"

@class Node;

NS_ASSUME_NONNULL_BEGIN

@interface Director : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic, strong) UIView *view;
@property (nonatomic, strong) Node *scene;
@property (nonatomic, strong) mazeProcessor *mazeObject;

@end

NS_ASSUME_NONNULL_END
