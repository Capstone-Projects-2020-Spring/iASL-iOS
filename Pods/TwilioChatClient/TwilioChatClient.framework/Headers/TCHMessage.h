//
//  TCHMessage.h
//  Twilio Chat Client
//
//  Copyright (c) 2018 Twilio, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TCHConstants.h"

@class TCHMember;

/** Representation of a Message on a chat channel. */
@interface TCHMessage : NSObject

/** The unique identifier for this message. */
@property (nonatomic, copy, readonly, nullable) NSString *sid;

/** Index of Message in the Channel's messages stream. */
@property (nonatomic, copy, readonly, nullable) NSNumber *index;

/** The identity of the author of the message. */
@property (nonatomic, copy, readonly, nullable) NSString *author;

/** The body of the message. */
@property (nonatomic, copy, readonly, nullable) NSString *body;

/** The type of the message. */
@property (nonatomic, assign, readonly) TCHMessageType messageType;

/** The media sid if this message has a multimedia attachment, otherwise nil. */
@property (nonatomic, copy, readonly, nullable) NSString *mediaSid;

/** The size of the attached media if present, otherwise 0. */
@property (nonatomic, assign, readonly) NSUInteger mediaSize;

/** The mime type of the attached media if present and specified at creation, otherwise nil. */
@property (nonatomic, copy, readonly, nullable) NSString *mediaType;

/** The suggested filename the attached media if present and specified at creation, otherwise nil. */
@property (nonatomic, copy, readonly, nullable) NSString *mediaFilename;

/** The SID of the member this message is sent by. */
@property (nonatomic, copy, readonly, nullable) NSString *memberSid;

/** The member this message is sent by. */
@property (nonatomic, copy, readonly, nullable) TCHMember *member;

/** The creation timestamp of the message. */
@property (nonatomic, copy, readonly, nullable) NSString *timestamp;

/** The creation timestamp of the message as an NSDate. */
@property (nonatomic, strong, readonly, nullable) NSDate *timestampAsDate;

/** The timestamp the message was last updated. */
@property (nonatomic, copy, readonly, nullable) NSString *dateUpdated;

/** The timestamp the message was last updated as an NSDate. */
@property (nonatomic, strong, readonly, nullable) NSDate *dateUpdatedAsDate;

/** The identity of the user who last updated the message. */
@property (nonatomic, copy, readonly, nullable) NSString *lastUpdatedBy;

/** Update the body of this message
 
 @param body The new body for this message.
 @param completion Completion block that will specify the result of the operation.
 */
- (void)updateBody:(nonnull NSString *)body
        completion:(nullable TCHCompletion)completion;

/** Return this message's attributes.
 
 @return The developer-defined extensible attributes for this message.
 */
- (nullable NSDictionary<NSString *, id> *)attributes;

/** Set this message's attributes.
 
 @param attributes The new developer-defined extensible attributes for this message. (Supported types are NSString, NSNumber, NSArray, NSDictionary and NSNull)
 @param completion Completion block that will specify the result of the operation.
 */
- (void)setAttributes:(nullable NSDictionary<NSString *, id> *)attributes
           completion:(nullable TCHCompletion)completion;

/** Determine if the message has media content.
 
 @return A true boolean value if this message has media, false otherwise.
 */
- (BOOL)hasMedia;

/** Retrieve this message's attached media, if there is any.
 
 @param mediaStream An instance of NSOutputStream you create that the media will be written to.
 @param onStarted Callback block which is called when the media download starts.
 @param onProgress Callback block which is called as download progresses with the most recent number of bytes read.
 @param onCompleted Callback block which is called upon media download completion with the media's sid if successful.
 @param completion Completion block that will specify the result of the operation.
 */
- (void)getMediaWithOutputStream:(nonnull NSOutputStream *)mediaStream
                       onStarted:(nullable TCHMediaOnStarted)onStarted
                      onProgress:(nullable TCHMediaOnProgress)onProgress
                     onCompleted:(nullable TCHMediaOnCompleted)onCompleted
                      completion:(nullable TCHCompletion)completion;

@end
