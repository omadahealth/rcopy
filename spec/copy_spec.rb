require 'spec_helper'

describe Rcopy do
  let(:source_db) { Redis.new(db: 10) }
  let(:destination_db) { Redis.new(db: 11) }
  let(:copier) { Rcopy::Copier.new(source_db) }
  
  before { source_db.flushdb }
  before { destination_db.flushdb }
  describe "#copy_to" do
    
    subject { copier.copy_to(destination_db) }
  
    it 'works without any keys' do
      subject
      expect(source_db.keys).to match_array destination_db.keys
    end

    context "non-empty destination db" do
      before { destination_db.set "some", "junk" }
      
      it "removes old keys" do
        expect{ subject }.to change { destination_db.keys.size }.to 0
      end
    end

    context "with a key" do
      let(:key) { 'foo' }

      context "with string value" do
        before { source_db.set(key, value) }

        let(:value) { 'bar' }
        it "copies" do
          expect { subject}.to change { destination_db.get(key) }.from(nil).to(value)
        end

        context "with a ttl" do
          before { source_db.expire key, 100}

          it "has an appropriate ttl" do
            expect { subject }.to change { destination_db.ttl(key) }.from(-2).to(100)
          end
        end

      end
 
      context "with a hash value" do
        let(:field) { :some_field }
        let(:value) { :some_value }
        before { source_db.hset(key, field, value) }

        it "copies" do
          expect { subject }.to change { destination_db.hgetall(key) }.from({}).to("some_field" => "some_value")
        end
      end

      context "with a hash value" do
        let(:field) { :some_field }
        let(:value) { :some_value }
        before { source_db.hset(key, field, value) }

        it "copies" do
          expect { subject }.to change { destination_db.hgetall(key) }.from({}).to("some_field" => "some_value")
        end
      end

      context "with a list value" do
        let(:list_entry) { "some_entry" }
        before { source_db.lpush(key, list_entry) }

        it "copies" do
          expect { subject }.to change { destination_db.llen(key) }.from(0).to(1)
          expect(destination_db.lpop key ).to eq list_entry
        end
      end

      context "with a set value" do
        let(:set_entry) { "some_entry" }
        before { source_db.sadd(key, set_entry) }

        it "copies" do
          expect { subject }.to change { destination_db.smembers(key) }.from([]).to([set_entry])
        end
      end

    end
  end
end