//
//  SetCard.m
//  Matchismo
//
//  Created by Amy Bearman on 4/15/14.
//  Copyright (c) 2014 Amy Bearman. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

@synthesize symbol = _symbol;

- (BOOL)matchColors:(NSArray *)otherCards  {
    SetCard *card2 = [otherCards firstObject];
    SetCard *card3 = [otherCards objectAtIndex:1];
    if (((self.color == card2.color) && (self.color == card3.color) && (card2.color == card3.color)) || ((self.color != card2.color) && (self.color != card3.color) && (card2.color != card3.color))) {
        return true;
    }
    return false;
}

-(BOOL)matchSymbols:(NSArray *)otherCards {
    SetCard *card2 = [otherCards firstObject];
    SetCard *card3 = [otherCards objectAtIndex:1];
    if (([self.symbol isEqualToString:card2.symbol] && [self.symbol isEqualToString:card3.symbol] && [card2.symbol isEqualToString:card3.symbol]) ||
        (!([self.symbol isEqualToString:card2.symbol]) && !([self.symbol isEqualToString:card3.symbol]) && !([card2.symbol isEqualToString:card3.symbol]))) {
        return true;
    }
    return false;
}

-(BOOL)matchNumbers:(NSArray *)otherCards {
    SetCard *card2 = [otherCards firstObject];
    SetCard *card3 = [otherCards objectAtIndex:1];
    if (((self.number == card2.number) && (self.number == card3.number) && (card2.number == card3.number)) || ((self.number != card2.number) && (self.number != card3.number) && (card2.number != card3.number))) {
        return true;
    }
    return false;
}

-(BOOL)matchShadings:(NSArray *)otherCards {
    SetCard *card2 = [otherCards firstObject];
    SetCard *card3 = [otherCards objectAtIndex:1];
    if (((self.shading == card2.shading) && (self.shading == card3.shading) && (card2.shading == card3.shading)) || ((self.shading != card2.shading) && (self.shading != card3.shading) && (card2.shading != card3.shading))) {
        return true;
    }
    return false;
}

- (BOOL)areAllSameOrDifferent: (NSArray *)otherCards {
    if ([self matchColors:otherCards] && [self matchSymbols:otherCards] && [self matchNumbers:otherCards] && [self matchShadings:otherCards]) {
        return true;
    }
    return false;
}

/* Method to return the contents of the SetCard as an NSString */
- (NSString *)contents {
    NSString *color;
    if (self.color == 0) {
        color = @"red";
    } else if (self.color == 1) {
        color = @"green";
    } else if (self.color == 2) {
        color = @"purple";
    }
    
    NSString *shading;
    if (self.shading == 0) {
        shading = @"solid";
    } else if (self.shading == 1) {
        shading = @"striped";
    } else if (self.shading == 2) {
        shading = @"open";
    }
    
    NSString *symbols;
    if (self.number == 1) {
        symbols = self.symbol;
    } else if (self.number == 2) {
        symbols = [NSString stringWithFormat:@"%@%@", self.symbol, self.symbol];
    } else if (self.number == 3) {
        symbols = [NSString stringWithFormat:@"%@%@%@", self.symbol, self.symbol, self.symbol];
    }
    
    NSString *contents = [NSString stringWithFormat:@"%@ %@ %@", symbols, color, shading];
    return contents;
}
    
/* Match method that matches against 3 cards */
- (int) match:(NSArray *)otherCards {
    int score = 0;
    
    // Only check if there's a match if the user has clicked on 2 other cards
    if ([otherCards count] == 2) {
        SetCard *card1 = [otherCards firstObject];
        SetCard *card2 = [otherCards objectAtIndex:1];
        
        if ([self areAllSameOrDifferent:@[card1, card2]]) {
            score = 5;
        }
    }
    
    return score;
}

+ (NSArray *)validSymbols {
    return @[@"●", @"■", @"▲"];
}


/* Getter for symbol */
- (NSString *)symbol {
    return _symbol ? _symbol : @"?";
}

/* Setter for symbol */
- (void)setSymbol: (NSString *)symbol {
    if ([[SetCard validSymbols] containsObject:symbol]) {
        _symbol = symbol;
    }
}

@end
