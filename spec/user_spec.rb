require_relative '../lib/user'

describe User do

  describe "#add" do
    it "creates new user" do
      user = User.add("example@email", "password")
      expect(user).to be_a User
      connection = PG.connect(dbname: 'makers_bnb_test')
      id =connection.exec("SELECT id FROM people WHERE email='example@email';")
      expect(user.id).to eq id[0]['id']
      expect(user.email).to eq "example@email"
    end
  end
  describe "#find" do
    it "finds the user from database by it's name" do
      user = User.add("example@email", "password")
      expect(User.find("example@email").email).to eq "example@email"
    end
  end
  describe "#user_find" do
    it "finds the user from database by it's id" do
      user = User.add("example@email", "password")
      expect(User.user_find(user.id).email).to eq "example@email"
    end
  end

  describe "#authenticate" do
    it "validate the user" do
      user = User.add("example@email", "password")
      expect(User.authenticate("example@email", "password").email).to eq "example@email"
      expect(User.authenticate("example@email", "password").id).to eq user.id
    end
    it "returns nil if incorrect email given" do
      expect(User.authenticate("fake_email", "password")).to eq nil
    end
    it "returns nil if incorrect password to existing email given" do
      user = User.add("example@email", "password")
      expect(User.authenticate("example@email", "wrong_password")).to eq nil
    end
  end

  describe "#validate" do

    it "returns true if correct password given" do
      expect(User.validate("password", "password")).to eq true
    end
    it "returns false if incorrect password given" do
      expect(User.validate("password", "password1")).to eq false
    end
  end

end
