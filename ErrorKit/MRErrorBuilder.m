// MRErrorBuilder.m
//
// Copyright (c) 2013 Héctor Marqués
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "MRErrorBuilder.h"
#import "NSError+ErrorKit.h"
#import "NSError_CoreData.h"
#import "NSError_AFNetworking.h"

#if  ! __has_feature(objc_arc)
#error This file must be compiled with ARC. Either turn on ARC for the project or use -fobjc-arc flag
#endif


NSString *const ErrorKitDomain = @"ErrorKitDomain";


@implementation MRErrorBuilder

+ (MRErrorBuilder *)builderWithError:(NSError *)error
{
    MRErrorBuilder *builder =
        [[self alloc] initWithDomain:error.domain
                                code:error.code
                            userInfo:error.userInfo];
    builder.failingURL = error.failingURL;
    builder.failingURLPeerTrust = error.failingURLPeerTrust;
    builder.failingURLString = error.failingURLString;
    builder.filePathError = error.filePathError;
    builder.helpAnchor = error.helpAnchor;
    builder.localizedDescription = error.localizedDescription;
    builder.localizedFailureReason = error.localizedFailureReason;
    builder.localizedRecoveryOptions = error.localizedRecoveryOptions;
    builder.localizedRecoverySuggestion = error.localizedRecoverySuggestion;
    builder.stringEncodingError = error.stringEncodingError;
    builder.recoveryAttempter = error.recoveryAttempter;
    builder.underlyingError = error.underlyingError;
    builder.urlError = error.urlError;
#ifdef _COREDATADEFINES_H
    builder.affectedObjects = error.affectedObjects;
    builder.affectedStores = error.affectedStores;
    builder.detailedErrors = error.detailedErrors;
    builder.persistentStoreSaveConflicts = error.persistentStoreSaveConflicts;
    builder.validationKey = error.validationKey;
    builder.validationObject = error.validationObject;
    builder.validationPredicate = error.validationPredicate;
    builder.validationValue = error.validationValue;
#endif
#ifdef _AFNETWORKING_
    builder.failingURLRequest = error.failingURLRequest;
    builder.failingURLResponse = error.failingURLResponse;
#endif
    return builder;
}

+ (MRErrorBuilder *)builderWithDomain:(NSString *)domain code:(NSInteger)code
{
    MRErrorBuilder *builder = [[self alloc] initWithDomain:ErrorKitDomain code:code userInfo:nil];
    return builder;
}

+ (MRErrorBuilder *)builderWithDomain:(NSString *)domain code:(NSInteger)code description:(NSString *)localizedDescription
{
    MRErrorBuilder *builder = [[self alloc] initWithDomain:ErrorKitDomain code:code userInfo:nil];
    builder.localizedDescription = localizedDescription;
    return builder;
}

- (MRErrorBuilder *)initWithDomain:(NSString *)domain code:(NSInteger)code userInfo:(NSDictionary *)userInfo;
{
    self = [super init];
    if (self) {
        self.domain = domain;
        self.code = code;
        if (userInfo) {
            _userInfo = userInfo.mutableCopy;
        } else {
            _userInfo = NSMutableDictionary.new;
        }
    }
    return self;
}

- (void)setUserInfoValue:(id)value forKey:(NSString *)key
{
    if (value) {
        [_userInfo setObject:value forKey:key];
    } else {
        [_userInfo removeObjectForKey:key];
    }
}

- (NSError *)error
{
    return [NSError errorWithDomain:self.domain
                               code:self.code
                           userInfo:self.userInfo];
}

#pragma mark Accessor methods

- (NSURL *)failingURL
{
    return [self.userInfo objectForKey:NSURLErrorFailingURLErrorKey];
}

- (void)setFailingURL:(NSURL *)failingURL
{
    [self setUserInfoValue:failingURL.copy forKey:NSURLErrorFailingURLErrorKey];
}

- (SecTrustRef)failingURLPeerTrust
{
    return (__bridge SecTrustRef)([self.userInfo objectForKey:NSURLErrorFailingURLPeerTrustErrorKey]);
}

- (void)setFailingURLPeerTrust:(SecTrustRef)failingURLPeerTrust
{
    [self setUserInfoValue:(__bridge id)failingURLPeerTrust forKey:NSURLErrorFailingURLPeerTrustErrorKey];
}

- (NSString *)failingURLString
{
    return [self.userInfo objectForKey:NSURLErrorFailingURLStringErrorKey];
}

- (void)setFailingURLString:(NSString *)failingURLString
{
    [self setUserInfoValue:failingURLString.copy forKey:NSURLErrorFailingURLStringErrorKey];
}

- (NSString *)filePathError
{
    return [self.userInfo objectForKey:NSFilePathErrorKey];
}

- (void)setFilePathError:(NSString *)filePathError
{
    [self setUserInfoValue:filePathError.copy forKey:NSFilePathErrorKey];
}

- (NSString *)helpAnchor
{
    return [self.userInfo objectForKey:NSHelpAnchorErrorKey];
}

- (void)setHelpAnchor:(NSString *)helpAnchor
{
    [self setUserInfoValue:helpAnchor.copy forKey:NSHelpAnchorErrorKey];
}

- (NSString *)localizedDescription
{
    return [self.userInfo objectForKey:NSLocalizedDescriptionKey];
}

- (void)setLocalizedDescription:(NSString *)localizedDescription
{
    [self setUserInfoValue:localizedDescription.copy forKey:NSLocalizedDescriptionKey];
}

- (NSString *)localizedFailureReason
{
    return [self.userInfo objectForKey:NSLocalizedFailureReasonErrorKey];
}

- (void)setLocalizedFailureReason:(NSString *)localizedFailureReason
{
    [self setUserInfoValue:localizedFailureReason.copy forKey:NSLocalizedFailureReasonErrorKey];
}

- (NSArray *)localizedRecoveryOptions
{
    return [self.userInfo objectForKey:NSLocalizedRecoveryOptionsErrorKey];
}

- (void)setLocalizedRecoveryOptions:(NSArray *)localizedRecoveryOptions
{
    [self setUserInfoValue:localizedRecoveryOptions.copy forKey:NSLocalizedRecoveryOptionsErrorKey];
}

- (NSString *)localizedRecoverySuggestion
{
    return [self.userInfo objectForKey:NSLocalizedRecoverySuggestionErrorKey];
}

- (void)setLocalizedRecoverySuggestion:(NSString *)localizedRecoverySuggestion
{
    [self setUserInfoValue:localizedRecoverySuggestion.copy forKey:NSLocalizedRecoverySuggestionErrorKey];
}

- (NSArray *)recoveryAttempter
{
    return [self.userInfo objectForKey:NSRecoveryAttempterErrorKey];
}

- (void)setRecoveryAttempter:(NSArray *)recoveryAttempter
{
    [self setUserInfoValue:recoveryAttempter forKey:NSRecoveryAttempterErrorKey];
}

- (NSStringEncoding)stringEncodingError
{
    return [(NSNumber *)[self.userInfo objectForKey:NSStringEncodingErrorKey] unsignedIntegerValue];
}

- (void)setStringEncodingError:(NSStringEncoding)stringEncodingError
{
    [self setUserInfoValue:@(stringEncodingError) forKey:NSStringEncodingErrorKey];
}

- (NSError *)underlyingError
{
    return [self.userInfo objectForKey:NSUnderlyingErrorKey];
}

- (void)setUnderlyingError:(NSError *)underlyingError
{
    [self setUserInfoValue:underlyingError.copy forKey:NSUnderlyingErrorKey];
}

- (NSURL *)urlError
{
    return [self.userInfo objectForKey:NSURLErrorKey];
}

- (void)setUrlError:(NSURL *)urlError
{
    [self setUserInfoValue:urlError.copy forKey:NSURLErrorKey];
}

#pragma mark -

#ifdef _COREDATADEFINES_H

- (NSArray *)affectedObjects
{
    return [self.userInfo objectForKey:NSAffectedObjectsErrorKey];
}

- (void)setAffectedObjects:(NSArray *)affectedObjects
{
    [self setUserInfoValue:affectedObjects.copy forKey:NSAffectedObjectsErrorKey];
}

- (NSArray *)affectedStores
{
    return [self.userInfo objectForKey:NSAffectedStoresErrorKey];
}

-(void)setAffectedStores:(NSArray *)affectedStores
{
    [self setUserInfoValue:affectedStores.copy forKey:NSAffectedStoresErrorKey];
}

- (NSArray *)detailedErrors
{
    return [self.userInfo objectForKey:NSDetailedErrorsKey];
}

- (void)setDetailedErrors:(NSArray *)detailedErrors
{
    [self setUserInfoValue:detailedErrors.copy forKey:NSDetailedErrorsKey];
}

- (NSArray *)persistentStoreSaveConflicts
{
    return [self.userInfo objectForKey:NSPersistentStoreSaveConflictsErrorKey];
}

- (void)setPersistentStoreSaveConflicts:(NSArray *)persistentStoreSaveConflicts
{
    [self setUserInfoValue:persistentStoreSaveConflicts.copy forKey:NSPersistentStoreSaveConflictsErrorKey];
}

- (NSString *)validationKey
{
    return [self.userInfo objectForKey:NSValidationKeyErrorKey];
}

- (void)setValidationKey:(NSString *)validationKey
{
    [self setUserInfoValue:validationKey.copy forKey:NSValidationKeyErrorKey];
}

- (NSManagedObject *)validationObject
{
    return [self.userInfo objectForKey:NSValidationObjectErrorKey];
}

- (void)setValidationObject:(NSManagedObject *)validationObject
{
    [self setUserInfoValue:validationObject forKey:NSValidationObjectErrorKey];
}

- (NSPredicate *)validationPredicate
{
    return [self.userInfo objectForKey:NSValidationPredicateErrorKey];
}

- (void)setValidationPredicate:(NSPredicate *)validationPredicate
{
    [self setUserInfoValue:validationPredicate.copy forKey:NSValidationPredicateErrorKey];
}

- (id)validationValue
{
    return [self.userInfo objectForKey:NSValidationValueErrorKey];
}

- (void)setValidationValue:(id)validationValue
{
    [self setUserInfoValue:validationValue forKey:NSValidationValueErrorKey];
}

#endif

#pragma mark -

#ifdef _AFNETWORKING_

- (NSURLRequest *)failingURLRequest
{
    return [self.userInfo objectForKey:AFNetworkingOperationFailingURLRequestErrorKey];
}

- (void)setFailingURLRequest:(NSURLRequest *)failingURLRequest
{
    [self setUserInfoValue:failingURLRequest.copy forKey:AFNetworkingOperationFailingURLRequestErrorKey];
}

- (NSHTTPURLResponse *)failingURLResponse
{
    return [self.userInfo objectForKey:AFNetworkingOperationFailingURLResponseErrorKey];
}

- (void)setFailingURLResponse:(NSHTTPURLResponse *)failingURLResponse
{
    [self setUserInfoValue:failingURLResponse.copy forKey:AFNetworkingOperationFailingURLResponseErrorKey];
}

#endif

@end