class Emoji
  COLLECTION = [
    'https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/120/apple/155/grinning-face-with-smiling-eyes_1f601.png',
    'https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/120/apple/155/smiling-face-with-open-mouth_1f603.png',
    'https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/120/apple/155/face-with-rolling-eyes_1f644.png',
    'https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/120/apple/155/grimacing-face_1f62c.png',
    'https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/120/apple/155/unamused-face_1f612.png',
    'https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/120/apple/155/confounded-face_1f616.png',
    'https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/120/apple/155/white-frowning-face_2639.png',
    'https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/120/apple/155/crying-face_1f622.png',
    'https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/120/apple/155/confused-face_1f615.png',
    'https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/120/apple/155/disappointed-but-relieved-face_1f625.png',
    'https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/120/apple/155/face-with-open-mouth_1f62e.png',
    'https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/120/apple/155/neutral-face_1f610.png',
    'https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/120/apple/155/rolling-on-the-floor-laughing_1f923.png',
    'https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/120/apple/155/grinning-face_1f600.png',
    'https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/240/apple/155/angry-face_1f620.png'
  ]

  def self.random_images(count)
    COLLECTION.sample(count)
  end
end
