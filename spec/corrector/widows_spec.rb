RSpec.describe Integral::Corrector do

	describe "Widow prepositions" do

		it "adds a non-breaking space after a 1-letter preposition" do
			string = " а "
			string = Integral::Corrector.fix_widow_prepositions(string)
			expect(string).to eq(" а ")
		end

		it "adds a non-breaking space after a 2-letter preposition" do
			string = " Не "
			string = Integral::Corrector.fix_widow_prepositions(string)
			expect(string).to eq(" Не ")
		end

		it "adds a non-breaking space after a preposition preceeded by (" do
			string = " (В "
			string = Integral::Corrector.fix_widow_prepositions(string)
			expect(string).to eq(" (В ")
		end

	end

end
