//
// Created by Nickolay Sheika on 25.11.15.
// Copyright (c) 2015 Alterplay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APValidator.h"



@interface APCompoundValidator : APValidator


@property(nonatomic, strong) IBOutletCollection(APValidator) NSArray *validators;

@property(nonatomic, strong, readonly) NSArray *failedValidators;

@end



@interface APCompoundValidator (SubclassesOnly)


- (void)checkAllValidatorsAndUpdateState;

@end