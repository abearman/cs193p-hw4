//
//  Card.m
//  Matchismo
//
//  Created by Amy Bearman on 4/3/14.
//  Copyright (c) 2014 Amy Bearman. All rights reserved.
//

#import "Card.h"

@implementation Card : NSObject

/*
 * Method to determine if two Cards are a match
 */
- (int) match: (NSArray *)otherCards {
    int score = 0;
    
    for (Card *card in otherCards) {
        if ([card.contents isEqualToString: self.contents]) {
            score = 1;
        }
    }
    
    return score;
}

@end
