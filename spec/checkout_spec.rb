require 'spec_helper'

describe "#checkout" do
  def pricing_rules
    file = File.read('discounts.json')
    JSON.parse(file)
  end

  context "no input provided" do
    it "should return 32.5 euro" do
      co = Checkout.new(pricing_rules)
      expect(co.total).to eq("Total: 0€")
    end
  end

  context "input is any one item only" do
    it "should return 32.5 euro" do
      co = Checkout.new(pricing_rules)
      co.scan("VOUCHER")
      expect(co.total).to eq("Total: 5€")
    end
  end

  context "input is VOUCHER, TSHIRT, MUG" do
    it "should return 32.5 euro" do
      co = Checkout.new(pricing_rules)
      co.scan("VOUCHER")
      co.scan("TSHIRT")
      co.scan("MUG")
      expect(co.total).to eq("Total: 32.5€")
    end
  end

  context "input is VOUCHER, TSHIRT, VOUCHER" do
    it "should return 32.5 euro" do
      co = Checkout.new(pricing_rules)
      co.scan("VOUCHER")
      co.scan("TSHIRT")
      co.scan("VOUCHER")
      expect(co.total).to eq("Total: 25€")
    end
  end

  context "input is TSHIRT, TSHIRT, TSHIRT, VOUCHER, TSHIRT" do
    it "should return 32.5 euro" do
      co = Checkout.new(pricing_rules)
      co.scan("TSHIRT")
      co.scan("TSHIRT")
      co.scan("TSHIRT")
      co.scan("VOUCHER")
      co.scan("TSHIRT")
      expect(co.total).to eq("Total: 81€")
    end
  end

  context "input is VOUCHER, TSHIRT, VOUCHER, VOUCHER, MUG, TSHIRT, TSHIRT" do
    it "should return 32.5 euro" do
      co = Checkout.new(pricing_rules)
      co.scan("VOUCHER")
      co.scan("TSHIRT")
      co.scan("VOUCHER")
      co.scan("VOUCHER")
      co.scan("MUG")
      co.scan("TSHIRT")
      co.scan("TSHIRT")
      expect(co.total).to eq("Total: 74.5€")
    end
  end

  context "input is invalid" do
    it "should InvalidItemError" do
      co = Checkout.new(pricing_rules)
      expect{ co.scan("invalid") }.to raise_error InvalidItemError
    end
  end

end
