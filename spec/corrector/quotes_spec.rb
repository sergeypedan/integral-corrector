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

		context "between a space and a character" do
			it "replaces quotation" do
				expect( tst("дела. \"Тройки") ).to eq "дела. «Тройки"
			end
		end

		context "before a punctuation sign" do
			let(:punctuation_literals) { %w[. , ? !] }

			it "replaces quotation" do
				punctuation_literals.each do |literal|
					expect( tst("слово\"#{literal}") ).to eq "слово»#{literal}"
				end
			end
		end

		context "at the beginning of line" do
			it "replaces quotation" do
				expect( tst("\"Сон в летнюю ночь") ).to eq "«Сон в летнюю ночь"
			end
		end

		context "at the end of line" do
			it "replaces quotation" do
				expect( tst("в летнюю ночь\"") ).to eq "в летнюю ночь»"
			end
		end

		context "in HTML attributes" do
			let(:domain) { "https://booking.com" }
			let(:html_tags) {
				[
					"<a href=\"#{domain}\">#{domain}</a>",
					"<a href=\"#{domain}\" target=\"_blank\">#{domain}</a>",
					"<a href=\"#{domain}\" target=\"_blank\" rel=\"noopener\">#{domain}</a>",
					"<img=\"#{domain}\" alt=\"A text\" />"
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
