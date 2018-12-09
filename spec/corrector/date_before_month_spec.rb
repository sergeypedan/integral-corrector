RSpec.describe Integral::Corrector do

	describe "Date before month" do

		subject { Integral::Corrector.fix_date_before_month(string) }

		context "in a sentence with 1 date+month entry" do
			let(:string) { "25 января" }
			it "adds a non-breaking space between a date and a month" do
				is_expected.to eq "25 января"
			end
		end

		context "in a sentence with 2 date+month entries" do
			let(:string) { "8 января по 9 мая 2016" }
			it "adds a non-breaking space between a date and a month" do
				is_expected.to eq "8 января по 9 мая 2016"
			end
		end

	end

end
