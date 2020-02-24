//
//  TwilioChatClient.h
//  Twilio Chat Client
//
//  Copyright (c) 2018 Twilio, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TCHConstants.h"
#import "TCHError.h"
#import "TCHChannels.h"
#import "TCHChannel.h"
#import "TCHChannelDescriptor.h"
#import "TCHChannelDescriptorPaginator.h"
#import "TCHMessages.h"
#import "TCHMessage.h"
#import "TCHMessageOptions.h"
#import "TCHMember.h"
#import "TCHMemberPaginator.h"
#import "TCHUsers.h"
#import "TCHUser.h"
#import "TCHUserDescriptor.h"
#import "TCHUserDescriptorPaginator.h"

@class TwilioChatClientProperties;
@protocol TwilioChatClientDelegate;

/** Represents a chat client connection to Twilio. */
@interface TwilioChatClient : NSObject

/** Messaging client delegate */
@property (nonatomic, weak, nullable) id<TwilioChatClientDelegate> delegate;

/** The logged in user in the chat system. */
@property (nonatomic, strong, readonly, nullable) TCHUser *user;

/** The client's current connection state. */
@property (nonatomic, assign, readonly) TCHClientConnectionState connectionState;

/** The current client synchronization state. */
@property (nonatomic, assign, readonly) TCHClientSynchronizationStatus synchronizationStatus;

/** Sets the logging level for the client. 
 
 @param logLevel The new log level.
 */
+ (void)setLogLevel:(TCHLogLevel)logLevel;

/** The logging level for the client. 
 
 @return The log level.
 */
+ (TCHLogLevel)logLevel;

/** Initialize a new chat client instance.
 
 @param token The client access token to use when communicating with Twilio.
 @param properties The properties to initialize the client with, if this is nil defaults will be used.
 @param delegate Delegate conforming to TwilioChatClientDelegate for chat client lifecycle notifications.
 @param completion Completion block that will specify the result of the operation and a reference to the new TwilioChatClient.
 */
+ (void)chatClientWithToken:(nonnull NSString *)token
                 properties:(nullable TwilioChatClientProperties *)properties
                   delegate:(nullable id<TwilioChatClientDelegate>)delegate
                 completion:(nonnull TCHTwilioClientCompletion)completion;

/** Returns the name of the SDK for diagnostic purposes.
 
 @return An identifier for the Chat SDK.
 */
+ (nonnull NSString *)sdkName;

/** Returns the version of the SDK
 
 @return The chat client version.
 */
+ (nonnull NSString *)sdkVersion;

/** Returns the version of the SDK
 
 @return The chat client version.
 @deprecated Please see the class method sdkVersion.
 */
- (nonnull NSString *)version __attribute__((deprecated("Instance method version is deprecated, please see the class method sdkVersion.")));

/** Updates the access token currently being used by the client.
 
 @param token The updated client access token to use when communicating with Twilio.
 @param completion Completion block that will specify the result of the operation.
 */
- (void)updateToken:(nonnull NSString *)token
         completion:(nullable TCHCompletion)completion;

/** List of channels available to the current user.
 
 This will be nil until the client is fully initialized, see the client delegate callback `chatClient:synchronizationStatusUpdated:`
 
 @return The channelsList object.
 */
- (nullable TCHChannels *)channelsList;

/** Provides access to the TCHUsers class to obtain user descriptors and subscribed users.
 
 @return The users object.
 */
- (nullable TCHUsers *)users;

/** Register APNS token for push notification updates.
 
 @param token The APNS token which usually comes from `didRegisterForRemoteNotificationsWithDeviceToken`.
 @param completion Completion block that will specify the result of the operation.
 */
- (void)registerWithNotificationToken:(nonnull NSData *)token
                           completion:(nullable TCHCompletion)completion;

/** De-register from push notification updates.
 
 @param token The APNS token which usually comes from `didRegisterForRemoteNotificationsWithDeviceToken`.
 @param completion Completion block that will specify the result of the operation.
 */
- (void)deregisterWithNotificationToken:(nonnull NSData *)token
                             completion:(nullable TCHCompletion)completion;

/** Queue the incoming notification with the messaging library for processing - notifications usually arrive from `didReceiveRemoteNotification`.
 
 @param notification The incomming notification.
 @param completion Completion block that will specify the result of the operation.
 */
- (void)handleNotification:(nonnull NSDictionary *)notification
                completion:(nullable TCHCompletion)completion;

/** Indicates whether reachability is enabled for this instance.
 
 @return YES if reachability is enabled.
 */
- (BOOL)isReachabilityEnabled;

/** Cleanly shut down the messaging subsystem when you are done with it. */
- (void)shutdown;

@end

#pragma mark -

/** Optional chat client initialization properties. */
@interface TwilioChatClientProperties : NSObject

@property (nonatomic, copy, nonnull) NSString *region;

@end

#pragma mark -

/** This protocol declares the chat client delegate methods. */
@protocol TwilioChatClientDelegate <NSObject>
@optional

/** Called when the client connection state changes.
 
 @param client The chat client.
 @param state The current connection state of the client.
 */
- (void)chatClient:(nonnull TwilioChatClient *)client connectionStateUpdated:(TCHClientConnectionState)state;

/**
 Called when the client's token has expired.
 
 In response, your delegate should generate a new token and call
 `chatClient:updateToken:completion:` immediately as connection to
 the server has been lost.
 
 @param client The chat client.
 */
- (void)chatClientTokenExpired:(nonnull TwilioChatClient *)client;

/**
 Called when the client's token will expire soon.
 
 In response, your delegate should generate a new token and call
 `chatClient:updateToken:completion:` as soon as possible.
 
 @param client The chat client.
 */
- (void)chatClientTokenWillExpire:(nonnull TwilioChatClient *)client;

/** Called when the client synchronization state changes during startup.
 
 @param client The chat client.
 @param status The current synchronization status of the client.
 */
- (void)chatClient:(nonnull TwilioChatClient *)client synchronizationStatusUpdated:(TCHClientSynchronizationStatus)status;

/** Called when the current user has a channel added to their channel list.
 
 @param client The chat client.
 @param channel The channel.
 */
- (void)chatClient:(nonnull TwilioChatClient *)client channelAdded:(nonnull TCHChannel *)channel;

/** Called when one of the current users channels is changed.
 
 @param client The chat client.
 @param channel The channel.
 @param updated An indication of what changed on the channel.
 */
- (void)chatClient:(nonnull TwilioChatClient *)client channel:(nonnull TCHChannel *)channel updated:(TCHChannelUpdate)updated;

/** Called when a channel the current the client is aware of changes synchronization state.
 
 @param client The chat client.
 @param channel The channel.
 @param status The current synchronization status of the channel.
 */
- (void)chatClient:(nonnull TwilioChatClient *)client channel:(nonnull TCHChannel *)channel synchronizationStatusUpdated:(TCHChannelSynchronizationStatus)status;

/** Called when one of the current users channels is deleted.
 
 @param client The chat client.
 @param channel The channel.
 */
- (void)chatClient:(nonnull TwilioChatClient *)client channelDeleted:(nonnull TCHChannel *)channel;

/** Called when a channel the current user is subscribed to has a new member join.
 
 @param client The chat client.
 @param channel The channel.
 @param member The member.
 */
- (void)chatClient:(nonnull TwilioChatClient *)client channel:(nonnull TCHChannel *)channel memberJoined:(nonnull TCHMember *)member;

/** Called when a channel the current user is subscribed to has a member modified.
 
 @param client The chat client.
 @param channel The channel.
 @param member The member.
 @param updated An indication of what changed on the member.
 */
- (void)chatClient:(nonnull TwilioChatClient *)client channel:(nonnull TCHChannel *)channel member:(nonnull TCHMember *)member updated:(TCHMemberUpdate)updated;

/** Called when a channel the current user is subscribed to has a member leave.
 
 @param client The chat client.
 @param channel The channel.
 @param member The member.
 */
- (void)chatClient:(nonnull TwilioChatClient *)client channel:(nonnull TCHChannel *)channel memberLeft:(nonnull TCHMember *)member;

/** Called when a channel the current user is subscribed to receives a new message.
 
 @param client The chat client.
 @param channel The channel.
 @param message The message.
 */
- (void)chatClient:(nonnull TwilioChatClient *)client channel:(nonnull TCHChannel *)channel messageAdded:(nonnull TCHMessage *)message;

/** Called when a message on a channel the current user is subscribed to is modified.
 
 @param client The chat client.
 @param channel The channel.
 @param message The message.
 @param updated An indication of what changed on the message.
 */
- (void)chatClient:(nonnull TwilioChatClient *)client channel:(nonnull TCHChannel *)channel message:(nonnull TCHMessage *)message updated:(TCHMessageUpdate)updated;

/** Called when a message on a channel the current user is subscribed to is deleted.
 
 @param client The chat client.
 @param channel The channel.
 @param message The message.
 */
- (void)chatClient:(nonnull TwilioChatClient *)client channel:(nonnull TCHChannel *)channel messageDeleted:(nonnull TCHMessage *)message;

/** Called when an error occurs.
 
 @param client The chat client.
 @param error The error.
 */
- (void)chatClient:(nonnull TwilioChatClient *)client errorReceived:(nonnull TCHError *)error;

/** Called when a member of a channel starts typing.
 
 @param client The chat client.
 @param channel The channel.
 @param member The member.
 */
- (void)chatClient:(nonnull TwilioChatClient *)client typingStartedOnChannel:(nonnull TCHChannel *)channel member:(nonnull TCHMember *)member;

/** Called when a member of a channel ends typing.
 
 @param client The chat client.
 @param channel The channel.
 @param member The member.
 */
- (void)chatClient:(nonnull TwilioChatClient *)client typingEndedOnChannel:(nonnull TCHChannel *)channel member:(nonnull TCHMember *)member;

/** Called as a result of TwilioChatClient's handleNotification: method being invoked for a new message received notification.  `handleNotification:` parses the push payload and extracts the new message's channel and index for the push notification then calls this delegate method.
 
 @param client The chat client.
 @param channelSid The channel sid for the new message.
 @param messageIndex The index of the new message.
 */
- (void)chatClient:(nonnull TwilioChatClient *)client notificationNewMessageReceivedForChannelSid:(nonnull NSString *)channelSid messageIndex:(NSUInteger)messageIndex;

/** Called as a result of TwilioChatClient's handleNotification: method being invoked for an added to channel notification.  `handleNotification:` parses the push payload and extracts the channel for the push notification then calls this delegate method.
 
 @param client The chat client.
 @param channelSid The channel sid for the newly added channel.
 */
- (void)chatClient:(nonnull TwilioChatClient *)client notificationAddedToChannelWithSid:(nonnull NSString *)channelSid;

/** Called as a result of TwilioChatClient's handleNotification: method being invoked for an invited to channel notification.  `handleNotification:` parses the push payload and extracts the channel for the push notification then calls this delegate method.

 @param client The chat client.
 @param channelSid The channel sid for the newly invited channel.
 */
- (void)chatClient:(nonnull TwilioChatClient *)client notificationInvitedToChannelWithSid:(nonnull NSString *)channelSid;

/** Called as a result of TwilioChatClient's handleNotification: method being invoked for a removed from channel notification.  `handleNotification:` parses the push payload and extracts the channel for the push notification then calls this delegate method.

 @param client The chat client.
 @param channelSid The channel sid for the removed channel.
 */
- (void)chatClient:(nonnull TwilioChatClient *)client notificationRemovedFromChannelWithSid:(nonnull NSString *)channelSid;

/** Called when a processed push notification has changed the application's badge count.  You should call:
 
    [[UIApplication currentApplication] setApplicationIconBadgeNumber:badgeCount]
 
 Please note that badge count indicates the number of 1:1 (2 member only) channels that have unread messages.  This will not reflect total unread message count or channels with more than 2 members.
 
 To ensure your application's badge updates when the application is in the foreground if Twilio is managing your badge counts.  You may disregard this delegate callback otherwise.
 
 @param client The chat client.
 @param badgeCount The updated badge count.
 */
- (void)chatClient:(nonnull TwilioChatClient *)client notificationUpdatedBadgeCount:(NSUInteger)badgeCount;

/** Called when the current user's or that of any subscribed channel member's user is updated.
 
 @param client The chat client.
 @param user The object for changed user.
 @param updated An indication of what changed on the user.
 */
- (void)chatClient:(nonnull TwilioChatClient *)client user:(nonnull TCHUser *)user updated:(TCHUserUpdate)updated;

/** Called when the client subscribes to updates for a given user.
 
 @param client The chat client.
 @param user The object for subscribed user.
 */
- (void)chatClient:(nonnull TwilioChatClient *)client userSubscribed:(nonnull TCHUser *)user;

/** Called when the client unsubscribes from updates for a given user.
 
 @param client The chat client.
 @param user The object for unsubscribed user.
 */
- (void)chatClient:(nonnull TwilioChatClient *)client userUnsubscribed:(nonnull TCHUser *)user;

@end
