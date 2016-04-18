//
//  APZipValidatorTests.m
//  APValidators
//
//  Created by Nickolay Sheika on 4/15/16.
//  Copyright (c) 2016 Nickolay Sheika. All rights reserved.
//



#import "APZipValidator.h"
#import "APRegexValidator.h"
#import "APCountryRegexProvider.h"
#import "APStringValidatorTestCase.h"



@interface APZipValidator (UnitTests)


@property(nonatomic, strong) APRegexValidator *regexValidator;
@end



@interface APZipValidatorTests : APStringValidatorTestCase


#pragma mark - SUT
@property(nonatomic, strong) APZipValidator *zipValidator;

#pragma mark - Mocks
@property(nonatomic, strong) id regexProviderMock;
@property(nonatomic, strong) id regexValidatorMock;
@end



@implementation APZipValidatorTests


- (void)setUp
{
    [super setUp];

    self.regexProviderMock = [OCMockObject niceMockForClass:[APCountryRegexProvider class]];
    self.regexValidatorMock = [OCMockObject niceMockForClass:[APRegexValidator class]];

    self.validator = [APZipValidator new];
    self.zipValidator = (APZipValidator *) self.validator;
    self.zipValidator.regexValidator = self.regexValidatorMock;
}

#pragma mark - Tests

- (void)testSetupsRegexValidatorWithProperRegex
{
    // given
    NSString *regexStub = @"14/88";
    NSString *countryCode = @"US";

    // stubs and mocks
    [[[self.regexProviderMock stub] andReturn:regexStub] regexForCountryWithCode:countryCode];
    [[self.regexValidatorMock expect] setRegex:regexStub];

    // call
    self.zipValidator.countryCode = countryCode;

    // expectations
    [self.regexValidatorMock verify];
}

- (void)testSetupsRegexValidatorWithNilRegexIfCountryCodeIsNotSupported
{
    // given
    NSString *countryCode = @"USA";

    // stubs and mocks
    [[[self.regexProviderMock stub] andReturn:nil] regexForCountryWithCode:countryCode];
    [[self.regexValidatorMock expect] setRegex:nil];

    // call
    self.zipValidator.countryCode = countryCode;

    // expectations
    [self.regexValidatorMock verify];
}

- (void)testNotValidIfCountryCodeIsNotSupported
{
    // given
    NSString *countryCode = @"USA";

    // stubs and mocks
    [[[self.regexProviderMock stub] andReturn:nil] regexForCountryWithCode:countryCode];
    [[[self.regexValidatorMock stub] andReturn:nil] regex];

    // call
    self.zipValidator.countryCode = countryCode;
    [self.zipValidator validate];

    // expectations
    expect(self.zipValidator.isValid).to.beFalsy();
}

- (void)testValidate
{
    // given
    NSString *regexStub = @"14/88";
    NSString *validationObject = @"ZIP";

    // stubs and mocks
    [[[self.regexProviderMock stub] andReturn:nil] regexForCountryWithCode:[OCMArg any]];
    [[[self.regexValidatorMock stub] andReturn:regexStub] regex];
    [[self.regexValidatorMock expect] setValidationObject:validationObject];
    [[self.regexValidatorMock expect] validate];
    [[[self.regexValidatorMock stub] andReturnValue:OCMOCK_VALUE(YES)] isValid];

    // call
    self.zipValidator.validationObject = validationObject;
    [self.zipValidator validate];

    // expectations
    [self.regexValidatorMock verify];
    expect(self.zipValidator.isValid).to.beTruthy();
}

@end
