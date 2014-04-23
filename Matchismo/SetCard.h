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
@property (strong, nonatomic) NSString *symbol; // Triangle, circle, or square
@property (nonatomic) NSUInteger shading;       // 0 for solid, 1 for striped, 2 for open
@property (nonatomic) NSUInteger color;         // 0 for red, 1 for green, 2 for purple

+ (NSArray *)validSymbols;

@end
