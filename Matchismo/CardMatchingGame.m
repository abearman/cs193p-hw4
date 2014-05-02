//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Amy Bearman on 4/8/14.
//  Copyright (c) 2014 Amy Bearman. All rights reserved.
//

#import "CardMatchingGame.h"
#import "Card.h"
#import "PlayingCard.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards; // of Card
@property (nonatomic, readwrite) NSMutableArray *lastCards;
@property (nonatomic, readwrite) Deck *deck;

@end

@implementation CardMatchingGame

/* Lazy instantiation for the cards property */
- (NSMutableArray *)cards {
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

/* Lazy instantiation for the lastCards property */
- (NSMutableArray *)lastCards {
    if (!_lastCards) _lastCards = [[NSMutableArray alloc] init];
    return _lastCards;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (NSUInteger)cardCount {
    return [[self cards] count];
}

/* Guts of the algorithm for selecting and matching cards */
- (void)chooseCardAtIndex:(NSUInteger)index {
    
    // Don't let background clicks mess us up
    
    if (index >= [self cardCount]) return;
    
    [self.lastCards removeAllObjects]; // Clears the array of selected cards for this round
    Card *card = [self cardAtIndex:index]; // Retrieves the Card object corresponding to the card button clicked
    [self.lastCards addObject:card]; //Adds the initial clicked card to the array of selected cards
    
    // Only proceeds if the card has not already been matched
    if (!card.isMatched) {
        
        // If the card is already chosen, we'll "unchoose" it, by disabling it
        // No penalty to the score. We also clear the array of selected cards
        if (card.isChosen) {
            card.chosen = NO;
            [self.lastCards removeObject:card];
            
            // Otherwise, compare the selected card against other currently selected cards
        } else {
            
            // Stores the other selected AND unmatched cards in an array
            NSMutableArray *cardsToCompare = [NSMutableArray array];
            for (Card *otherCard in self.cards) {
                if (otherCard.isChosen && !otherCard.isMatched) {
                    [cardsToCompare addObject:otherCard];
                }
            }
            
            // Only checks for a match if there are "self.gameMode" number of selected cards
            if ([cardsToCompare count] - 1 == self.gameMode) {
                int matchScore = [card match:cardsToCompare];
                
                // Calculates the match bonus, and sets all selected cards as "matched"
                if (matchScore) {
                    self.score += matchScore * MATCH_BONUS;
                    card.matched = YES;
                    for (Card *otherCard in cardsToCompare) {
                        otherCard.matched = YES;
                    }
                    
                    // Calculates the mismatch penalty, and sets all selected cards as unchosen
                } else {
                    self.score -= MISMATCH_PENALTY;
                    for (Card *otherCard in cardsToCompare) {
                        otherCard.chosen = NO;
                    }
                }
                
                // Adds the other clicked cards to the array of selected cards for the controller to use
                [self.lastCards addObjectsFromArray:cardsToCompare];
            }
            if ([card isKindOfClass:[PlayingCard class]]) self.score -= COST_TO_CHOOSE; // Updates the score with the penalty of flipping over a card
            card.chosen = YES; // Sets the last card selected as "chosen", so it will stay flipped over
        }
    }
}

/* Helper method that returns the Card object corresponding to a given index in the cards array */
- (Card *)cardAtIndex: (NSUInteger)index {
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

/*
 * Designated initializer for CardMatchingGame that initializes the object with a given
 * number of cards and using the specified deck. Draws "count" number of cards from this deck
 */
- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(id)deck {
    self = [super init];
    self.deck = deck;
    
    if (self) {
        if (count >= 2) {
            for (int i = 0; i < count; i++) {
                Card *card = [deck drawRandomCard];
                if (card) {
                    [self.cards addObject:card];
                } else {
                    self = nil;
                    break;
                }
            }
        }
    }
    
    return self;
}

- (void)drawMoreCards:(NSUInteger)number {
    for (int i = 0; i < number; i++) {
        Card *card = [self.deck drawRandomCard];
        if (card) {
            [self.cards addObject:card];
        } else {
            break;
        }
    }
}

- (void)discardCards:(NSArray *)cards {
    [self.cards removeObjectsInArray:cards];
}

- (instancetype) init { //They can't call [[CardMatchingGame alloc] init]
    return nil; //Or raise an exception
}

@end