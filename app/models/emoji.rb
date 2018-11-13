class Emoji
  COLLECTION = [
    'https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/120/samsung/148/rolling-on-the-floor-laughing_1f923.png',
    'https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/120/samsung/148/rolling-on-the-floor-laughing_1f923.png',
    'https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/120/samsung/148/rolling-on-the-floor-laughing_1f923.png',
    'https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/120/samsung/148/rolling-on-the-floor-laughing_1f923.png',
    'https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/120/samsung/148/rolling-on-the-floor-laughing_1f923.png',
    'https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/120/samsung/148/rolling-on-the-floor-laughing_1f923.png',
    'https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/120/samsung/148/rolling-on-the-floor-laughing_1f923.png',
    'https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/120/samsung/148/rolling-on-the-floor-laughing_1f923.png',
    'https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/120/samsung/148/rolling-on-the-floor-laughing_1f923.png',
    'https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/120/samsung/148/rolling-on-the-floor-laughing_1f923.png',
    'https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/120/samsung/148/rolling-on-the-floor-laughing_1f923.png',
    'https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/120/samsung/148/rolling-on-the-floor-laughing_1f923.png',
    'https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/120/samsung/148/rolling-on-the-floor-laughing_1f923.png',
    'https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/120/samsung/148/rolling-on-the-floor-laughing_1f923.png',
    'https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/120/samsung/148/rolling-on-the-floor-laughing_1f923.png'
  ]

  def self.random_images(count)
    COLLECTION.sample(count)
  end
end
