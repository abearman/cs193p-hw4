//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Amy Bearman on 4/8/14.
//  Copyright (c) 2014 Amy Bearman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

//Designated initializer
- (instancetype)initWithCardCount:(NSUInteger)cardCount
                         usingDeck:(Deck *)deck;

- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;
- (BOOL)drawMoreCards:(NSUInteger)number;
- (NSUInteger)cardCount;
- (void)discardCards:(NSArray *)cards;

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic, readonly) NSMutableArray *lastCards;
@property (nonatomic, readonly) Deck *deck;
@property (nonatomic) int gameMode;

@end