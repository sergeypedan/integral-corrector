RSpec.describe Integral::TextCalculations do

  subject { described_class.text_to_a4(text) }

  context "text is nil" do
    let(:text) { nil }
    it { is_expected.to eq 0 }
  end

  context "text is empty string" do
    let(:text) { "" }
    it { is_expected.to eq 0 }
  end

  context "text is Array" do
    let(:text) { [1, 2, 3] }
    it "fails" do
      expect { subject }.to raise_exception ArgumentError
    end
  end

  context "text is a full string" do
    context "4-letter text" do
      let(:text) { "asdf" }
      it { is_expected.to eq 0 }
    end

    context "1801-letter text" do
      let(:text) { "a" * 1801 }
      it { is_expected.to eq 1.0 }
    end
  end

end
