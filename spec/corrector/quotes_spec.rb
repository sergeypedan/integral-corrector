# frozen_string_literal: true

RSpec.describe Integral::Corrector do

	def tst(string)
		Integral::Corrector.fix_quotations(string)
	end

	describe "quotations" do

		let(:domain) { "booking.com" }

		let(:html_tags) {
			[
				"<a href=\"http://#{domain}\">#{domain}</a>",
				"<a href=\"http://#{domain}\" target=\"_blank\">#{domain}</a>",
				"<a href=\"http://#{domain}\" target=\"_blank\" rel=\"noopener\">#{domain}</a>"
			]
		}

		it "replaces quotation after a lower-case cyrillic letter" do
			expect( tst("Три\" — любимое") ).to eq "Три» — любимое"
		end

		it "replaces quotation after an upper-case cyrillic letter" do
			expect( tst("ТРИ\" — любимое") ).to eq "ТРИ» — любимое"
		end

		it "replaces quotation after space" do
			expect( tst("дела. \"Тройки") ).to eq "дела. «Тройки"
		end

		it "replaces quotation before dot" do
			expect( tst("слово\".") ).to eq "слово»."
		end

		it "replaces quotation before comma" do
			expect( tst("слово\",") ).to eq "слово»,"
		end

		it "does not replace quotation in HTML tags" do
			html_tags.each do |tag|
				expect( tst(tag) ).to eq tag
			end
		end

	end

end
