// NSError_FacebookSDK.h
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

#import "NSError+ErrorKit.h"


/**
 Adds getters for FBError `userInfo` values.
 
 @warning This extension requires the Facebook SDK framework. Add a `FacebookSDK.h` import to the header prefix of the project.
 */
@interface NSError (ErrorKit_FacebookSDK)

/// @name FacebookSDK error userInfo values

/// Getter for `FBErrorInnerErrorKey` user info value.
@property (nonatomic, readonly) NSError *innerError;

/// Getter for `FBErrorParsedJSONResponseKey` user info value.
@property (nonatomic, readonly) id parsedJSONResponse;

/// Getter for `FBErrorHTTPStatusCodeKey` user info value.
@property (nonatomic, readonly) NSInteger HTTPStatusCode;

/// Getter for `FBErrorSessionKey` user info value.
@property (nonatomic, readonly) FBSession *session;

/// Getter for `FBErrorLoginFailedReason` user info value.
@property (nonatomic, readonly) NSString *loginFailedReason;

/// Getter for `FBErrorNativeDialogReasonKey` user info value.
@property (nonatomic, readonly) NSString *nativeDialogReason;

/// Getter for `FBErrorInsightsReasonKey` user info value.
@property (nonatomic, readonly) NSString *insightsReason;

@end
