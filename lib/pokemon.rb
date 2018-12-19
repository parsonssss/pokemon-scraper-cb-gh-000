class Pokemon
  attr_accessor :id, :name, :type, :db, :hp

  def initialize arg_hash
    arg_hash.each do |key, value|
      self.send("#{key}=", value)
    end
  end

  def self.save(name, type, database_connection)
    database_connection.execute('INSERT INTO pokemon (name, type) VALUES (?, ?)',name, type)
  end

  def self.find(id, deatbase_connection)
    pokemon_info = deatbase_connection.execute("SELECT * FROM pokemon WHERE id = ?", id).flatten
    self.new({id: pokemon_info[0], name: pokemon_info[1], type: pokemon_info[2],hp: pokemon_info[3],  db: deatbase_connection})
  end

  def alter_hp(new_hp, db)
    db.execute("UPDATE  pokemon SET hp = ? WHERE id = ?", new_hp, self.id)
  end

end
