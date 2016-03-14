//
// Created by Nickolay Sheika on 25.11.15.
// Copyright (c) 2015 Alterplay. All rights reserved.
//

#import <objc/runtime.h>
#import "UITextField+APValidators.h"
#import "APValidator.h"



@implementation UITextField (APValidators)


#pragma mark - Lifecycle

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Accessors

- (APValidator *)validator
{
    return objc_getAssociatedObject(self, @selector(validator));
}

- (void)setValidator:(APValidator *)validator
{
    objc_setAssociatedObject(self, @selector(validator), validator, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

    validator.control = self;

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(__textFieldDidChange:)
                                                 name:UITextFieldTextDidChangeNotification
                                               object:self];
}

#pragma mark - Notifications

- (void)__textFieldDidChange:(NSNotification *)notification
{
    self.validator.validationObject = self.text;
    [self.validator validate];
}

@end