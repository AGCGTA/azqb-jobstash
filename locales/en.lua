local Translations = {
    error = {
        nodutyjob = 'It must be a professional position to open this stash...',
    },
    interaction = {
        openstash = '~g~E~w~ - Open stash',
    }
}

if GetConvar('qb_locale', 'en') == 'en' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
