//
//  SetCardDeck.m
//  Matchismo
//
//  Created by Amy Bearman on 4/15/14.
//  Copyright (c) 2014 Amy Bearman. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

/*
 * Initializes a SetCardDeck full of SetCard's, by creating
 * the SetCard's 81 cards so that each SetCard has a
 * unique combination of number, symbol, shading, and color
 */
- (instancetype)init {
    self = [super init];
    if (self) {
        
        for (int shape = SQUIGGLE; shape <= OVAL; shape++) {
            for (int number = 1; number <= 3; number++) {
                for (int shading = SOLID; shading <= OPEN; shading++) {
                    for (int color = RED; color <= PURPLE; color++) {
                        SetCard *card = [[SetCard alloc] init];
                        card.shape = shape;
                        card.number = number;
                        card.shading = shading;
                        card.color = color;
                        [self addCard: card];
                    }
                }
            }

        }
    }
    return self;
}

@end
