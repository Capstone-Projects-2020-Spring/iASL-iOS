//
//  TCHChannel.h
//  Twilio Chat Client
//
//  Copyright (c) 2018 Twilio, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TCHConstants.h"

#import "TCHMessages.h"
#import "TCHMembers.h"
#import "TCHUser.h"

@class TwilioChatClient;
@protocol TCHChannelDelegate;

/** Representation of a chat channel. */
@interface TCHChannel : NSObject

/** Optional channel delegate.  Upon setting the delegate, you will receive the current channel synchronization status by delegate method. */
@property (nonatomic, weak, nullable) id<TCHChannelDelegate> delegate;

/** The unique identifier for this channel. */
@property (nonatomic, copy, readonly, nullable) NSString *sid;

/** The friendly name for this channel. */
@property (nonatomic, copy, readonly, nullable) NSString *friendlyName;

/** The unique name for this channel. */
@property (nonatomic, copy, readonly, nullable) NSString *uniqueName;

/** The messages list object for this channel. */
@property (nonatomic, strong, readonly, nullable) TCHMessages *messages;

/** The members list object for this channel. */
@property (nonatomic, strong, readonly, nullable) TCHMembers *members;

/** The channel's synchronization status. */
@property (nonatomic, assign, readonly) TCHChannelSynchronizationStatus synchronizationStatus;

/** The current user's status on this channel. */
@property (nonatomic, assign, readonly) TCHChannelStatus status;

/** The current user's notification level on this channel. This property reflects whether the
 user will receive push notifications for activity on this channel.*/
@property (nonatomic, assign, readonly) TCHChannelNotificationLevel notificationLevel;

/** The channel's visibility type. */
@property (nonatomic, assign, readonly) TCHChannelType type;

/** The timestamp the channel was created. */
@property (nonatomic, strong, readonly, nullable) NSString *dateCreated;

/** The timestamp the channel was created as an NSDate. */
@property (nonatomic, strong, readonly, nullable) NSDate *dateCreatedAsDate;

/** The identity of the channel's creator. */
@property (nonatomic, copy, readonly, nullable) NSString *createdBy;

/** The timestamp the channel was last updated. */
@property (nonatomic, strong, readonly, nullable) NSString *dateUpdated;

/** The timestamp the channel was last updated as an NSDate. */
@property (nonatomic, strong, readonly, nullable) NSDate *dateUpdatedAsDate;

/** The timestamp of the channel's most recent message. */
@property (nonatomic, strong, readonly, nullable) NSDate *lastMessageDate;

/** The index of the channel's most recent message. */
@property (nonatomic, strong, readonly, nullable) NSNumber *lastMessageIndex;

/** Return this channel's attributes.
 
 @return The developer-defined extensible attributes for this channel.
 */
- (nullable NSDictionary<NSString *, id> *)attributes;

/** Set this channel's attributes.
 
 @param attributes The new developer-defined extensible attributes for this channel. (Supported types are NSString, NSNumber, NSArray, NSDictionary and NSNull)
 @param completion Completion block that will specify the result of the operation.
 */
- (void)setAttributes:(nullable NSDictionary<NSString *, id> *)attributes
           completion:(nullable TCHCompletion)completion;

/** Set this channel's friendly name.
 
 @param friendlyName The new friendly name for this channel.
 @param completion Completion block that will specify the result of the operation.
 */
- (void)setFriendlyName:(nullable NSString *)friendlyName
             completion:(nullable TCHCompletion)completion;

/** Set this channel's unique name.
 
 @param uniqueName The new unique name for this channel.
 @param completion Completion block that will specify the result of the operation.
 */
- (void)setUniqueName:(nullable NSString *)uniqueName
           completion:(nullable TCHCompletion)completion;

/** Set the user's notification level for the channel.  This property determines whether the
 user will receive push notifications for activity on this channel.
 
 @param notificationLevel The new notification level for the current user on this channel.
 @param completion Completion block that will specify the result of the operation.
 */
- (void)setNotificationLevel:(TCHChannelNotificationLevel)notificationLevel
                  completion:(nullable TCHCompletion)completion;

/** Join the current user to this channel.
 
 @param completion Completion block that will specify the result of the operation.
 */
- (void)joinWithCompletion:(nullable TCHCompletion)completion;

/** Decline an invitation to this channel.
 
 @param completion Completion block that will specify the result of the operation.
 */
- (void)declineInvitationWithCompletion:(nullable TCHCompletion)completion;

/** Leave the current channel.
 
 @param completion Completion block that will specify the result of the operation.
 */
- (void)leaveWithCompletion:(nullable TCHCompletion)completion;

/** Destroy the current channel, removing all of its members.
 
 @param completion Completion block that will specify the result of the operation.
 */
- (void)destroyWithCompletion:(nullable TCHCompletion)completion;

/** Indicates to other users and the backend that the user is typing a message to this channel. */
- (void)typing;

/** Fetch the member object for the given identity if it exists.
 
 @param identity The username to fetch.
 @return The TCHMember object, if one exists for the username for this channel.
 */
- (nullable TCHMember *)memberWithIdentity:(nonnull NSString *)identity;

/** Fetch the number of unconsumed messages on this channel for the current user.
 
 Available even if the channel is not yet synchronized.

 This method is semi-realtime. This means that this data will be eventually correct,
 but will also possibly be incorrect for a few seconds. The Chat system does not
 provide real time events for counter values changes.

 So this is quite useful for any “unread messages count” badges, but is not recommended
 to build any core application logic based on these counters being accurate in real time.
 This function performs an async call to service to obtain up-to-date message count.
 
 The retrieved value is then cached for 5 seconds so there is no reason to call this
 function more often than once in 5 seconds.
 
 @param completion Completion block that will specify the requested count.  If no completion block is specified, no operation will be executed.
 */
- (void)getUnconsumedMessagesCountWithCompletion:(nonnull TCHCountCompletion)completion;

/** Fetch the number of messages on this channel.
 
 Available even if the channel is not yet synchronized.
 
 This method is semi-realtime. This means that this data will be eventually correct,
 but will also possibly be incorrect for a few seconds. The Chat system does not
 provide real time events for counter values changes.

 So this is quite useful for any UI badges, but is not recommended
 to build any core application logic based on these counters being accurate in real time.
 This function performs an async call to service to obtain up-to-date message count.
 
 The retrieved value is then cached for 5 seconds so there is no reason to call this
 function more often than once in 5 seconds.
 
 @param completion Completion block that will specify the requested count.  If no completion block is specified, no operation will be executed.
 */
- (void)getMessagesCountWithCompletion:(nonnull TCHCountCompletion)completion;

/** Fetch the number of members on this channel.
 
 Available even if the channel is not yet synchronized.
 
 This method is semi-realtime. This means that this data will be eventually correct,
 but will also possibly be incorrect for a few seconds. The Chat system does not
 provide real time events for counter values changes.

 So this is quite useful for any UI badges, but is not recommended
 to build any core application logic based on these counters being accurate in real time.
 This function performs an async call to service to obtain up-to-date message count.
 
 The retrieved value is then cached for 5 seconds so there is no reason to call this
 function more often than once in 5 seconds.
 
 @param completion Completion block that will specify the requested count.  If no completion block is specified, no operation will be executed.
 */
- (void)getMembersCountWithCompletion:(nonnull TCHCountCompletion)completion;

@end

/** This protocol declares the channel delegate methods. */
@protocol TCHChannelDelegate <NSObject>
@optional
/** Called when this channel is changed.
 
 @param client The chat client.
 @param channel The channel.
 @param updated An indication of what changed on the channel.
*/
- (void)chatClient:(nonnull TwilioChatClient *)client channel:(nonnull TCHChannel *)channel updated:(TCHChannelUpdate)updated;

/** Called when this channel is deleted.
 
 @param client The chat client.
 @param channel The channel.
 */
- (void)chatClient:(nonnull TwilioChatClient *)client channelDeleted:(nonnull TCHChannel *)channel;

/** Called when a channel the current the client is aware of changes synchronization state.
 
 @param client The chat client.
 @param channel The channel.
 @param status The current synchronization status of the channel.
 */
- (void)chatClient:(nonnull TwilioChatClient *)client channel:(nonnull TCHChannel *)channel synchronizationStatusUpdated:(TCHChannelSynchronizationStatus)status;

/** Called when this channel has a new member join.
 
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

/** Called when this channel has a member leave.
 
 @param client The chat client.
 @param channel The channel.
 @param member The member.
 */
- (void)chatClient:(nonnull TwilioChatClient *)client channel:(nonnull TCHChannel *)channel memberLeft:(nonnull TCHMember *)member;

/** Called when this channel receives a new message.
 
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

/** Called when this channel has a member's user updated.
 
 @param client The chat client.
 @param channel The channel.
 @param member The member.
 @param user The object for changed user.
 @param updated An indication of what changed on the user.
 */
- (void)chatClient:(nonnull TwilioChatClient *)client channel:(nonnull TCHChannel *)channel member:(nonnull TCHMember *)member user:(nonnull TCHUser *)user updated:(TCHUserUpdate)updated;

/** Called when the user associated with a member of this channel is subscribed to.
 
 @param client The chat client.
 @param channel The channel.
 @param member The member.
 @param user The object for subscribed user.
 */
- (void)chatClient:(nonnull TwilioChatClient *)client channel:(nonnull TCHChannel *)channel member:(nonnull TCHMember *)member userSubscribed:(nonnull TCHUser *)user;

/** Called when the user associated with a member of this channel is unsubscribed from.
 
 @param client The chat client.
 @param channel The channel.
 @param member The member.
 @param user The object for unsubscribed user.
 */
- (void)chatClient:(nonnull TwilioChatClient *)client channel:(nonnull TCHChannel *)channel member:(nonnull TCHMember *)member userUnsubscribed:(nonnull TCHUser *)user;

@end
