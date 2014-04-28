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
@property (nonatomic) NSUInteger number;        // one, two, three
@property (nonatomic, strong) UIColor *color; // red, green, purple

typedef enum {
    SOLID,
    STRIPED,
    OPEN
} Shading;
@property (nonatomic) Shading shading;

typedef enum {
    SQUIGGLE,
    DIAMOND,
    OVAL
} Shape;
@property (nonatomic) Shape shape;

+ (NSArray *)validColors;

@end
