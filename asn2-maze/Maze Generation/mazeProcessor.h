//
//  mazeProcessor.h
//  asn2-maze
//
//  Created by Jason Sekhon on 2019-03-09.
//  Copyright © 2019 Jason Sekhon. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef struct Cell {
    BOOL northWallPresent, southWallPresent, eastWallPresent, westWallPresent;
} Cell;

@interface mazeProcessor : NSObject {
    @private
    struct mazeClass *mazeObject;
}


- (struct Cell)getCellAtRow:(int)row col:(int)col;
- (int)getRows;
- (int)getCols;

@end

NS_ASSUME_NONNULL_END
