local Translations = {
    error = {
        nodutyjob = 'このスタッシュを開くには専門の職でなければならない...',
    },
    interaction = {
        openstash = '~g~E~w~ - スタッシュを開く',
    }
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
