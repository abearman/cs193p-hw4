//
//  Deck.h
//  Matchismo
//
//  Created by Amy Bearman on 4/3/14.
//  Copyright (c) 2014 Amy Bearman. All rights reserved.
//

#import "Card.h"
#import <Foundation/Foundation.h>

@interface Deck : NSObject

- (void) addCard: (Card *)card atTop:(BOOL)atTop;
- (void) addCard: (Card *)card;

- (Card *) drawRandomCard;

@end
