import 'package:flutter/material.dart';

enum QuestionResponseType {
  text,
  audio,
  photo,
  video,
  scale;

  factory QuestionResponseType.fromString(String type) {
    switch (type) {
      case "text":
        return QuestionResponseType.text;
      case "scale":
        return QuestionResponseType.scale;
      case "audio":
        return QuestionResponseType.audio;
      case "photo":
        return QuestionResponseType.photo;
      case "video":
        return QuestionResponseType.video;
      default:
        throw ErrorDescription("Unkown question response type.");
    }
  }
}
