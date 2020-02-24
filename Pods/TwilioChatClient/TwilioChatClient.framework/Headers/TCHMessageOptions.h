//
//  TCHMessageOptions.h
//  Twilio Chat Client
//
//  Copyright (c) 2018 Twilio, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TCHConstants.h"
#import "TCHMessage.h"

/** Creation options for new messages within Programmable Chat */
@interface TCHMessageOptions : NSObject

/** Sets body for the new message to be created.
 
 Note: Specifying both body and media will result in the body being ignored at the present time, replacing it with the media place-holder defined on your instance.
 
 @param body The new message body.
 @return A referece to this options object for convenience in chaining.
 */
- (nonnull instancetype)withBody:(nonnull NSString *)body;

/** Supplies a media upload for the message to be created.
 
 Note: Specifying both body and media will result in the body being ignored at the present time, replacing it with the media place-holder defined on your instance.

 @param mediaStream An NSInputStream that will be used as the source for the new media message.
 @param contentType The mime type of the attached media.
 @param defaultFilename An optional recommended default filename clients may use when downloading the file.
 @param onStarted Callback block which is called when the media upload starts.
 @param onProgress Callback block which is called as upload progresses with the most recent number of bytes written.
 @param onCompleted Callback block which is called upon media upload completion with the media's sid if successful.
 @return A reference to this options object for convenience in chaining.
 */
- (nonnull instancetype)withMediaStream:(nonnull NSInputStream *)mediaStream
                            contentType:(nonnull NSString *)contentType
                        defaultFilename:(nullable NSString *)defaultFilename
                              onStarted:(nullable TCHMediaOnStarted)onStarted
                             onProgress:(nullable TCHMediaOnProgress)onProgress
                            onCompleted:(nullable TCHMediaOnCompleted)onCompleted;

/** Sets user defined attributes for the new message.
 
 @param attributes The new developer-defined extensible attributes for this message. (Supported types are NSString, NSNumber, NSArray, NSDictionary and NSNull)
 @param completion A completion block which will indicate the success or failure of setting the attributes.
 @return A reference to this options object for convenience in chaining or nil in the event the attributes could not be parsed/updated.
 */
- (nullable instancetype)withAttributes:(nonnull NSDictionary<NSString *, id> *)attributes
                             completion:(nullable TCHCompletion)completion;

@end
