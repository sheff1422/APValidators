//
// Created by Nickolay Sheika on 3/15/16.
// Copyright (c) 2016 Nickolay Sheika. All rights reserved.
//

#import <objc/runtime.h>
#import "UITextView+APValidators.h"
#import "APValidator.h"



@implementation UITextView (APValidators)


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
    validator.validationObject = self.text;
    [validator validate];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(ap_textViewDidChange:)
                                                 name:UITextViewTextDidChangeNotification
                                               object:self];
}

#pragma mark - Notifications

- (void)ap_textViewDidChange:(NSNotification *)notification
{
    self.validator.validationObject = self.text;
    [self.validator validate];
}

@end