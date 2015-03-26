// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: chat.proto

#define INTERNAL_SUPPRESS_PROTOBUF_FIELD_DEPRECATION
#include "chat.pb.h"

#include <algorithm>

#include <google/protobuf/stubs/common.h>
#include <google/protobuf/stubs/once.h>
#include <google/protobuf/io/coded_stream.h>
#include <google/protobuf/wire_format_lite_inl.h>
#include <google/protobuf/descriptor.h>
#include <google/protobuf/generated_message_reflection.h>
#include <google/protobuf/reflection_ops.h>
#include <google/protobuf/wire_format.h>
// @@protoc_insertion_point(includes)

namespace chat {

namespace {

const ::google::protobuf::Descriptor* Question_descriptor_ = NULL;
const ::google::protobuf::internal::GeneratedMessageReflection*
  Question_reflection_ = NULL;
const ::google::protobuf::Descriptor* Answer_descriptor_ = NULL;
const ::google::protobuf::internal::GeneratedMessageReflection*
  Answer_reflection_ = NULL;
const ::google::protobuf::EnumDescriptor* ChatRequestType_descriptor_ = NULL;

}  // namespace


void protobuf_AssignDesc_chat_2eproto() {
  protobuf_AddDesc_chat_2eproto();
  const ::google::protobuf::FileDescriptor* file =
    ::google::protobuf::DescriptorPool::generated_pool()->FindFileByName(
      "chat.proto");
  GOOGLE_CHECK(file != NULL);
  Question_descriptor_ = file->message_type(0);
  static const int Question_offsets_[6] = {
    GOOGLE_PROTOBUF_GENERATED_MESSAGE_FIELD_OFFSET(Question, mid_),
    GOOGLE_PROTOBUF_GENERATED_MESSAGE_FIELD_OFFSET(Question, tid_),
    GOOGLE_PROTOBUF_GENERATED_MESSAGE_FIELD_OFFSET(Question, type_),
    GOOGLE_PROTOBUF_GENERATED_MESSAGE_FIELD_OFFSET(Question, message_),
    GOOGLE_PROTOBUF_GENERATED_MESSAGE_FIELD_OFFSET(Question, pic_),
    GOOGLE_PROTOBUF_GENERATED_MESSAGE_FIELD_OFFSET(Question, video_),
  };
  Question_reflection_ =
    new ::google::protobuf::internal::GeneratedMessageReflection(
      Question_descriptor_,
      Question::default_instance_,
      Question_offsets_,
      GOOGLE_PROTOBUF_GENERATED_MESSAGE_FIELD_OFFSET(Question, _has_bits_[0]),
      GOOGLE_PROTOBUF_GENERATED_MESSAGE_FIELD_OFFSET(Question, _unknown_fields_),
      -1,
      ::google::protobuf::DescriptorPool::generated_pool(),
      ::google::protobuf::MessageFactory::generated_factory(),
      sizeof(Question));
  Answer_descriptor_ = file->message_type(1);
  static const int Answer_offsets_[5] = {
    GOOGLE_PROTOBUF_GENERATED_MESSAGE_FIELD_OFFSET(Answer, result_),
    GOOGLE_PROTOBUF_GENERATED_MESSAGE_FIELD_OFFSET(Answer, type_),
    GOOGLE_PROTOBUF_GENERATED_MESSAGE_FIELD_OFFSET(Answer, message_),
    GOOGLE_PROTOBUF_GENERATED_MESSAGE_FIELD_OFFSET(Answer, pic_),
    GOOGLE_PROTOBUF_GENERATED_MESSAGE_FIELD_OFFSET(Answer, video_),
  };
  Answer_reflection_ =
    new ::google::protobuf::internal::GeneratedMessageReflection(
      Answer_descriptor_,
      Answer::default_instance_,
      Answer_offsets_,
      GOOGLE_PROTOBUF_GENERATED_MESSAGE_FIELD_OFFSET(Answer, _has_bits_[0]),
      GOOGLE_PROTOBUF_GENERATED_MESSAGE_FIELD_OFFSET(Answer, _unknown_fields_),
      -1,
      ::google::protobuf::DescriptorPool::generated_pool(),
      ::google::protobuf::MessageFactory::generated_factory(),
      sizeof(Answer));
  ChatRequestType_descriptor_ = file->enum_type(0);
}

namespace {

GOOGLE_PROTOBUF_DECLARE_ONCE(protobuf_AssignDescriptors_once_);
inline void protobuf_AssignDescriptorsOnce() {
  ::google::protobuf::GoogleOnceInit(&protobuf_AssignDescriptors_once_,
                 &protobuf_AssignDesc_chat_2eproto);
}

void protobuf_RegisterTypes(const ::std::string&) {
  protobuf_AssignDescriptorsOnce();
  ::google::protobuf::MessageFactory::InternalRegisterGeneratedMessage(
    Question_descriptor_, &Question::default_instance());
  ::google::protobuf::MessageFactory::InternalRegisterGeneratedMessage(
    Answer_descriptor_, &Answer::default_instance());
}

}  // namespace

void protobuf_ShutdownFile_chat_2eproto() {
  delete Question::default_instance_;
  delete Question_reflection_;
  delete Answer::default_instance_;
  delete Answer_reflection_;
}

void protobuf_AddDesc_chat_2eproto() {
  static bool already_here = false;
  if (already_here) return;
  already_here = true;
  GOOGLE_PROTOBUF_VERIFY_VERSION;

  ::google::protobuf::DescriptorPool::InternalAddGeneratedFile(
    "\n\nchat.proto\022\004chat\"v\n\010Question\022\013\n\003mid\030\001 "
    "\002(\003\022\013\n\003tid\030\002 \002(\003\022#\n\004type\030\003 \002(\0162\025.chat.Ch"
    "atRequestType\022\017\n\007message\030\004 \001(\t\022\013\n\003pic\030\005 "
    "\001(\014\022\r\n\005video\030\006 \001(\014\"j\n\006Answer\022\016\n\006result\030\001"
    " \002(\t\022#\n\004type\030\002 \002(\0162\025.chat.ChatRequestTyp"
    "e\022\017\n\007message\030\003 \001(\t\022\013\n\003pic\030\004 \001(\014\022\r\n\005video"
    "\030\005 \001(\014*h\n\017ChatRequestType\022\024\n\017ChatTypeSen"
    "dPTP\020\300>\022\024\n\017ChatTypeSendPTG\020\301>\022\023\n\016ChatTyp"
    "eOnLine\020\302>\022\024\n\017ChatTypeOffLine\020\303>B%\n\032com."
    "fangdangjia.fdj.structB\007ChatMsg", 391);
  ::google::protobuf::MessageFactory::InternalRegisterGeneratedFile(
    "chat.proto", &protobuf_RegisterTypes);
  Question::default_instance_ = new Question();
  Answer::default_instance_ = new Answer();
  Question::default_instance_->InitAsDefaultInstance();
  Answer::default_instance_->InitAsDefaultInstance();
  ::google::protobuf::internal::OnShutdown(&protobuf_ShutdownFile_chat_2eproto);
}

// Force AddDescriptors() to be called at static initialization time.
struct StaticDescriptorInitializer_chat_2eproto {
  StaticDescriptorInitializer_chat_2eproto() {
    protobuf_AddDesc_chat_2eproto();
  }
} static_descriptor_initializer_chat_2eproto_;
const ::google::protobuf::EnumDescriptor* ChatRequestType_descriptor() {
  protobuf_AssignDescriptorsOnce();
  return ChatRequestType_descriptor_;
}
bool ChatRequestType_IsValid(int value) {
  switch(value) {
    case 8000:
    case 8001:
    case 8002:
    case 8003:
      return true;
    default:
      return false;
  }
}


// ===================================================================

#ifndef _MSC_VER
const int Question::kMidFieldNumber;
const int Question::kTidFieldNumber;
const int Question::kTypeFieldNumber;
const int Question::kMessageFieldNumber;
const int Question::kPicFieldNumber;
const int Question::kVideoFieldNumber;
#endif  // !_MSC_VER

Question::Question()
  : ::google::protobuf::Message() {
  SharedCtor();
  // @@protoc_insertion_point(constructor:chat.Question)
}

void Question::InitAsDefaultInstance() {
}

Question::Question(const Question& from)
  : ::google::protobuf::Message() {
  SharedCtor();
  MergeFrom(from);
  // @@protoc_insertion_point(copy_constructor:chat.Question)
}

void Question::SharedCtor() {
  ::google::protobuf::internal::GetEmptyString();
  _cached_size_ = 0;
  mid_ = GOOGLE_LONGLONG(0);
  tid_ = GOOGLE_LONGLONG(0);
  type_ = 8000;
  message_ = const_cast< ::std::string*>(&::google::protobuf::internal::GetEmptyStringAlreadyInited());
  pic_ = const_cast< ::std::string*>(&::google::protobuf::internal::GetEmptyStringAlreadyInited());
  video_ = const_cast< ::std::string*>(&::google::protobuf::internal::GetEmptyStringAlreadyInited());
  ::memset(_has_bits_, 0, sizeof(_has_bits_));
}

Question::~Question() {
  // @@protoc_insertion_point(destructor:chat.Question)
  SharedDtor();
}

void Question::SharedDtor() {
  if (message_ != &::google::protobuf::internal::GetEmptyStringAlreadyInited()) {
    delete message_;
  }
  if (pic_ != &::google::protobuf::internal::GetEmptyStringAlreadyInited()) {
    delete pic_;
  }
  if (video_ != &::google::protobuf::internal::GetEmptyStringAlreadyInited()) {
    delete video_;
  }
  if (this != default_instance_) {
  }
}

void Question::SetCachedSize(int size) const {
  GOOGLE_SAFE_CONCURRENT_WRITES_BEGIN();
  _cached_size_ = size;
  GOOGLE_SAFE_CONCURRENT_WRITES_END();
}
const ::google::protobuf::Descriptor* Question::descriptor() {
  protobuf_AssignDescriptorsOnce();
  return Question_descriptor_;
}

const Question& Question::default_instance() {
  if (default_instance_ == NULL) protobuf_AddDesc_chat_2eproto();
  return *default_instance_;
}

Question* Question::default_instance_ = NULL;

Question* Question::New() const {
  return new Question;
}

void Question::Clear() {
#define OFFSET_OF_FIELD_(f) (reinterpret_cast<char*>(      \
  &reinterpret_cast<Question*>(16)->f) - \
   reinterpret_cast<char*>(16))

#define ZR_(first, last) do {                              \
    size_t f = OFFSET_OF_FIELD_(first);                    \
    size_t n = OFFSET_OF_FIELD_(last) - f + sizeof(last);  \
    ::memset(&first, 0, n);                                \
  } while (0)

  if (_has_bits_[0 / 32] & 63) {
    ZR_(mid_, tid_);
    type_ = 8000;
    if (has_message()) {
      if (message_ != &::google::protobuf::internal::GetEmptyStringAlreadyInited()) {
        message_->clear();
      }
    }
    if (has_pic()) {
      if (pic_ != &::google::protobuf::internal::GetEmptyStringAlreadyInited()) {
        pic_->clear();
      }
    }
    if (has_video()) {
      if (video_ != &::google::protobuf::internal::GetEmptyStringAlreadyInited()) {
        video_->clear();
      }
    }
  }

#undef OFFSET_OF_FIELD_
#undef ZR_

  ::memset(_has_bits_, 0, sizeof(_has_bits_));
  mutable_unknown_fields()->Clear();
}

bool Question::MergePartialFromCodedStream(
    ::google::protobuf::io::CodedInputStream* input) {
#define DO_(EXPRESSION) if (!(EXPRESSION)) goto failure
  ::google::protobuf::uint32 tag;
  // @@protoc_insertion_point(parse_start:chat.Question)
  for (;;) {
    ::std::pair< ::google::protobuf::uint32, bool> p = input->ReadTagWithCutoff(127);
    tag = p.first;
    if (!p.second) goto handle_unusual;
    switch (::google::protobuf::internal::WireFormatLite::GetTagFieldNumber(tag)) {
      // required int64 mid = 1;
      case 1: {
        if (tag == 8) {
          DO_((::google::protobuf::internal::WireFormatLite::ReadPrimitive<
                   ::google::protobuf::int64, ::google::protobuf::internal::WireFormatLite::TYPE_INT64>(
                 input, &mid_)));
          set_has_mid();
        } else {
          goto handle_unusual;
        }
        if (input->ExpectTag(16)) goto parse_tid;
        break;
      }

      // required int64 tid = 2;
      case 2: {
        if (tag == 16) {
         parse_tid:
          DO_((::google::protobuf::internal::WireFormatLite::ReadPrimitive<
                   ::google::protobuf::int64, ::google::protobuf::internal::WireFormatLite::TYPE_INT64>(
                 input, &tid_)));
          set_has_tid();
        } else {
          goto handle_unusual;
        }
        if (input->ExpectTag(24)) goto parse_type;
        break;
      }

      // required .chat.ChatRequestType type = 3;
      case 3: {
        if (tag == 24) {
         parse_type:
          int value;
          DO_((::google::protobuf::internal::WireFormatLite::ReadPrimitive<
                   int, ::google::protobuf::internal::WireFormatLite::TYPE_ENUM>(
                 input, &value)));
          if (::chat::ChatRequestType_IsValid(value)) {
            set_type(static_cast< ::chat::ChatRequestType >(value));
          } else {
            mutable_unknown_fields()->AddVarint(3, value);
          }
        } else {
          goto handle_unusual;
        }
        if (input->ExpectTag(34)) goto parse_message;
        break;
      }

      // optional string message = 4;
      case 4: {
        if (tag == 34) {
         parse_message:
          DO_(::google::protobuf::internal::WireFormatLite::ReadString(
                input, this->mutable_message()));
          ::google::protobuf::internal::WireFormat::VerifyUTF8StringNamedField(
            this->message().data(), this->message().length(),
            ::google::protobuf::internal::WireFormat::PARSE,
            "message");
        } else {
          goto handle_unusual;
        }
        if (input->ExpectTag(42)) goto parse_pic;
        break;
      }

      // optional bytes pic = 5;
      case 5: {
        if (tag == 42) {
         parse_pic:
          DO_(::google::protobuf::internal::WireFormatLite::ReadBytes(
                input, this->mutable_pic()));
        } else {
          goto handle_unusual;
        }
        if (input->ExpectTag(50)) goto parse_video;
        break;
      }

      // optional bytes video = 6;
      case 6: {
        if (tag == 50) {
         parse_video:
          DO_(::google::protobuf::internal::WireFormatLite::ReadBytes(
                input, this->mutable_video()));
        } else {
          goto handle_unusual;
        }
        if (input->ExpectAtEnd()) goto success;
        break;
      }

      default: {
      handle_unusual:
        if (tag == 0 ||
            ::google::protobuf::internal::WireFormatLite::GetTagWireType(tag) ==
            ::google::protobuf::internal::WireFormatLite::WIRETYPE_END_GROUP) {
          goto success;
        }
        DO_(::google::protobuf::internal::WireFormat::SkipField(
              input, tag, mutable_unknown_fields()));
        break;
      }
    }
  }
success:
  // @@protoc_insertion_point(parse_success:chat.Question)
  return true;
failure:
  // @@protoc_insertion_point(parse_failure:chat.Question)
  return false;
#undef DO_
}

void Question::SerializeWithCachedSizes(
    ::google::protobuf::io::CodedOutputStream* output) const {
  // @@protoc_insertion_point(serialize_start:chat.Question)
  // required int64 mid = 1;
  if (has_mid()) {
    ::google::protobuf::internal::WireFormatLite::WriteInt64(1, this->mid(), output);
  }

  // required int64 tid = 2;
  if (has_tid()) {
    ::google::protobuf::internal::WireFormatLite::WriteInt64(2, this->tid(), output);
  }

  // required .chat.ChatRequestType type = 3;
  if (has_type()) {
    ::google::protobuf::internal::WireFormatLite::WriteEnum(
      3, this->type(), output);
  }

  // optional string message = 4;
  if (has_message()) {
    ::google::protobuf::internal::WireFormat::VerifyUTF8StringNamedField(
      this->message().data(), this->message().length(),
      ::google::protobuf::internal::WireFormat::SERIALIZE,
      "message");
    ::google::protobuf::internal::WireFormatLite::WriteStringMaybeAliased(
      4, this->message(), output);
  }

  // optional bytes pic = 5;
  if (has_pic()) {
    ::google::protobuf::internal::WireFormatLite::WriteBytesMaybeAliased(
      5, this->pic(), output);
  }

  // optional bytes video = 6;
  if (has_video()) {
    ::google::protobuf::internal::WireFormatLite::WriteBytesMaybeAliased(
      6, this->video(), output);
  }

  if (!unknown_fields().empty()) {
    ::google::protobuf::internal::WireFormat::SerializeUnknownFields(
        unknown_fields(), output);
  }
  // @@protoc_insertion_point(serialize_end:chat.Question)
}

::google::protobuf::uint8* Question::SerializeWithCachedSizesToArray(
    ::google::protobuf::uint8* target) const {
  // @@protoc_insertion_point(serialize_to_array_start:chat.Question)
  // required int64 mid = 1;
  if (has_mid()) {
    target = ::google::protobuf::internal::WireFormatLite::WriteInt64ToArray(1, this->mid(), target);
  }

  // required int64 tid = 2;
  if (has_tid()) {
    target = ::google::protobuf::internal::WireFormatLite::WriteInt64ToArray(2, this->tid(), target);
  }

  // required .chat.ChatRequestType type = 3;
  if (has_type()) {
    target = ::google::protobuf::internal::WireFormatLite::WriteEnumToArray(
      3, this->type(), target);
  }

  // optional string message = 4;
  if (has_message()) {
    ::google::protobuf::internal::WireFormat::VerifyUTF8StringNamedField(
      this->message().data(), this->message().length(),
      ::google::protobuf::internal::WireFormat::SERIALIZE,
      "message");
    target =
      ::google::protobuf::internal::WireFormatLite::WriteStringToArray(
        4, this->message(), target);
  }

  // optional bytes pic = 5;
  if (has_pic()) {
    target =
      ::google::protobuf::internal::WireFormatLite::WriteBytesToArray(
        5, this->pic(), target);
  }

  // optional bytes video = 6;
  if (has_video()) {
    target =
      ::google::protobuf::internal::WireFormatLite::WriteBytesToArray(
        6, this->video(), target);
  }

  if (!unknown_fields().empty()) {
    target = ::google::protobuf::internal::WireFormat::SerializeUnknownFieldsToArray(
        unknown_fields(), target);
  }
  // @@protoc_insertion_point(serialize_to_array_end:chat.Question)
  return target;
}

int Question::ByteSize() const {
  int total_size = 0;

  if (_has_bits_[0 / 32] & (0xffu << (0 % 32))) {
    // required int64 mid = 1;
    if (has_mid()) {
      total_size += 1 +
        ::google::protobuf::internal::WireFormatLite::Int64Size(
          this->mid());
    }

    // required int64 tid = 2;
    if (has_tid()) {
      total_size += 1 +
        ::google::protobuf::internal::WireFormatLite::Int64Size(
          this->tid());
    }

    // required .chat.ChatRequestType type = 3;
    if (has_type()) {
      total_size += 1 +
        ::google::protobuf::internal::WireFormatLite::EnumSize(this->type());
    }

    // optional string message = 4;
    if (has_message()) {
      total_size += 1 +
        ::google::protobuf::internal::WireFormatLite::StringSize(
          this->message());
    }

    // optional bytes pic = 5;
    if (has_pic()) {
      total_size += 1 +
        ::google::protobuf::internal::WireFormatLite::BytesSize(
          this->pic());
    }

    // optional bytes video = 6;
    if (has_video()) {
      total_size += 1 +
        ::google::protobuf::internal::WireFormatLite::BytesSize(
          this->video());
    }

  }
  if (!unknown_fields().empty()) {
    total_size +=
      ::google::protobuf::internal::WireFormat::ComputeUnknownFieldsSize(
        unknown_fields());
  }
  GOOGLE_SAFE_CONCURRENT_WRITES_BEGIN();
  _cached_size_ = total_size;
  GOOGLE_SAFE_CONCURRENT_WRITES_END();
  return total_size;
}

void Question::MergeFrom(const ::google::protobuf::Message& from) {
  GOOGLE_CHECK_NE(&from, this);
  const Question* source =
    ::google::protobuf::internal::dynamic_cast_if_available<const Question*>(
      &from);
  if (source == NULL) {
    ::google::protobuf::internal::ReflectionOps::Merge(from, this);
  } else {
    MergeFrom(*source);
  }
}

void Question::MergeFrom(const Question& from) {
  GOOGLE_CHECK_NE(&from, this);
  if (from._has_bits_[0 / 32] & (0xffu << (0 % 32))) {
    if (from.has_mid()) {
      set_mid(from.mid());
    }
    if (from.has_tid()) {
      set_tid(from.tid());
    }
    if (from.has_type()) {
      set_type(from.type());
    }
    if (from.has_message()) {
      set_message(from.message());
    }
    if (from.has_pic()) {
      set_pic(from.pic());
    }
    if (from.has_video()) {
      set_video(from.video());
    }
  }
  mutable_unknown_fields()->MergeFrom(from.unknown_fields());
}

void Question::CopyFrom(const ::google::protobuf::Message& from) {
  if (&from == this) return;
  Clear();
  MergeFrom(from);
}

void Question::CopyFrom(const Question& from) {
  if (&from == this) return;
  Clear();
  MergeFrom(from);
}

bool Question::IsInitialized() const {
  if ((_has_bits_[0] & 0x00000007) != 0x00000007) return false;

  return true;
}

void Question::Swap(Question* other) {
  if (other != this) {
    std::swap(mid_, other->mid_);
    std::swap(tid_, other->tid_);
    std::swap(type_, other->type_);
    std::swap(message_, other->message_);
    std::swap(pic_, other->pic_);
    std::swap(video_, other->video_);
    std::swap(_has_bits_[0], other->_has_bits_[0]);
    _unknown_fields_.Swap(&other->_unknown_fields_);
    std::swap(_cached_size_, other->_cached_size_);
  }
}

::google::protobuf::Metadata Question::GetMetadata() const {
  protobuf_AssignDescriptorsOnce();
  ::google::protobuf::Metadata metadata;
  metadata.descriptor = Question_descriptor_;
  metadata.reflection = Question_reflection_;
  return metadata;
}


// ===================================================================

#ifndef _MSC_VER
const int Answer::kResultFieldNumber;
const int Answer::kTypeFieldNumber;
const int Answer::kMessageFieldNumber;
const int Answer::kPicFieldNumber;
const int Answer::kVideoFieldNumber;
#endif  // !_MSC_VER

Answer::Answer()
  : ::google::protobuf::Message() {
  SharedCtor();
  // @@protoc_insertion_point(constructor:chat.Answer)
}

void Answer::InitAsDefaultInstance() {
}

Answer::Answer(const Answer& from)
  : ::google::protobuf::Message() {
  SharedCtor();
  MergeFrom(from);
  // @@protoc_insertion_point(copy_constructor:chat.Answer)
}

void Answer::SharedCtor() {
  ::google::protobuf::internal::GetEmptyString();
  _cached_size_ = 0;
  result_ = const_cast< ::std::string*>(&::google::protobuf::internal::GetEmptyStringAlreadyInited());
  type_ = 8000;
  message_ = const_cast< ::std::string*>(&::google::protobuf::internal::GetEmptyStringAlreadyInited());
  pic_ = const_cast< ::std::string*>(&::google::protobuf::internal::GetEmptyStringAlreadyInited());
  video_ = const_cast< ::std::string*>(&::google::protobuf::internal::GetEmptyStringAlreadyInited());
  ::memset(_has_bits_, 0, sizeof(_has_bits_));
}

Answer::~Answer() {
  // @@protoc_insertion_point(destructor:chat.Answer)
  SharedDtor();
}

void Answer::SharedDtor() {
  if (result_ != &::google::protobuf::internal::GetEmptyStringAlreadyInited()) {
    delete result_;
  }
  if (message_ != &::google::protobuf::internal::GetEmptyStringAlreadyInited()) {
    delete message_;
  }
  if (pic_ != &::google::protobuf::internal::GetEmptyStringAlreadyInited()) {
    delete pic_;
  }
  if (video_ != &::google::protobuf::internal::GetEmptyStringAlreadyInited()) {
    delete video_;
  }
  if (this != default_instance_) {
  }
}

void Answer::SetCachedSize(int size) const {
  GOOGLE_SAFE_CONCURRENT_WRITES_BEGIN();
  _cached_size_ = size;
  GOOGLE_SAFE_CONCURRENT_WRITES_END();
}
const ::google::protobuf::Descriptor* Answer::descriptor() {
  protobuf_AssignDescriptorsOnce();
  return Answer_descriptor_;
}

const Answer& Answer::default_instance() {
  if (default_instance_ == NULL) protobuf_AddDesc_chat_2eproto();
  return *default_instance_;
}

Answer* Answer::default_instance_ = NULL;

Answer* Answer::New() const {
  return new Answer;
}

void Answer::Clear() {
  if (_has_bits_[0 / 32] & 31) {
    if (has_result()) {
      if (result_ != &::google::protobuf::internal::GetEmptyStringAlreadyInited()) {
        result_->clear();
      }
    }
    type_ = 8000;
    if (has_message()) {
      if (message_ != &::google::protobuf::internal::GetEmptyStringAlreadyInited()) {
        message_->clear();
      }
    }
    if (has_pic()) {
      if (pic_ != &::google::protobuf::internal::GetEmptyStringAlreadyInited()) {
        pic_->clear();
      }
    }
    if (has_video()) {
      if (video_ != &::google::protobuf::internal::GetEmptyStringAlreadyInited()) {
        video_->clear();
      }
    }
  }
  ::memset(_has_bits_, 0, sizeof(_has_bits_));
  mutable_unknown_fields()->Clear();
}

bool Answer::MergePartialFromCodedStream(
    ::google::protobuf::io::CodedInputStream* input) {
#define DO_(EXPRESSION) if (!(EXPRESSION)) goto failure
  ::google::protobuf::uint32 tag;
  // @@protoc_insertion_point(parse_start:chat.Answer)
  for (;;) {
    ::std::pair< ::google::protobuf::uint32, bool> p = input->ReadTagWithCutoff(127);
    tag = p.first;
    if (!p.second) goto handle_unusual;
    switch (::google::protobuf::internal::WireFormatLite::GetTagFieldNumber(tag)) {
      // required string result = 1;
      case 1: {
        if (tag == 10) {
          DO_(::google::protobuf::internal::WireFormatLite::ReadString(
                input, this->mutable_result()));
          ::google::protobuf::internal::WireFormat::VerifyUTF8StringNamedField(
            this->result().data(), this->result().length(),
            ::google::protobuf::internal::WireFormat::PARSE,
            "result");
        } else {
          goto handle_unusual;
        }
        if (input->ExpectTag(16)) goto parse_type;
        break;
      }

      // required .chat.ChatRequestType type = 2;
      case 2: {
        if (tag == 16) {
         parse_type:
          int value;
          DO_((::google::protobuf::internal::WireFormatLite::ReadPrimitive<
                   int, ::google::protobuf::internal::WireFormatLite::TYPE_ENUM>(
                 input, &value)));
          if (::chat::ChatRequestType_IsValid(value)) {
            set_type(static_cast< ::chat::ChatRequestType >(value));
          } else {
            mutable_unknown_fields()->AddVarint(2, value);
          }
        } else {
          goto handle_unusual;
        }
        if (input->ExpectTag(26)) goto parse_message;
        break;
      }

      // optional string message = 3;
      case 3: {
        if (tag == 26) {
         parse_message:
          DO_(::google::protobuf::internal::WireFormatLite::ReadString(
                input, this->mutable_message()));
          ::google::protobuf::internal::WireFormat::VerifyUTF8StringNamedField(
            this->message().data(), this->message().length(),
            ::google::protobuf::internal::WireFormat::PARSE,
            "message");
        } else {
          goto handle_unusual;
        }
        if (input->ExpectTag(34)) goto parse_pic;
        break;
      }

      // optional bytes pic = 4;
      case 4: {
        if (tag == 34) {
         parse_pic:
          DO_(::google::protobuf::internal::WireFormatLite::ReadBytes(
                input, this->mutable_pic()));
        } else {
          goto handle_unusual;
        }
        if (input->ExpectTag(42)) goto parse_video;
        break;
      }

      // optional bytes video = 5;
      case 5: {
        if (tag == 42) {
         parse_video:
          DO_(::google::protobuf::internal::WireFormatLite::ReadBytes(
                input, this->mutable_video()));
        } else {
          goto handle_unusual;
        }
        if (input->ExpectAtEnd()) goto success;
        break;
      }

      default: {
      handle_unusual:
        if (tag == 0 ||
            ::google::protobuf::internal::WireFormatLite::GetTagWireType(tag) ==
            ::google::protobuf::internal::WireFormatLite::WIRETYPE_END_GROUP) {
          goto success;
        }
        DO_(::google::protobuf::internal::WireFormat::SkipField(
              input, tag, mutable_unknown_fields()));
        break;
      }
    }
  }
success:
  // @@protoc_insertion_point(parse_success:chat.Answer)
  return true;
failure:
  // @@protoc_insertion_point(parse_failure:chat.Answer)
  return false;
#undef DO_
}

void Answer::SerializeWithCachedSizes(
    ::google::protobuf::io::CodedOutputStream* output) const {
  // @@protoc_insertion_point(serialize_start:chat.Answer)
  // required string result = 1;
  if (has_result()) {
    ::google::protobuf::internal::WireFormat::VerifyUTF8StringNamedField(
      this->result().data(), this->result().length(),
      ::google::protobuf::internal::WireFormat::SERIALIZE,
      "result");
    ::google::protobuf::internal::WireFormatLite::WriteStringMaybeAliased(
      1, this->result(), output);
  }

  // required .chat.ChatRequestType type = 2;
  if (has_type()) {
    ::google::protobuf::internal::WireFormatLite::WriteEnum(
      2, this->type(), output);
  }

  // optional string message = 3;
  if (has_message()) {
    ::google::protobuf::internal::WireFormat::VerifyUTF8StringNamedField(
      this->message().data(), this->message().length(),
      ::google::protobuf::internal::WireFormat::SERIALIZE,
      "message");
    ::google::protobuf::internal::WireFormatLite::WriteStringMaybeAliased(
      3, this->message(), output);
  }

  // optional bytes pic = 4;
  if (has_pic()) {
    ::google::protobuf::internal::WireFormatLite::WriteBytesMaybeAliased(
      4, this->pic(), output);
  }

  // optional bytes video = 5;
  if (has_video()) {
    ::google::protobuf::internal::WireFormatLite::WriteBytesMaybeAliased(
      5, this->video(), output);
  }

  if (!unknown_fields().empty()) {
    ::google::protobuf::internal::WireFormat::SerializeUnknownFields(
        unknown_fields(), output);
  }
  // @@protoc_insertion_point(serialize_end:chat.Answer)
}

::google::protobuf::uint8* Answer::SerializeWithCachedSizesToArray(
    ::google::protobuf::uint8* target) const {
  // @@protoc_insertion_point(serialize_to_array_start:chat.Answer)
  // required string result = 1;
  if (has_result()) {
    ::google::protobuf::internal::WireFormat::VerifyUTF8StringNamedField(
      this->result().data(), this->result().length(),
      ::google::protobuf::internal::WireFormat::SERIALIZE,
      "result");
    target =
      ::google::protobuf::internal::WireFormatLite::WriteStringToArray(
        1, this->result(), target);
  }

  // required .chat.ChatRequestType type = 2;
  if (has_type()) {
    target = ::google::protobuf::internal::WireFormatLite::WriteEnumToArray(
      2, this->type(), target);
  }

  // optional string message = 3;
  if (has_message()) {
    ::google::protobuf::internal::WireFormat::VerifyUTF8StringNamedField(
      this->message().data(), this->message().length(),
      ::google::protobuf::internal::WireFormat::SERIALIZE,
      "message");
    target =
      ::google::protobuf::internal::WireFormatLite::WriteStringToArray(
        3, this->message(), target);
  }

  // optional bytes pic = 4;
  if (has_pic()) {
    target =
      ::google::protobuf::internal::WireFormatLite::WriteBytesToArray(
        4, this->pic(), target);
  }

  // optional bytes video = 5;
  if (has_video()) {
    target =
      ::google::protobuf::internal::WireFormatLite::WriteBytesToArray(
        5, this->video(), target);
  }

  if (!unknown_fields().empty()) {
    target = ::google::protobuf::internal::WireFormat::SerializeUnknownFieldsToArray(
        unknown_fields(), target);
  }
  // @@protoc_insertion_point(serialize_to_array_end:chat.Answer)
  return target;
}

int Answer::ByteSize() const {
  int total_size = 0;

  if (_has_bits_[0 / 32] & (0xffu << (0 % 32))) {
    // required string result = 1;
    if (has_result()) {
      total_size += 1 +
        ::google::protobuf::internal::WireFormatLite::StringSize(
          this->result());
    }

    // required .chat.ChatRequestType type = 2;
    if (has_type()) {
      total_size += 1 +
        ::google::protobuf::internal::WireFormatLite::EnumSize(this->type());
    }

    // optional string message = 3;
    if (has_message()) {
      total_size += 1 +
        ::google::protobuf::internal::WireFormatLite::StringSize(
          this->message());
    }

    // optional bytes pic = 4;
    if (has_pic()) {
      total_size += 1 +
        ::google::protobuf::internal::WireFormatLite::BytesSize(
          this->pic());
    }

    // optional bytes video = 5;
    if (has_video()) {
      total_size += 1 +
        ::google::protobuf::internal::WireFormatLite::BytesSize(
          this->video());
    }

  }
  if (!unknown_fields().empty()) {
    total_size +=
      ::google::protobuf::internal::WireFormat::ComputeUnknownFieldsSize(
        unknown_fields());
  }
  GOOGLE_SAFE_CONCURRENT_WRITES_BEGIN();
  _cached_size_ = total_size;
  GOOGLE_SAFE_CONCURRENT_WRITES_END();
  return total_size;
}

void Answer::MergeFrom(const ::google::protobuf::Message& from) {
  GOOGLE_CHECK_NE(&from, this);
  const Answer* source =
    ::google::protobuf::internal::dynamic_cast_if_available<const Answer*>(
      &from);
  if (source == NULL) {
    ::google::protobuf::internal::ReflectionOps::Merge(from, this);
  } else {
    MergeFrom(*source);
  }
}

void Answer::MergeFrom(const Answer& from) {
  GOOGLE_CHECK_NE(&from, this);
  if (from._has_bits_[0 / 32] & (0xffu << (0 % 32))) {
    if (from.has_result()) {
      set_result(from.result());
    }
    if (from.has_type()) {
      set_type(from.type());
    }
    if (from.has_message()) {
      set_message(from.message());
    }
    if (from.has_pic()) {
      set_pic(from.pic());
    }
    if (from.has_video()) {
      set_video(from.video());
    }
  }
  mutable_unknown_fields()->MergeFrom(from.unknown_fields());
}

void Answer::CopyFrom(const ::google::protobuf::Message& from) {
  if (&from == this) return;
  Clear();
  MergeFrom(from);
}

void Answer::CopyFrom(const Answer& from) {
  if (&from == this) return;
  Clear();
  MergeFrom(from);
}

bool Answer::IsInitialized() const {
  if ((_has_bits_[0] & 0x00000003) != 0x00000003) return false;

  return true;
}

void Answer::Swap(Answer* other) {
  if (other != this) {
    std::swap(result_, other->result_);
    std::swap(type_, other->type_);
    std::swap(message_, other->message_);
    std::swap(pic_, other->pic_);
    std::swap(video_, other->video_);
    std::swap(_has_bits_[0], other->_has_bits_[0]);
    _unknown_fields_.Swap(&other->_unknown_fields_);
    std::swap(_cached_size_, other->_cached_size_);
  }
}

::google::protobuf::Metadata Answer::GetMetadata() const {
  protobuf_AssignDescriptorsOnce();
  ::google::protobuf::Metadata metadata;
  metadata.descriptor = Answer_descriptor_;
  metadata.reflection = Answer_reflection_;
  return metadata;
}


// @@protoc_insertion_point(namespace_scope)

}  // namespace chat

// @@protoc_insertion_point(global_scope)