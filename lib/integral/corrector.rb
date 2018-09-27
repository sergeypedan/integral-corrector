require "integral/corrector/version"

module Integral
  module Corrector

    PREPOSITIONS    = %w|а в во до ее её за и из их к мы на не но о об он от по с со то ты у я|
    PRE_CHARACTERS  = [" ", "(", "«"]
    POST_CHARACTERS = [")", "»"]
    MDASHES         = ["-", "–"]
    SPELLING_CORRECTIONS = [ ["т.е.", "т. е."] ]
    MONTH_NAMES = { generative: %W[января февраля марта апреля мая июня июля августа сентября октября ноября декабря] }

    module_function


    def upcased_prepositions
      PREPOSITIONS.map { |k| k.mb_chars.capitalize.to_s }
    end


    def all_prepositions
      PREPOSITIONS + upcased_prepositions
    end


    def fix_mdash(string)
      return "" if string.blank?

      MDASHES.each do |dash|
        string.gsub! " #{dash} ", " — "
      end

      return string
    end


    def fix_quotations(s)
      return "" if s.blank?
      s.gsub(" \"", " «")
       .gsub(/\"(?=[\.,])/, "»")
       .gsub(/^\"/, "«")
       .gsub(/(?<=[абвгдеёжзийклмнопрстуфхцчшщэюя])\"\s/i, "» ")
    end


    def fix_units(s)
      return "" if s.blank?
      s.gsub(" рублей", "\u{00A0}₽")
       .gsub(" руб.", "\u{00A0}₽")
       .gsub(" руб ", "\u{00A0}₽ ")
    end


    def fix_widow_prepositions(string)
      return "" if string.blank?

      PRE_CHARACTERS.each do |pre|
        all_prepositions.each do |k|
          string.gsub! "#{pre}#{k} ", "#{pre}#{k}\u{00A0}"
        end
      end

      return string
    end


    def fix_spelling(string)
      return "" if string.blank?

      # SPELLING_CORRECTIONS.each do |error_pair|
      #  ...
      # end

      string.gsub! "3-х мерное", "3-мерное"
      string.gsub! "все-таки", "всё-таки"
      string.gsub! /\sдает/, " даёт"
      string.gsub! /\sее\s/, " её "
      string.gsub! /Ее\s/, "Её "
      string.gsub! /\sеще\s/, " ещё "
      string.gsub! " Еще ", " Ещё "
      string.gsub! "зашел", "зашёл"
      string.gsub! /\sзвезд /, " звёзд "
      # string.gsub! / и\sо\s/, "и о "
      string.gsub! "и т.д.", "и т.\u{00A0}д."
      string.gsub! "и т.п.", "и т.\u{00A0}п."
      string.gsub! /\sнесет/, " несёт"
      string.gsub! "объем", "объём"
      string.gsub! "Объем", "Объём"
      string.gsub! "пришлем", "пришлём"
      string.gsub! "партнер", "партнёр"
      string.gsub! /\sсвое\s/, " своё "
      string.gsub! "своем", "своём"
      string.gsub! "т.е.", "т.\u{00A0}е."
      string.gsub! /у нее /, "у неё "
      string.gsub! "удаленно", "удалённо"
      string.gsub! "утонченная", "утончённая"
      string.gsub! "\sчье ", " чьё "

      string.gsub! "еверо-Запад",  "еверо-запад"
      string.gsub! "еверо-Восток", "еверо-восток"
      string.gsub! "го-Запад",  "го-запад"
      string.gsub! "го-Восток", "го-восток"
      string
    end


    def fix_date_before_month(string)
      return "" if string.blank?

      MONTH_NAMES[:generative].each do |month|
        string.gsub!  /(?<=\d) (?=#{month})/, "\u{00A0}"
      end

      string
    end


    def proofread(string)
      # string = fix_quotations(string)
      string = fix_mdash(string)
      string = fix_spelling(string)
      string = fix_widow_prepositions(string)
      string = fix_date_before_month(string)
      string = fix_units(string)
    end

  end
end
