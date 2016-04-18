//
// Created by Nickolay Sheika on 3/16/16.
// Copyright (c) 2016 Nickolay Sheika. All rights reserved.
//

#import "APEqualValidator.h"
#import "APValidator+SubclassesOnly.h"



@implementation APEqualValidator


#pragma mark - Accessors

- (void)setSecondControl:(id)secondControl
{
    BOOL controlIsTextField = [secondControl isKindOfClass:[UITextField class]];
    BOOL controlIsTextView = [secondControl isKindOfClass:[UITextView class]];

    if (! controlIsTextField && ! controlIsTextView) {
        [NSException raise:NSInternalInconsistencyException
                    format:@"APValidators currently support only UITextField and UITextView controls."];
    }

    if ([secondControl isEqual:_secondControl]) {
        return;
    }

    _secondControl = secondControl;

    [[NSNotificationCenter defaultCenter] removeObserver:self];

    if (controlIsTextField) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(ap_textFieldDidChange:)
                                                     name:UITextFieldTextDidChangeNotification
                                                   object:secondControl];
    }

    if (controlIsTextView) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(ap_textViewDidChange:)
                                                     name:UITextViewTextDidChangeNotification
                                                   object:secondControl];
    }
}

#pragma mark - Lifecycle

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Notifications

- (void)ap_textFieldDidChange:(NSNotification *)notification
{

}

- (void)ap_textViewDidChange:(NSNotification *)notification
{
    [self validate];
}

#pragma mark - Override

- (void)validate
{
    if (! [self.validationObject isKindOfClass:[NSString class]]) {
        [NSException raise:NSInternalInconsistencyException
                    format:@"%@ validationObject should be NSString!",
                           NSStringFromClass([self class])];
    }

    self.valid = [((NSString *) self.validationObject) isEqualToString:((UITextField *)self.secondControl).text];
}


@end