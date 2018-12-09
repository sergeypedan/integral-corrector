# frozen_string_literal: false

RSpec.describe Integral::Corrector do

	def tst(string)
		Integral::Corrector.fix_mdash(string)
	end

	describe "m-dash" do

		it "replaces minus for m-dash" do
			expect( tst(" - ") ).to eq(" — ")
		end

		it "replaces n-dash for m-dash" do
			expect( tst(" – ") ).to eq(" — ")
		end

		it "replaces minus for m-dash" do
			expect( tst("") ).to eq("")
		end

	end

end
