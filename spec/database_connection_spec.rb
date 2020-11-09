require_relative '../lib/database_connection'

describe DatabaseConnection  do
  subject { described_class }
  describe "#setup" do
    it "sets up a connection to a database" do
      expect(PG).to receive(:connect).with(dbname: 'makers_bnb_test')
      subject.setup('makers_bnb_test')
    end
  end
  describe ".conn" do
    it "is an instance of PG" do
      connection = subject.setup('makers_bnb_test')
      expect(subject.conn).to eq connection
    end
  end
  describe "#query" do
    it "is queries what's been asked for" do
      subject.setup('makers_bnb_test')
      expect(subject.conn).to receive(:exec).with('SELECT * FROM people;')
      subject.query('SELECT * FROM people;')
    end
  end
end
