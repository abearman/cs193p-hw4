//
//  PlayingCard.m
//  Matchismo
//
//  Created by Amy Bearman on 4/3/14.
//  Copyright (c) 2014 Amy Bearman. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

/* Match method that matches against 2 cards */
- (int)match:(NSArray *)otherCards {
    int score = 0;
    
    // Only check if there's a match if the user has clicked on 1 other card
    if ([otherCards count] == 1) {
        PlayingCard *otherCard = [otherCards firstObject]; // Casts the first object in otherCards as a PlayingCard
        if (otherCard.rank == self.rank) {
            score = 4; // Four points for matching the rank
        } else if ([otherCard.suit isEqualToString:self.suit]) {
            score = 2; //2 points for matching the suit
        }
    }
    return score;
}

/* Method to return the contents of the PlayingCard (suit and rank) as an NSString */
- (NSString *)contents {
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit;

/* Returns an NSSArray of all valid suits for the PlayingCard */
+ (NSArray *)validSuits {
    return @[@"♣︎", @"♥︎", @"♦︎", @"♠︎"];
}

/* 
 * Sets the suit of the PlayingCard to be the specified suit NSString,
 * if it is a valid suit for the PlayingCard 
 */
- (void)setSuit: (NSString *)suit {
    if ([[PlayingCard validSuits] containsObject: suit]) {
        _suit = suit;
    }
}

/* Returns the suit of the PlayingCard if it is not nil, or @"?" otherwise */
- (NSString *)suit {
    return _suit ? _suit : @"?";
}

/* Returns all possible rank Strings of the PlayingCard as an NSArray */
+ (NSArray *)rankStrings {
    return @[@"?" ,@"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

/* Returns the integer value of the maximum possible rank of the PlayingCard */
+ (NSUInteger)maxRank {
    return [[self rankStrings] count] -1;
}

/* Sets the rank of the PlayingCard, if it is a valid rank 
 (is not greater than the PlayingCard's maximum rank) */
- (void) setRank:(NSUInteger)rank {
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

@end





