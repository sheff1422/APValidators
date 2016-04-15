//
// Created by Nickolay Sheika on 3/15/16.
// Copyright (c) 2016 Nickolay Sheika. All rights reserved.
//

#import "APRequiredValidator.h"


@implementation APRequiredValidator


- (void)validate
{
    [super validate];

    APCharactersCountValidator *charactersCountValidator = [APCharactersCountValidator new];
    charactersCountValidator.minCount = 1;
    charactersCountValidator.validationObject = self.validationObject;
    [charactersCountValidator validate];

    self.valid = charactersCountValidator.isValid;
}


@end