//
//  PlayingCardDeck.m
//  Matchismo
//
//  Created by Amy Bearman on 4/3/14.
//  Copyright (c) 2014 Amy Bearman. All rights reserved.
//

#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@implementation PlayingCardDeck

/* 
 * Initializes a PlayingCardDeck full of PlayingCards, by creating
 * the PlayingCard's (maxRank * number of valid suits) number of cards
 * so that each PlayingCard has a unique combination of suit and rank.
 */
- (instancetype)init {
    self = [super init];
    if (self) {
        for (NSString *suit in [PlayingCard validSuits]) {
            for (NSUInteger rank = 1; rank <= [PlayingCard maxRank]; rank++) {
                PlayingCard *card = [[PlayingCard alloc] init];
                card.rank = rank;
                card.suit = suit;
                [self addCard: card];
            }
        }
    }
    return self;
}

@end
