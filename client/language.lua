
------------------------------------------------------------------
-- This file is handeling the language for the script interface --
------------------------------------------------------------------
-- Just creating a table for our languages, dont touch.
Language = {};


------------------------
-- Language functions --
------------------------
--DONT TOUCH THIS


-- This function is changeing the language if there is one given in the file 'config.lua' by the setting 'Config.language'.
-- By default or when a language table is not existing, it will call the english table.
function SelectLanguage(languageString)
	for lang, translation in pairs(Language) do
		setmetatable(translation, {
			__index = function(t, k)
				return ("Missing translation: \"%s\""):format(k)
			end
		})
	end
	
	if (languageString and Language[languageString]) then 
		Config.strings = Language[languageString];
	else
		Config.strings = Language["english"];
	end
end
