//
//  mazeProcessor.m
//  asn2-maze
//
//  Created by Jason Sekhon on 2019-03-09.
//  Copyright © 2019 Jason Sekhon. All rights reserved.
//

#import "mazeProcessor.h"
#import "maze.h"

struct mazeClass {
    Maze theObj;
};

@implementation mazeProcessor

- (id)init {
    self = [super init];
    if (self) {
        mazeObject = new mazeClass;
        mazeObject->theObj.Create();
    }
    return self;
}

- (struct Cell)getCellAtRow:(int)row col:(int)col {
    struct Cell cell;
    MazeCell mazeCell = mazeObject->theObj.GetCell(row, col);
    cell.eastWallPresent = mazeCell.eastWallPresent;
    cell.westWallPresent = mazeCell.westWallPresent;
    cell.southWallPresent = mazeCell.southWallPresent;
    cell.northWallPresent = mazeCell.northWallPresent;
    return cell;
}

- (int) getRows {
    return mazeObject->theObj.rows;
}

- (int) getCols {
    return mazeObject->theObj.cols;
}

@end
