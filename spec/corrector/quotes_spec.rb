# frozen_string_literal: true

RSpec.describe Integral::Corrector do

	def tst(string)
		Integral::Corrector.fix_quotations(string)
	end

	describe "quotations" do

		context "after a lower-case cyrillic letter" do
			it "replaces quotation" do
				expect( tst("Три\" — любимое") ).to eq "Три» — любимое"
			end
		end

		context "after an upper-case cyrillic letter" do
			it "replaces quotation" do
				expect( tst("ТРИ\" — любимое") ).to eq "ТРИ» — любимое"
			end
		end

		context "after a space" do
			it "replaces quotation" do
				expect( tst("дела. \"Тройки") ).to eq "дела. «Тройки"
			end
		end

		context "before a dot" do
			it "replaces quotation" do
				expect( tst("слово\".") ).to eq "слово»."
			end
		end

		context "before a comma" do
			it "replaces quotation" do
				expect( tst("слово\",") ).to eq "слово»,"
			end
		end

		context "in HTML attributes" do
			let(:domain) { "booking.com" }

			let(:html_tags) {
				[
					"<a href=\"http://#{domain}\">#{domain}</a>",
					"<a href=\"http://#{domain}\" target=\"_blank\">#{domain}</a>",
					"<a href=\"http://#{domain}\" target=\"_blank\" rel=\"noopener\">#{domain}</a>"
				]
			}
			it "does not replace quotation" do
				html_tags.each do |tag|
					expect( tst(tag) ).to eq tag
				end
			end
		end

	end

end
