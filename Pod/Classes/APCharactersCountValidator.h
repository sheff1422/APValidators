//
// Created by Nickolay Sheika on 05.12.15.
// Copyright (c) 2015 Alterplay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APStringValidator.h"



@interface APCharactersCountValidator : APStringValidator


@property(nonatomic, assign) IBInspectable NSUInteger minCount;
@property(nonatomic, assign) IBInspectable NSUInteger maxCount;

@end