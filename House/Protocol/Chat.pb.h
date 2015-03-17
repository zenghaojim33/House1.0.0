// Generated by the protocol buffer compiler.  DO NOT EDIT!

#import "ProtocolBuffers.h"

@class Answer;
@class Answer_Builder;
@class Question;
@class Question_Builder;
typedef enum {
  ChatRequestTypeChatTypeSendPtp = 8000,
  ChatRequestTypeChatTypeSendPtg = 8001,
  ChatRequestTypeChatTypeOnLine = 8002,
  ChatRequestTypeChatTypeOffLine = 8003,
} ChatRequestType;

BOOL ChatRequestTypeIsValidValue(ChatRequestType value);


@interface ChatRoot : NSObject {
}
+ (PBExtensionRegistry*) extensionRegistry;
+ (void) registerAllExtensions:(PBMutableExtensionRegistry*) registry;
@end

@interface Question : PBGeneratedMessage {
@private
  BOOL hasMid_:1;
  BOOL hasTid_:1;
  BOOL hasMessage_:1;
  BOOL hasPic_:1;
  BOOL hasVideo_:1;
  BOOL hasType_:1;
  int64_t mid;
  int64_t tid;
  NSString* message;
  NSData* pic;
  NSData* video;
  ChatRequestType type;
}
- (BOOL) hasMid;
- (BOOL) hasTid;
- (BOOL) hasType;
- (BOOL) hasMessage;
- (BOOL) hasPic;
- (BOOL) hasVideo;
@property (readonly) int64_t mid;
@property (readonly) int64_t tid;
@property (readonly) ChatRequestType type;
@property (readonly, retain) NSString* message;
@property (readonly, retain) NSData* pic;
@property (readonly, retain) NSData* video;

+ (Question*) defaultInstance;
- (Question*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (Question_Builder*) builder;
+ (Question_Builder*) builder;
+ (Question_Builder*) builderWithPrototype:(Question*) prototype;

+ (Question*) parseFromData:(NSData*) data;
+ (Question*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (Question*) parseFromInputStream:(NSInputStream*) input;
+ (Question*) parseDelimitedFromInputStream:(NSInputStream*) input;
+ (Question*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (Question*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (Question*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface Question_Builder : PBGeneratedMessage_Builder {
@private
  Question* result;
}

- (Question*) defaultInstance;

- (Question_Builder*) clear;
- (Question_Builder*) clone;

- (Question*) build;
- (Question*) buildPartial;

- (Question_Builder*) mergeFrom:(Question*) other;
- (Question_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (Question_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasMid;
- (int64_t) mid;
- (Question_Builder*) setMid:(int64_t) value;
- (Question_Builder*) clearMid;

- (BOOL) hasTid;
- (int64_t) tid;
- (Question_Builder*) setTid:(int64_t) value;
- (Question_Builder*) clearTid;

- (BOOL) hasType;
- (ChatRequestType) type;
- (Question_Builder*) setType:(ChatRequestType) value;
- (Question_Builder*) clearType;

- (BOOL) hasMessage;
- (NSString*) message;
- (Question_Builder*) setMessage:(NSString*) value;
- (Question_Builder*) clearMessage;

- (BOOL) hasPic;
- (NSData*) pic;
- (Question_Builder*) setPic:(NSData*) value;
- (Question_Builder*) clearPic;

- (BOOL) hasVideo;
- (NSData*) video;
- (Question_Builder*) setVideo:(NSData*) value;
- (Question_Builder*) clearVideo;
@end

@interface Answer : PBGeneratedMessage {
@private
  BOOL hasResult_:1;
  BOOL hasMessage_:1;
  BOOL hasPic_:1;
  BOOL hasVideo_:1;
  BOOL hasType_:1;
  NSString* result;
  NSString* message;
  NSData* pic;
  NSData* video;
  ChatRequestType type;
}
- (BOOL) hasResult;
- (BOOL) hasType;
- (BOOL) hasMessage;
- (BOOL) hasPic;
- (BOOL) hasVideo;
@property (readonly, retain) NSString* result;
@property (readonly) ChatRequestType type;
@property (readonly, retain) NSString* message;
@property (readonly, retain) NSData* pic;
@property (readonly, retain) NSData* video;

+ (Answer*) defaultInstance;
- (Answer*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (Answer_Builder*) builder;
+ (Answer_Builder*) builder;
+ (Answer_Builder*) builderWithPrototype:(Answer*) prototype;

+ (Answer*) parseFromData:(NSData*) data;
+ (Answer*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (Answer*) parseFromInputStream:(NSInputStream*) input;
+ (Answer*) parseDelimitedFromInputStream:(NSInputStream*) input;
+ (Answer*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (Answer*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (Answer*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface Answer_Builder : PBGeneratedMessage_Builder {
@private
  Answer* result;
}

- (Answer*) defaultInstance;

- (Answer_Builder*) clear;
- (Answer_Builder*) clone;

- (Answer*) build;
- (Answer*) buildPartial;

- (Answer_Builder*) mergeFrom:(Answer*) other;
- (Answer_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (Answer_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasResult;
- (NSString*) result;
- (void) setResult:(NSString*) value;
- (Answer_Builder*) clearResult;

- (BOOL) hasType;
- (ChatRequestType) type;
- (Answer_Builder*) setType:(ChatRequestType) value;
- (Answer_Builder*) clearType;

- (BOOL) hasMessage;
- (NSString*) message;
- (Answer_Builder*) setMessage:(NSString*) value;
- (Answer_Builder*) clearMessage;

- (BOOL) hasPic;
- (NSData*) pic;
- (Answer_Builder*) setPic:(NSData*) value;
- (Answer_Builder*) clearPic;

- (BOOL) hasVideo;
- (NSData*) video;
- (Answer_Builder*) setVideo:(NSData*) value;
- (Answer_Builder*) clearVideo;
@end

