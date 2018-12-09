require "integral/corrector/version"

module Integral
  module Corrector

    PREPOSITIONS    = %w|а в во до ее её за и из их к мы на не но о об он от по с со то ты у я|
    PRE_CHARACTERS  = [" ", "(", "«"]
    POST_CHARACTERS = [")", "»"]
    MDASHES         = ["-", "–"]
    MONTH_NAMES     = { generative: %W[января февраля марта апреля мая июня июля августа сентября октября ноября декабря] }
    SPELLING_CORRECTIONS = [
      ["Все-таки", "Всё-таки"],
      [/\sвсе-таки/, " всё-таки"],
      [/\sдает/, " даёт"],
      [/\sее\s/, " её "],
      [/Ее\s/, "Её "],
      [/\sеще\s/, " ещё "],
      [" Еще ", " Ещё "],
      ["зашел", "зашёл"],
      [/\sзвезд /, " звёзд "],
      [/\sзвезд\./, " звёзд."],
      [/\sзвезд\,/, " звёзд,"],
      ["и т.д.", "и т.\u{00A0}д."],
      ["и т.п.", "и т.\u{00A0}п."],
      [/\sнесет/, " несёт"],
      [/\sобъем/, " объём"],
      ["Объем", "Объём"],
      [/\sпришлем/, " пришлём"],
      ["партнер", "партнёр"],
      [/\sсвое\s/, " своё "],
      ["своем", "своём"],
      ["т.е.", "т.\u{00A0}е."],
      [" нее ", " неё "],
      ["удаленн", "удалённ"],
      ["утонченн", "утончённ"],
      ["\sчье ", " чьё "]
    ]

    module_function


    def upcased_prepositions
      PREPOSITIONS.map { |k| k.capitalize.to_s }
    end


    def all_prepositions
      PREPOSITIONS + upcased_prepositions
    end


    def fix_mdash(string)
      return "" if string == "" || string.nil?

      MDASHES.each do |dash|
        string.gsub! " #{dash} ", " — "
      end

      return string
    end


    def fix_quotations(s)
      return "" if s == ""
      s.gsub(" \"", " «")
       .gsub(/\"(?=[\.,])/, "»")
       .gsub(/^\"/, "«")
       .gsub(/(?<=[абвгдеёжзийклмнопрстуфхцчшщэюя])\"\s/i, "» ")
    end


    def fix_units(string)
      return "" if string == "" || string.nil?
      string.gsub(" рублей", "\u{00A0}₽")
            .gsub(" руб.", "\u{00A0}₽")
            .gsub(" руб ", "\u{00A0}₽ ")
    end


    def fix_widow_prepositions(string)
      return "" if string == "" || string.nil?

      PRE_CHARACTERS.each do |pre|
        all_prepositions.each do |k|
          string.gsub! "#{pre}#{k} ", "#{pre}#{k}\u{00A0}"
        end
      end

      return string
    end


    def fix_spelling(string)
      return "" if string == "" || string.nil?

      SPELLING_CORRECTIONS.each do |incorrect, correct|
        string.gsub! incorrect, correct
      end

      return string
    end


    def fix_date_before_month(string)
      return "" if string == "" || string.nil?

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
      string
    end

  end
end
