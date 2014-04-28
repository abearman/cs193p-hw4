//
//  SetCard.m
//  Matchismo
//
//  Created by Amy Bearman on 4/15/14.
//  Copyright (c) 2014 Amy Bearman. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

- (BOOL)matchColors:(NSArray *)otherCards  {
    SetCard *card2 = [otherCards objectAtIndex:0];
    SetCard *card3 = [otherCards objectAtIndex:1];
    return ([self.color isEqual:card2.color] && [self.color isEqual:card3.color]) || (![self.color isEqual:card2.color] && ![self.color isEqual:card3.color] && ![card2.color isEqual:card3.color]);
}

-(BOOL)matchSymbols:(NSArray *)otherCards {
    SetCard *card2 = [otherCards objectAtIndex:0];
    SetCard *card3 = [otherCards objectAtIndex:1];
    return ((self.shape == card2.shape) && (self.shape == card3.shape)) || ((self.shape != card2.shape) && (self.shape != card3.shape) && (card2.shape != card3.shape));
}

-(BOOL)matchNumbers:(NSArray *)otherCards {
    SetCard *card2 = [otherCards objectAtIndex:0];
    SetCard *card3 = [otherCards objectAtIndex:1];
    return ((self.number == card2.number) && (self.number == card3.number)) || ((self.number != card2.number) && (self.number != card3.number) && (card2.number != card3.number));
}

-(BOOL)matchShadings:(NSArray *)otherCards {
    SetCard *card2 = [otherCards objectAtIndex:0];
    SetCard *card3 = [otherCards objectAtIndex:1];
    return ((self.shading == card2.shading) && (self.shading == card3.shading)) || ((self.shading != card2.shading) && (self.shading != card3.shading) && (card2.shading != card3.shading));
}

- (BOOL)areAllSameOrDifferent: (NSArray *)otherCards {
    return ([self matchColors:otherCards] && [self matchSymbols:otherCards] && [self matchNumbers:otherCards] && [self matchShadings:otherCards]);
}

// TODO
- (NSString *)contents {
    return nil;
}

+ (NSArray *)validColors {
    return @[[UIColor redColor], [UIColor greenColor], [UIColor purpleColor]];
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

@end