//
//  SetCardView.h
//  Matchismo
//
//  Created by Amy Bearman on 4/27/14.
//  Copyright (c) 2014 Amy Bearman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardView.h"
#import "SetCard.h"

@interface SetCardView : CardView

@property (nonatomic) BOOL chosen;

// 4 properties of SetCard:
@property (nonatomic) NSUInteger number;        // One, two, or three

// These three use the enum declared in SetCard
@property (nonatomic) Shape shape; // squiggle, diamond, oval
@property (nonatomic) Shading shading; // solid, striped, open
@property (nonatomic) Color color; // red, green, purple

@end
