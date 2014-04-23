//
//  Deck.m
//  Matchismo
//
//  Created by Amy Bearman on 4/3/14.
//  Copyright (c) 2014 Amy Bearman. All rights reserved.
//

#import "Deck.h"

@interface Deck()
@property (strong, nonatomic) NSMutableArray *cards; // of Card
@end

@implementation Deck

/*
 * Getter method for the NSMutableArray of Cards in the deck
 * Lazy instantiation of the NSMutableARray
 */
- (NSMutableArray *)cards {
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

/* 
 * Method to add a Card to the Deck, with boolean parameter atTop
 * which specifies whether or not the Card should be placed at the 
 * front of the array (index 0), or not.
 */
- (void) addCard:(Card *)card atTop:(BOOL)atTop {
    if (atTop) {
        [self.cards insertObject:card atIndex:0];
    } else {
        [self.cards addObject:card];
    }
}

/*
 * Method to add a Card to the Deck, with no position parameter specified,
 */
- (void) addCard:(Card *)card {
    [self addCard:card atTop:NO];
}

/* 
 * Method to retrieve and remove a random Card from the Deck
 */
- (Card *)drawRandomCard {
    Card *randomCard = nil;
    
    if ([self.cards count]) {
        unsigned index = arc4random() % [self.cards count];
        randomCard = self.cards[index];
        [self.cards removeObjectAtIndex:index];
    }
    
    return randomCard;
}

@end
