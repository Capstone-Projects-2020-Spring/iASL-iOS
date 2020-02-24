//
//  TCHConstants.h
//  Twilio Chat Client
//
//  Copyright (c) 2018 Twilio, Inc. All rights reserved.
//

#import "TCHResult.h"

@class TwilioChatClient;
@class TCHChannels;
@class TCHChannel;
@class TCHMessage;
@class TCHChannelDescriptorPaginator;
@class TCHMemberPaginator;
@class TCHUser;
@class TCHUserDescriptor;
@class TCHUserDescriptorPaginator;

/** Client connection state. */
typedef NS_ENUM(NSInteger, TCHClientConnectionState) {
    TCHClientConnectionStateUnknown,        ///< Client connection state is not yet known.
    TCHClientConnectionStateDisconnected,   ///< Client is offline and no connection attempt in process.
    TCHClientConnectionStateConnected,      ///< Client is online and ready.
    TCHClientConnectionStateConnecting,     ///< Client is offline and connection attempt is in process.
    TCHClientConnectionStateDenied,         ///< Client connection is denied because of invalid token.
    TCHClientConnectionStateError           ///< Client connection is in the erroneous state.
};

/** The synchronization status of the client. */
typedef NS_ENUM(NSInteger, TCHClientSynchronizationStatus) {
    TCHClientSynchronizationStatusStarted = 0,               ///< Client synchronization has started.
    TCHClientSynchronizationStatusChannelsListCompleted,     ///< Channels list is available.
    TCHClientSynchronizationStatusCompleted,                 ///< All joined channels, their members and the requested number of messages are synchronized.
    TCHClientSynchronizationStatusFailed                     ///< Synchronization failed.
};

/** Enumeration indicating the client's logging level. */
typedef NS_ENUM(NSInteger, TCHLogLevel) {
    TCHLogLevelSilent = 0,       ///< Show no errors.
    TCHLogLevelFatal,            ///< Show fatal errors only.
    TCHLogLevelCritical,         ///< Show critical log messages as well as all Fatal log messages.
    TCHLogLevelWarning,          ///< Show warnings as well as all Critical log messages.
    TCHLogLevelInfo,             ///< Show informational messages as well as all Warning log messages.
    TCHLogLevelDebug,            ///< Show low-level debugging messages as well as all Info log messages.
    TCHLogLevelTrace             ///< Show low-level tracing messages as well as all Debug log messages.
};

/** Enumeration indicating the updates made to the TCHChannel object. */
typedef NS_ENUM(NSInteger, TCHChannelUpdate) {
    TCHChannelUpdateStatus = 1,                     ///< The user's status on this channel changed.
    TCHChannelUpdateLastConsumedMessageIndex,       ///< The user's last consumed message index on this channel changed.
    TCHChannelUpdateUniqueName,                     ///< The channel's unique name changed.
    TCHChannelUpdateFriendlyName,                   ///< The channel's friendly name changed.
    TCHChannelUpdateAttributes,                     ///< The channel's attributes changed.
    TCHChannelUpdateLastMessage,                    ///< The channel's last message changed.
    TCHChannelUpdateUserNotificationLevel           ///< The channel's user notification level changed.
};

/** Enumeration indicating the channel's current synchronization status with the server. */
typedef NS_ENUM(NSInteger, TCHChannelSynchronizationStatus) {
    TCHChannelSynchronizationStatusNone = 0,        ///< Channel not ready yet, local object only.
    TCHChannelSynchronizationStatusIdentifier,      ///< Channel SID is available.
    TCHChannelSynchronizationStatusMetadata,        ///< Channel SID, Friendly Name, Attributes and Unique Name are available.
    TCHChannelSynchronizationStatusAll,             ///< Channels, Members and Messages collections are ready to use.
    TCHChannelSynchronizationStatusFailed           ///< Channel synchronization failed.
};

/** Enumeration indicating the user's current status on a given channel. */
typedef NS_ENUM(NSInteger, TCHChannelStatus) {
    TCHChannelStatusInvited = 0,        ///< User is invited to the channel but not joined.
    TCHChannelStatusJoined,             ///< User is joined to the channel.
    TCHChannelStatusNotParticipating,   ///< User is not participating on this channel.
    TCHChannelStatusUnknown             ///< User's status on this channel is not known, used on instances of TCHChannelDescriptor. 
};

/** Enumeration indicating the channel's visibility. */
typedef NS_ENUM(NSInteger, TCHChannelType) {
    TCHChannelTypePublic = 0,        ///< Channel is publicly visible
    TCHChannelTypePrivate            ///< Channel is private and only visible to invited members.
};

/** Enumeration indicating the user's notification level on a channel. */
typedef NS_ENUM(NSInteger, TCHChannelNotificationLevel) {
    TCHChannelNotificationLevelDefault = 0,       ///< User will receive notifications for the channel if joined, nothing if unjoined.
    TCHChannelNotificationLevelMuted,             ///< User will not receive notifications for the channel.
};

/** Enumeration specifying the desired channel sorting criteria. */
typedef NS_ENUM(NSInteger, TCHChannelSortingCriteria) {
    TCHChannelSortingCriteriaLastMessage = 0,        ///< Order by most recent message.
    TCHChannelSortingCriteriaFriendlyName,           ///< Order by channel friendly name, case sensitive.
    TCHChannelSortingCriteriaUniqueName              ///< Order by channel unique name, case sensitive.
};

/** Enumeration specifying the desired channel sorting order. */
typedef NS_ENUM(NSInteger, TCHChannelSortingOrder) {
    TCHChannelSortingOrderAscending = 0,        ///< Results will be in ascending order.
    TCHChannelSortingOrderDescending            ///< Results will be in descending order.
};

/** Enumeration indicating the updates made to the TCHUser object. */
typedef NS_ENUM(NSInteger, TCHUserUpdate) {
    TCHUserUpdateFriendlyName = 0,        ///< The friendly name changed.
    TCHUserUpdateAttributes,              ///< The attributes changed.
    TCHUserUpdateReachabilityOnline,      ///< The user's online status changed.
    TCHUserUpdateReachabilityNotifiable   ///< The user's notifiability status changed.
};

/** Enumeration indicating the updates made to the TCHMember object. */
typedef NS_ENUM(NSInteger, TCHMemberUpdate) {
    TCHMemberUpdateLastConsumedMessageIndex = 0,        ///< The member's last consumed message index changed.
    TCHMemberUpdateAttributes = 1                       ///< The member's attributes changed.
};

/** Enumerations indicating the type of the TCHMember object. */
typedef NS_ENUM(NSInteger, TCHMemberType) {
    TCHMemberTypeUnset = 0, ///< The member's type is not initialized yet.
    TCHMemberTypeOther,     ///< The member's type is unknown for current SDK.
    TCHMemberTypeChat,      ///< The member's type is Chat.
    TCHMemberTypeSms,       ///< The member's type is SMS.
    TCHMemberTypeWhatsapp   ///< The member's type is WhatsApp.
};

/** Enumeration indicating the updates made to the TCHMessage object. */
typedef NS_ENUM(NSInteger, TCHMessageUpdate) {
    TCHMessageUpdateBody = 0,               ///< The message's body changed.
    TCHMessageUpdateAttributes              ///< The message's attributes changed.
};

/** Enumeration indicating the type of message - text or media. */
typedef NS_ENUM(NSInteger, TCHMessageType) {
    TCHMessageTypeText = 0,               ///< This message is a text message, containing a body.
    TCHMessageTypeMedia                   ///< This message is a media message with a media attachment.
};

/** Completion block which will indicate the TCHResult of the operation.
 
 @param result The result of the operation.
 */
typedef void (^TCHCompletion)(TCHResult * _Nonnull result);

/** Completion block which will indicate the TCHResult of the operation and your handle to the TwilioChatClient instance.
 
 @param result The result of the operation.
 @param chatClient The newly created chat client which you should create a strong reference to.
 */
typedef void (^TCHTwilioClientCompletion)(TCHResult * _Nonnull result, TwilioChatClient * _Nullable chatClient);

/** Completion block which will indicate the TCHResult of the operation and a public channels paginator.
 
 @param result The result of the operation.
 @param paginator The paged channel results, see also TCHChannelDescriptorPaginator.
 */
typedef void (^TCHChannelDescriptorPaginatorCompletion)(TCHResult * _Nonnull result, TCHChannelDescriptorPaginator * _Nullable paginator);

/** Completion block which will indicate the TCHResult of the operation and a channel members paginator.
 
 @param result The result of the operation.
 @param paginator The paged member results, see also TCHMemberPaginator.
 */
typedef void (^TCHMemberPaginatorCompletion)(TCHResult * _Nonnull result, TCHMemberPaginator * _Nullable paginator);

/** Completion block which will indicate the TCHResult of the operation and a channel.
 
 @param result The result of the operation.
 @param channel The channel returned by the operation.
 */
typedef void (^TCHChannelCompletion)(TCHResult * _Nonnull result, TCHChannel * _Nullable channel);

/** Completion block which will indicate the TCHResult of the operation and a message.
 
 @param result The result of the operation.
 @param message The message returned by the operation.
 */
typedef void (^TCHMessageCompletion)(TCHResult * _Nonnull result, TCHMessage * _Nullable message);

/** Completion block which will indicate the TCHResult of the operation and a list of messages.
 
 @param result The result of the operation.
 @param messages An array of messages returned by the operation.
 */
typedef void (^TCHMessagesCompletion)(TCHResult * _Nonnull result, NSArray<TCHMessage *> * _Nullable messages);

/** Completion block which will indicate the TCHResult of the operation and a user.
 
 @param result The result of the operation.
 @param user The user returned by the operation.
 */
typedef void (^TCHUserCompletion)(TCHResult * _Nonnull result, TCHUser * _Nullable user);

/** Completion block which will indicate the TCHResult of the operation and a user.
 
 @param result The result of the operation.
 @param user The user descriptor returned by the operation.
 */
typedef void (^TCHUserDescriptorCompletion)(TCHResult * _Nonnull result, TCHUserDescriptor * _Nullable user);

/** Completion block which will indicate the TCHResult of the operation and a public channels paginator.
 
 @param result The result of the operation.
 @param paginator The paged user descriptor results, see also TCHMemberPaginator.
 */
typedef void (^TCHUserDescriptorPaginatorCompletion)(TCHResult * _Nonnull result, TCHUserDescriptorPaginator * _Nullable paginator);

/** Completion block which will provide the requested count.
 
 @param result The result of the operation.
 @param count The requested count, provided the operation completed successfully.
 */
typedef void (^TCHCountCompletion)(TCHResult * _Nonnull result, NSUInteger count);

/** Block called upon start of the media operation.
 */
typedef void (^TCHMediaOnStarted)(void);

/** Block called with progress on the media operation.
 
 @param bytes The total number of bytes read or written so far by the operation.
 */
typedef void (^TCHMediaOnProgress)(NSUInteger bytes);

/** Block called upon successful completion of the operation with the media's sid.
 
 @param mediaSid The media's sid.
 */
typedef void (^TCHMediaOnCompleted)(NSString * _Nonnull mediaSid);

/** Channel creation options key for setting friendly name. */
FOUNDATION_EXPORT NSString *const _Nonnull TCHChannelOptionFriendlyName;

/** Channel creation options key for setting unqiue name. */
FOUNDATION_EXPORT NSString *const _Nonnull TCHChannelOptionUniqueName;

/** Channel creation options key for setting type.  Expected values are @(TCHChannelTypePublic) or @(TCHChannelTypePrivate) */
FOUNDATION_EXPORT NSString *const _Nonnull TCHChannelOptionType;

/** Channel creation options key for setting attributes.  Expected value is an NSDictionary* */
FOUNDATION_EXPORT NSString *const _Nonnull TCHChannelOptionAttributes;

/** The Twilio Chat error domain used as NSError's `domain`. */
FOUNDATION_EXPORT NSString *const _Nonnull TCHErrorDomain;

/** The errorCode specified when an error client side occurs without another specific error code. */
FOUNDATION_EXPORT NSInteger const TCHErrorGeneric;

/** The userInfo key for the error message, if any. */
FOUNDATION_EXPORT NSString *const _Nonnull TCHErrorMsgKey;
