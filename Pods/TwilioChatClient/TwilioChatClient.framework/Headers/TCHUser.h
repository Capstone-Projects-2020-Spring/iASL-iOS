//
//  TCHUser.h
//  Twilio Chat Client
//
//  Copyright (c) 2018 Twilio, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TCHConstants.h"

/** User information for the current user and other channel members. */
@interface TCHUser : NSObject

/** The identity for this user. */
@property (nonatomic, copy, readonly, nullable) NSString *identity;

/** The friendly name for this user. */
@property (nonatomic, copy, readonly, nullable) NSString *friendlyName;

/** Return this user's attributes.
 
 @return The developer-defined extensible attributes for this user.
 */
- (nullable NSDictionary<NSString *, id> *)attributes;

/** Set this user's attributes.
 
 @param attributes The new developer-defined extensible attributes for this user. (Supported types are NSString, NSNumber, NSArray, NSDictionary and NSNull)
 @param completion Completion block that will specify the result of the operation.
 */
- (void)setAttributes:(nullable NSDictionary<NSString *, id> *)attributes
           completion:(nullable TCHCompletion)completion;

/** Set this user's friendly name.
 
 @param friendlyName The new friendly name for this user.
 @param completion Completion block that will specify the result of the operation.
 */
- (void)setFriendlyName:(nullable NSString *)friendlyName
             completion:(nullable TCHCompletion)completion;

/** Indicates whether the user is online.  Note that if TwilioChatClient indicates reachability is not enabled, this will return NO.
 
 @return YES if the user is online.
 */
- (BOOL)isOnline;

/** Indicates whether the user is notifiable.  Note that if TwilioChatClient indicates reachability is not enabled, this will return NO.
 
 @return YES if the user is notifiable.
 */
- (BOOL)isNotifiable;

/** Indicates if the User is currently subscribed.  User objects which are no longer subscribed will not receive updates and will return nil or Unavailable for their values.
 
 @return YES if the user object is subscribed.
 */
- (BOOL)isSubscribed;

/** Manually unsubscribes this user object.  It will no longer receive updates from the Chat backend. 
 */
- (void)unsubscribe;

@end
