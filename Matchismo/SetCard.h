//
//  SetCard.h
//  Matchismo
//
//  Created by Amy Bearman on 4/15/14.
//  Copyright (c) 2014 Amy Bearman. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

// 4 properties:
@property (nonatomic) NSUInteger number;        // One, two, or three

typedef enum {
    SOLID,
    STRIPED,
    OPEN
} Shading;
@property (nonatomic) Shading shading;

typedef enum {
    RED,
    GREEN,
    PURPLE
} Color;
@property (nonatomic) Color color;

typedef enum {
    SQUIGGLE,
    DIAMOND,
    OVAL
} Shape;
@property (nonatomic) Shape shape;

@end
