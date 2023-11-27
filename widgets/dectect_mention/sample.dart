// contentController = DetectMentionTextController()
//   ..setTextStyle(
//     DetectedType.mention,
//     KTypography.captionBig.style(
//       color: KColors.ffEA4450,
//     ),
//   )
//   ..setTextStyle(
//     DetectedType.url,
//     TextStyles.link,
//   );
// subs.add(
//   contentController.subscribeToDetection(
//     widget.onDetectMentionNickName,
//   ),
// );

// return RichText(
//   text: DetectContentTextSpanBuilder(
//     regularExpressions: mentionAndLinkDetectOnlyTaggedRegex(
//       nickNamesTagged: (comment.usersTagged ?? [])
//           .map((userTag) => userTag.text)
//           .toList(),
//     ),
//     defaultTextStyle: KTypography.bodySmall.style(),
//     detectionTextStyles: {
//       DetectedType.mention: KTypography.bodySmall.style(
//         color: KColors.ff6C44F4,
//       ),
//       DetectedType.url: KTypography.bodySmall.style(
//         color: KColors.ff6C44F4,
//       ),
//     },
//     onTapDetection: (detection) {
//       switch (detection.type) {
//         case DetectedType.mention:
//           // TODO: Navigate to user profile.
//           break;
//         default:
//           break;
//       }
//     },
//   ).build(comment.content ?? ''),
// );