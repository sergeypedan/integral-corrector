# frozen_string_literal: false

RSpec.describe Integral::Corrector do

  def tst(string)
    Integral::Corrector.fix_spelling(string)
  end

  describe "Spelling corrections" do

    it "corrects a pair" do
      expect( tst("Все-таки") ).to eq "Всё-таки"
    end

    it "corrects a pair" do
      expect( tst("и все-таки он") ).to eq "и всё-таки он"
    end

    it "corrects a pair" do
      expect( tst("партнерский материал") ).to eq "партнёрский материал"
    end

    it "corrects a pair" do
      expect( tst("при своем мнении") ).to eq "при своём мнении"
    end

    it "corrects a pair" do
      expect( tst("и чье это") ).to eq "и чьё это"
    end

    it "corrects a pair" do
      expect( tst("у нее ") ).to eq "у неё "
    end

    it "corrects a pair" do
      expect( tst("много звезд.") ).to eq "много звёзд."
    end

  end

end
