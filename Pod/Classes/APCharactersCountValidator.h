//
// Created by Nickolay Sheika on 05.12.15.
// Copyright (c) 2015 Alterplay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APValidator.h"



@interface APCharactersCountValidator : APValidator


@property(nonatomic, assign) IBInspectable NSUInteger minCount;
@property(nonatomic, assign) IBInspectable NSUInteger maxCount;

@end