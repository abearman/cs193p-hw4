//
//  SetCardView.m
//  Matchismo
//
//  Created by Amy Bearman on 4/27/14.
//  Copyright (c) 2014 Amy Bearman. All rights reserved.
//

#import "SetCardView.h"

@implementation SetCardView

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    double width = self.bounds.size.width;
    double height = self.bounds.size.height;
    double x = self.bounds.origin.x;
    double y = self.bounds.origin.y;
    
    double widthOfShape = width - (width * (2.0/7.0));
    double heightOfShape = height / 4.5;
    double xOfShape = x + (width / 7.0);
    
    if (self.number == 1) {
        double yOfShape = y + (height/2.0) - (heightOfShape/2.0);
        CGRect boundsOfShapes = CGRectMake(xOfShape, yOfShape, widthOfShape, heightOfShape);
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:boundsOfShapes cornerRadius:10.0];
        [[UIColor redColor] setFill];
        [[UIColor redColor] setStroke];
        
        [path stroke];
        [path fill];
        
    } else if (self.number == 2) {
        double yOfShape1 = y + (height/2.0) - ((2.33*heightOfShape)/2.0);
        double yOfShape2 = yOfShape1 + (1.33*heightOfShape);
        
        CGRect boundsOfShapes1 = CGRectMake(xOfShape, yOfShape1, widthOfShape, heightOfShape);
        CGRect boundsOfShapes2 = CGRectMake(xOfShape, yOfShape2, widthOfShape, heightOfShape);
        UIBezierPath *path1 = [UIBezierPath bezierPathWithRoundedRect:boundsOfShapes1 cornerRadius:10.0];
        UIBezierPath *path2 = [UIBezierPath bezierPathWithRoundedRect:boundsOfShapes2 cornerRadius:10.0];
        
        [[UIColor redColor] setFill];
        [[UIColor redColor] setStroke];
        
        [path1 fill];
        [path2 fill];
        
    } else if (self.number == 3) {
        double yOfShape1 = (height/2.0) - ((3.67*heightOfShape)/2.0);
        double yOfShape2 = yOfShape1 + (1.33*heightOfShape);
        double yOfShape3 = yOfShape2 + (1.33*heightOfShape);
        
        CGRect boundsOfShapes1 = CGRectMake(xOfShape, yOfShape1, widthOfShape, heightOfShape);
        CGRect boundsOfShapes2 = CGRectMake(xOfShape, yOfShape2, widthOfShape, heightOfShape);
        CGRect boundsOfShapes3 = CGRectMake(xOfShape, yOfShape3, widthOfShape, heightOfShape);
        UIBezierPath *path1 = [UIBezierPath bezierPathWithRoundedRect:boundsOfShapes1 cornerRadius:10.0];
        UIBezierPath *path2 = [UIBezierPath bezierPathWithRoundedRect:boundsOfShapes2 cornerRadius:10.0];
        UIBezierPath *path3 = [UIBezierPath bezierPathWithRoundedRect:boundsOfShapes3 cornerRadius:10.0];
        
        [[UIColor redColor] setFill];
        [[UIColor redColor] setStroke];
        
        [path1 fill];
        [path2 fill];
        [path3 fill];
    }
}

- (UIBezierPath *)drawOval {
    return nil;
}

//////////////////////////////////////

#pragma mark Properties

- (void)setShape:(Shape)shape {
    _shape = shape;
    [self setNeedsDisplay];
}

- (void)setShading:(Shading)shading {
    _shading = shading;
    [self setNeedsDisplay];
}

- (void)setColor:(UIColor *)color {
    _color = color;
    [self setNeedsDisplay];
}

-(void)setNumber:(NSUInteger)number {
    _number = number;
}

@end
